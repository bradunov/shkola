from azure.cosmosdb.table.tableservice import TableService
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

        try:
            self.table_service.create_table(self.users_table_name)
        except Exception:
            logging.exception('Error creating table, ' + self.users_table_name + 'check if it already exists')

        try:
            self.table_service.create_table(self.responses_table_name)
        except Exception:
            logging.exception('Error creating table, ' + self.responses_table_name + 'check if it already exists')
            

            
    def get_user_data(self, user_id):
        logging.debug("*** get_user_data")
        partition_key = self.default_partition_key

        try:
            entity = self.table_service.get_entity(self.users_table_name, partition_key, user_id)
        except Exception:
            logging.exception('Error querying table ' + self.user_table_name + ': {}/{}'.format(partition_key, user_id))
            return None

        entity["user_id"] = user_id
        return entity
        
        

    def update_user(self, user_id, name=None, email=None,
                    remote_ip=None, user_agent=None, user_language=None, last_accessed=None):
        properties = dict()
            
        # Nothing better at the moment:
        properties['PartitionKey'] = self.default_partition_key
        properties['RowKey'] = user_id
        properties['user_id'] = user_id
        properties['user_language'] = user_language
        
        if name is not None:
            properties["name"] = name
        if email is not None:
            properties["email"] = email
        if remote_ip is not None:
            properties["remote_ip"] = remote_ip
        if user_agent is not None:
            properties["user_agent"] = user_agent
        if user_language is not None:
            properties["user_language"] = user_language
        if last_accessed is not None:
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
        # Remove special characters not allowed in Azure RowKey
        response['RowKey'] = re.sub("[\ /?#]", "", response['RowKey'])

        
        #logging.debug("*** record response:", response)

        try:
            self.table_service.insert_entity(self.responses_table_name, response)
        except Exception as err:
            logging.exception('Error adding response: ' + str(err))



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


    
    def delete_all_tables(self):
        try:
            self.table_service.delete_table(self.users_table_name)
        except Exception as err:
            logging.exception('Error deleting table, ' + self.users_table_name + ': ' + str(err))

        try:
            self.table_service.delete_table(self.responses_table_name)
        except Exception as err:
            logging.exception('Error deleting table, ' + self.responses_table_name + ':' + str(err))
        



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
            print("{:^30} {:^20} {:^30} {:^20} {:^20} {:^40}".format(
                row['user_id'],
                row['name'],
                row['email'],
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

        # TBD DEBUG: temporary cleanup foer various user names we used over time
        req = "((PartitionKey eq '{}') or (PartitionKey eq 'local:{}'))".format(u_id, u_id) 

        if from_date:
            if len(req) > 0:
                req = req + " and "
            req = req + "(Timestamp ge datetime'{}')".format(from_date)

        #print(req)

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
    #     storage.update_user(user0, name="User0", email="Email0", remote_ip="100.200.300.400", user_agent="agent0", user_language="", last_accessed=epoch_ms)
    #     storage.update_user(user1, name="User1", email="Email1", remote_ip="200.300.400.500", user_agent="agent1", user_language="", last_accessed=epoch_ms)
    
    #     response = {"user_id" : user0, "question_id": "q0", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    #     storage.record_response(response)

    #     response = {"user_id" : user0, "question_id": "q1", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms+delta, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    #     storage.record_response(response)

    #     response = {"user_id" : user1, "question_id": "q0", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    #     storage.record_response(response)

    #     response = {"user_id" : user1, "question_id": "q1", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms+delta, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    #     storage.record_response(response)


    #storage.print_all_users()

    #storage.print_all_responses()


    #storage.get_question_stats("fractions/q00022")
    #print(storage.get_question_stats("fractions/q00022", "2020-03-01T00:00:00.000Z"))

    print(storage.get_user_stats("Petar"))
    #print(storage.get_question_stats("fractions/q00022", "2020-03-01T00:00:00.000Z"))


    #storage.print_all_responses("local:Korisnik1")

    

