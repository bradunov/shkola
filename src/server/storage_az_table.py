from azure.cosmosdb.table.tableservice import TableService
from azure.common import AzureMissingResourceHttpError

from .helpers import encode_dict, decode_dict

import os
import time
import re
import logging


class Storage_az_table():
    

    ##################################################################
    # BEGIN - Common methods to implement storage interface
    
    def __init__(self):
        connection_string = os.environ['SHKOLA_AZ_TABLE_CONN_STR']
        self.table_service = TableService(connection_string=connection_string)

        self.default_partition_key = "USER"
        self.users_table_name = 'users'
        self.responses_table_name = 'responses'
        self.sessions_table_name = 'sessions'
        self.feedbacks_table_name = 'feedbacks'

        tables = [self.users_table_name, self.responses_table_name, 
                  self.sessions_table_name, self.feedbacks_table_name]

        for table in tables:
            self.table_service.create_table(table)
            

    def get_user(self, user_id):
        partition_key = self.default_partition_key

        try:
            entity = self.table_service.get_entity(self.users_table_name, partition_key, user_id)
        except AzureMissingResourceHttpError:
            return None

        entity["user_id"] = user_id
        return entity
        

    def update_user(self, user_id, name=None, remote_ip=None, 
                    user_agent=None, picture=None, user_language=None, last_accessed=None):
        properties = dict()
            
        # Nothing better at the moment:
        properties['PartitionKey'] = self.default_partition_key
        properties['RowKey'] = user_id
        properties['user_id'] = user_id
        properties['user_language'] = user_language
        
        properties["name"] = name
        properties["remote_ip"] = remote_ip
        properties["user_agent"] = user_agent
        properties["picture"] = picture
        properties["user_language"] = user_language
        properties["last_accessed"] = last_accessed

        logging.debug("azure table update_user %s: %s", str(name), str(properties))

        try:
            self.table_service.insert_or_merge_entity(self.users_table_name, properties)
        except Exception:
            logging.exception('Error adding to table ' + self.users_table_name + ' record: {}'.format(properties))
        

    def insert_user_id(self, user_id):
        self.update_user(user_id)
        return user_id
            

    def record_response(self, response):
        response['PartitionKey'] = response['user_id']
        response['RowKey'] = response['question_id'] + "|" + str(response['time']) + "|" + str(response['duration'])

        # Remove special characters not allowed in Azure PartitionKey and RowKey
        response['PartitionKey'] = re.sub("[\ /?#]", "_", response['PartitionKey'])
        response['RowKey'] = re.sub("[\ /?#]", "_", response['RowKey'])
        
        #logging.debug("*** record response: {}".format(response))

        try:
            self.table_service.insert_entity(self.responses_table_name, response)
        except Exception as err:
            logging.exception('Error adding response: {}\n\n{}' + str(response, err))


    def record_feedback(self, response):
        fb_time = int(time.time() * 1000)

        response['PartitionKey'] = response['question_id']
        response['RowKey'] = response['type'] + "|" + response['list_id'] + "|" + str(fb_time)

        # Remove special characters not allowed in Azure PartitionKey and RowKey
        response['PartitionKey'] = re.sub("[\ /?#]", "_", response['PartitionKey'])
        response['RowKey'] = re.sub("[\ /?#]", "_", response['RowKey'])

        
        logging.debug("*** record feedback: {}".format(response))

        try:
            self.table_service.insert_entity(self.feedbacks_table_name, response)
        except Exception as err:
            logging.exception('Error adding response: ' + str(err))


    def update_session(self, session_id, data = {}):
        assert session_id is not None
        assert data['state_id'] is not None

        properties = {
            'PartitionKey': session_id,
            'RowKey': "",
            'data': encode_dict(data['data']),
            'user_id': data['user_id'],
            'state_id': data['state_id'],
            'valid': data['valid']
        }

        try:
            self.table_service.insert_or_merge_entity(self.sessions_table_name, properties)
        except Exception:
            logging.exception('Error adding to table ' + self.sessions_table_name + ' record: {}'.format(properties))


    def get_session(self, session_id):
        try:
            entity = self.table_service.get_entity(self.sessions_table_name, session_id, "")
        except AzureMissingResourceHttpError:
            return None

        # Azurite simulator returns an empty entity instead of exception, so check here
        if "user_id" not in entity.keys():
            return None

        # Compatibility: old records don't have state_id, valid
        if not "state_id" in entity:
            entity['state_id'] = None

        if not "valid" in entity:
            entity["valid"] = True

        return {
            # Convert "None" to None, see above
            # "user_id": entity["user_id"] if (not entity["user_id"] == "None") else None,
            "user_id": entity["user_id"],
            "data": decode_dict(entity["data"]),
            "state_id": entity["state_id"],
            "valid": entity["valid"]
        }


    # END - Common methods to implement storage interface
    ##################################################################



    # Doesn't really work
    # def wipe_tables(self):
    #     try:
    #         self.table_service.delete_entity(self.users_table_name, "", "")
    #     except Exception as err:
    #         print('Error wiping table, ' + self.users_table_name + ': ' + str(err))

    #     try:
    #         self.table_service.delete_entity(self.responses_table_name, "", "")
    #     except Exception as err:
    #         print('Error wiping table, ' + self.responses_table_name + ':' + str(err))


    
    # def delete_all_tables(self):
    #     try:
    #         self.table_service.delete_table(self.users_table_name)
    #     except Exception as err:
    #         logging.exception('Error deleting table, ' + self.users_table_name + ': ' + str(err))

    #     try:
    #         self.table_service.delete_table(self.responses_table_name)
    #     except Exception as err:
    #         logging.exception('Error deleting table, ' + self.responses_table_name + ':' + str(err))
        



    def get_all_responses(self, user_id = None):
        if user_id is None:
            req = ""
        else:
            req = "PartitionKey = {}".format(user_id)


        entries = self.table_service.query_entities(self.responses_table_name, req)

        return entries




    def get_all_users(self):
        entries = self.table_service.query_entities(self.users_table_name, "")

        return entries

            


    def print_all_responses(self, user_id = None):
        entries = self.get_all_responses(user_id)


        if user_id is None:
            print("            USER_ID            ", end='')
        else:
            print("USER_ID = {}\n".format(user_id))

        print("     QUESTION_ID          LIST_ID     RESPONSE_TYPE           TIME                DURATION      CORRECT   INCORRECT                QUESTIONS")
        for response in entries:
            if user_id is None:
                print("{:^30} ".format(response['question_id']), end='')                                                    # UID
            print("{:^20} ".format(response['user_id']), end='')                                                            # QID
            print("{:^16} ".format(response['list_id']), end='')                                                            # List ID
            print("{:^12} ".format(response['response_type']), end='')                                                      # RESPONSE TYPE
            print("{:^26} ".format(time.strftime("%d-%m-%y %H:%M:%S", time.localtime(int(response['time'])))), end='')      # TIME
            print("{:^16} ".format(response['duration']), end='')                                                           # DURATION
            print("{:^10} ".format(response['correct']), end='')                                                            # CORRECT
            print("{:^10} ".format(response['incorrect']), end='')                                                          # INCORRECT
            print("{:^38} ".format(response['questions']))                                                                  # QUESTIONS

        print("\n")



    def print_all_users(self):
        entries = self.get_all_users()

        print("           USER ID                    NAME                      EMAIL                 LAST ACCESSED          REMOTE IP                      USER AGENT             USER LANGUAGE")
        for row in entries:
            print("{:^30} {:^20} {:^20} {:^20} {:^40} {:^40}".format(
                row['user_id'],
                row['name'],
                time.strftime("%d-%m-%y %H:%M:%S", time.localtime(row['last_accessed'])),
                row['remote_ip'] if 'remote_ip' in row.keys() else "",
                row['user_agent'] if 'user_agent' in row.keys() else "",
                row['user_language'] if 'user_language' in row.keys() else ""
            ))
        
        print("\n")



    def get_question_stats(self, q_id=None, from_date=None):
        req = ""

        if q_id:
            # Remove / from q_id
            mq_id = ("".join("fractions/q00022".split("/")))
            req = req + "((RowKey ge '{}|') and (RowKey lt '{}{}'))".format(mq_id, mq_id, chr(255)) 

        if from_date:
            if len(req) > 0:
                req = req + " and "
            req = req + "(Timestamp ge datetime'{}')".format(from_date)

        #print(req)

        entries = self.table_service.query_entities(self.responses_table_name, req)

        result = []
        for row in entries:
            # TBD DEBUG: temporary cleanup foer various user names we used over time
            if "user_id" not in row.keys() or \
                "local:Korisnik" in row["user_id"] or \
                "UNKNOWN" in row["user_id"] or \
                "Zomebody" in row["user_id"]:
                continue

            result.append(row)

        return result




    def get_user_stats(self, u_id, from_date=None):

        # TBD DEBUG: temporary cleanup for various user names we used over time
        # Remove (PartitionKey eq 'local:{}') in future
        req = "((PartitionKey eq '{}') or (PartitionKey eq 'local:{}'))".format(u_id, u_id) 

        if from_date:
            if len(req) > 0:
                req = req + " and "
            req = req + "(Timestamp ge datetime'{}')".format(from_date)

        #print(req)
        logging.info("\n\nBBBBBBBB: {}\n\n".format(req))

        entries = self.table_service.query_entities(self.responses_table_name, req)

        result = []
        for row in entries:
            result.append(row)

        return result


        
        
