import sqlite3
import datetime

    



class storage(object):
    db = None
    dbname = "shkola.sql"
    
    def __init__(self):
        self.db = sqlite3.connect(self.dbname, detect_types=sqlite3.PARSE_DECLTYPES)
        self.create_tables()


    def close(self):
        self.db.close()
        

    def check_table_exists(self, table_name):
        cursor = self.db.cursor()
        try:
            cursor.execute('''SELECT * FROM {}'''.format(table_name))
            record = cursor.fetchone()
        #TBD:
        #except sqlite3.IntegrityError:
        except e:
            return False
        return True


    
    def delete_table(self, table_name):
        cursor = self.db.cursor()
        cursor.execute('''DROP TABLE {}'''.format(table_name))
        self.db.commit()



    def delete_all_tables(self):
        self.delete_table("users")
        self.delete_table("responses")
        
        

    def create_tables(self):

        # Users
        cursor = self.db.cursor()
        cursor.execute('''
              CREATE TABLE IF NOT EXISTS 
                     users(id INTEGER PRIMARY KEY AUTOINCREMENT, 
                                 google_id INTEGER, 
                                 temp_id INTEGER, 
                                 remote_ip TEXT,
                                 user_agent TEXT)
        ''')
        self.db.commit()


        # Responses
        cursor = self.db.cursor()
        cursor.execute('''
              CREATE TABLE IF NOT EXISTS 
                     responses(id INTEGER PRIMARY KEY AUTOINCREMENT, 
                                     user_id INTEGER, 
                                     question_id TEXT, 
                                     time TIMESTAMP, 
                                     duration TIME, 
                                     attempt INTEGER, 
                                     correct INTEGET, 
                                     incorrect INTEGER,
                                     questions TEXT)
        ''')
        self.db.commit()
            


            
    def get_user_by_temp_id(self, temp_id):
        cursor = self.db.cursor()
        cursor.execute('''SELECT id FROM users where temp_id == (?)''', (temp_id,))
        user = cursor.fetchone()
        if user is not None:
            return user[0]
        else:
            cursor.execute(''' INSERT INTO users(google_id, temp_id, remote_ip, user_agent) VALUES(?,?,?,?) ''', (0, temp_id, "", ""))
            self.db.commit()
            return cursor.lastrowid


    def update_user_remote_ip(self, user_id, remote_ip):
        cursor = self.db.cursor()
        cursor.execute(''' UPDATE users SET remote_ip == ? WHERE id == ? ''', (remote_ip, user_id))
        self.db.commit()

    def update_user_remote_agent(self, user_id, user_agent):
        cursor = self.db.cursor()
        cursor.execute(''' UPDATE users SET user_agent == ? WHERE id == ? ''', (user_agent, user_id))
        self.db.commit()

        
        

    def record_response(self, response):
        cursor = self.db.cursor()
        cursor.execute(''' INSERT INTO responses(user_id, question_id, time, duration, attempt, correct, incorrect, questions)
                  VALUES(:user_id, :question_id, :time, :duration, :attempt, :correct, :incorrect, :questions)''', \
                       response)
        self.db.commit()



        
    def print_all_responses(self, user_id = None):
        cursor = self.db.cursor()
        if user_id is None:
            cursor.execute(''' SELECT * from responses ''')
        else:
            cursor.execute(''' SELECT * from responses WHERE user_id == ?''', (user_id,))


        if user_id is None:
            print("       USER_ID ", end='')
        else:
            print("USER_ID = {}\n".format(user_id))
            print("       ", end='')

        print("QUESTION_ID         TIME           DURATION    ATTEMPT    CORRECT   INCORRECT                QUESTIONS")
        for row in cursor:
            print("{:5}: ".format(row[0]), end='') 
            if user_id is None:
                print("{:^7} ".format(row[1]), end='')                   # UID
            print("{:^12} ".format(row[2]), end='')                      # QID
            print(" {:%d-%m-%y %H:%M:%S}  ".format(row[3]), end='')      # TIME
            print("{:^13} ".format(row[4]), end='')                      # DURATION
            print("{:^9} ".format(row[5]), end='')                       # ATTEMPT
            print("{:^10} ".format(row[6]), end='')                      # CORRECT
            print("{:^10} ".format(row[7]), end='')                      # INCORRECT
            print("{:^38} ".format(row[8]))                              # QUESTIONS

        print("\n")



    def print_all_users(self):
        cursor = self.db.cursor()
        cursor.execute(''' SELECT * from users ''')
        print("   ID     GOOGLE ID     TEMP ID         REMOTE IP                     USER AGENT")
        for row in cursor:
            print("{:^8} {:^14} {:^10} {:^20} {:^40}".format(row[0], row[1], row[2], row[3], row[4]))
        
        print("\n")

        
            

if __name__ == '__main__':
    
    storage = storage()

    wipe_all = True
    #wipe_all = False

    if wipe_all:
        storage.delete_all_tables()
        storage.create_tables()
    
    user0 = storage.get_user_by_temp_id(0)
    user1 = storage.get_user_by_temp_id(1)
    storage.update_user_remote_ip(user0, "100.200.300.400")
    storage.update_user_remote_ip(user1, "200.300.400.500")
    storage.update_user_remote_agent(user0, "agent0")
    storage.update_user_remote_agent(user1, "agent1")


    now = datetime.datetime.now()
    delta = datetime.timedelta(hours=1, minutes=2, seconds=3)
    
    response = {"user_id" : user0, "question_id": 0, "time": now, "duration": 0, "attempt": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    storage.record_response(response)

    response = {"user_id" : user0, "question_id": 1, "time": now+delta, "duration": 0, "attempt": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    storage.record_response(response)


    response = {"user_id" : user1, "question_id": 0, "time": now, "duration": 0, "attempt": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    storage.record_response(response)

    response = {"user_id" : user1, "question_id": 1, "time": now+delta, "duration": 0, "attempt": 0, "correct": 0, "incorrect": 0, "questions": "abc"}
    storage.record_response(response)


    storage.print_all_users()

    storage.print_all_responses()

    #storage.print_all_responses(1)

    

