from azure.storage.table import TableService
import os
import datetime
import time
import re
import logging


class storage_az_table():
    

    ##################################################################
    # BEGIN - Common methods to implement storage interface
    
    def __init__(self):
        account_name = 'shkola'
        account_key = os.environ['SHKOLA_AZ_TABLE_KEY']
        self.default_partition_key = "USER"
        self.users_table_name = 'users'
        self.responses_table_name = 'responses'
        self.table_service = TableService(account_name, account_key)

        try:
            self.table_service.create_table(self.users_table_name)
        except Exception as err:
            logging.exception('Error creating table, ' + self.users_table_name + 'check if it already exists')

        try:
            self.table_service.create_table(self.responses_table_name)
        except Exception as err:
            logging.exception('Error creating table, ' + self.responses_table_name + 'check if it already exists')
            

            
    def get_user_data(self, user_id):
        logging.debug("*** get_user_data")
        partition_key = self.default_partition_key

        try:
            entity = table_service.get_entity(self.users_table_name, partition_key, user_id)
        except Exception as err:
            logging.exception('Error querying table ' + self.user_table_name + ': {}/{}'.format(partition_key, user_id))
            return None

        entity["user_id"] = user_id
        return entity
        
        

    def update_user(self, user_id, name=None, email=None,
                    remote_ip=None, user_agent=None, last_accessed=None):
        #logging.debug("*** azure table update_user")
        properties = dict()
            
        # Nothing better at the moment:
        properties['PartitionKey'] = self.default_partition_key
        properties['RowKey'] = user_id
        properties['user_id'] = user_id
        
        if name is not None:
            properties["name"] = name
        if email is not None:
            properties["email"] = email
        if remote_ip is not None:
            properties["remote_ip"] = remote_ip
        if user_agent is not None:
            properties["user_agent"] = user_agent
        if last_accessed is not None:
            properties["last_accessed"] = last_accessed

        try:
            self.table_service.insert_or_merge_entity(self.users_table_name, properties)
        except Exception as err:
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
        

            
    def print_all_responses(self, user_id = None):
        if user_id is None:
            req = ""
        else:
            req = "PartitionKey = {}".format(user_id)


        entries = self.table_service.query_entities(self.responses_table_name, req)


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
        entries = self.table_service.query_entities(self.users_table_name, "")
        print("           USER ID                    NAME                      EMAIL                 LAST ACCESSED          REMOTE IP                      USER AGENT          ")
        for row in entries:
            print("{:^30} {:^20} {:^30} {:^20} {:^20} {:^40}".format(
                row['user_id'],
                row['name'],
                row['email'],
                time.strftime("%d-%m-%y %H:%M:%S", time.localtime(row['last_accessed'])),
                row['remote_ip'],
                row['user_agent']))
        
        print("\n")
        


        
if __name__ == '__main__':
    
    storage = storage_az_table()
    print("Opened storage")
    
    wipe_all = False
    #wipe_all = True

    add_test_data = False
    #add_test_data = True

    # WARNING: Delete table takes 40s, so everything else will fail
    # Rerun with wipe_all disabled to test
    if wipe_all:
        print("Wiping out existing data: ", end="")
        storage.delete_all_tables()
        print("Done")



    if add_test_data:
        epoch_ms = int(time.time())
        delta = 3600

        user0 = storage.insert_user_id("test0")
        user1 = storage.insert_user_id("test1")
        storage.update_user(user0, name="User0", email="Email0", remote_ip="100.200.300.400", user_agent="agent0", last_accessed=epoch_ms)
        storage.update_user(user1, name="User1", email="Email1", remote_ip="200.300.400.500", user_agent="agent1", last_accessed=epoch_ms)
    
        response = {"user_id" : user0, "question_id": "q0", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
        storage.record_response(response)

        response = {"user_id" : user0, "question_id": "q1", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms+delta, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
        storage.record_response(response)

        response = {"user_id" : user1, "question_id": "q0", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
        storage.record_response(response)

        response = {"user_id" : user1, "question_id": "q1", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms+delta, "duration": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
        storage.record_response(response)


    storage.print_all_users()

    storage.print_all_responses()

    #storage.print_all_responses("local:Korisnik1")

    