if __name__ == '__main__':
    
    storage = Storage_az_table()
    print("Opened storage")
    
    wipe_all = False
    #wipe_all = True

    add_test_data = False
    #add_test_data = True

    # WARNING: Delete table takes 40s, so everything else will fail
    # Rerun with wipe_all disabled to test
    # if wipe_all:
    #     print("Wiping out existing data: ", end="")
    #     storage.delete_all_tables()
    #     print("Done")



    # if add_test_data:
    #     epoch_ms = int(time.time())
    #     delta = 3600

    #     user0 = storage.insert_user_id("test0")
    #     user1 = storage.insert_user_id("test1")
    #     storage.update_user(user0, name="User0", remote_ip="100.200.300.400", user_agent="agent0", user_language="", last_accessed=epoch_ms)
    #     storage.update_user(user1, name="User1", remote_ip="200.300.400.500", user_agent="agent1", user_language="", last_accessed=epoch_ms)
    
    #     response = {"user_id" : user0, "question_id": "q0", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    #     storage.record_response(response)

    #     response = {"user_id" : user0, "question_id": "q1", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms+delta, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    #     storage.record_response(response)

    #     response = {"user_id" : user1, "question_id": "q0", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    #     storage.record_response(response)

    #     response = {"user_id" : user1, "question_id": "q1", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms+delta, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    #     storage.record_response(response)



    print_all_data = True
    if print_all_data:
        storage.print_all_users()
        storage.print_all_responses()


    print_question_stats = False

    if print_question_stats:
        #storage.get_question_stats("fractions/q00022")
        print(storage.get_question_stats("fractions/q00022", "2020-03-01T00:00:00.000Z"))


    print_user_stats = False
    if print_user_stats:
        print(storage.get_user_stats("Petar"))
        #print(storage.get_question_stats("fractions/q00022", "2020-03-01T00:00:00.000Z"))


    #storage.print_all_responses("local:Korisnik1")

    

