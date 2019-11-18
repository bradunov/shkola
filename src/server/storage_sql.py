import sqlite3
import datetime
import time



class storage_sql:
    db = None
    dbname = "shkola.sql"


    ##################################################################
    # BEGIN - Common methods to implement storage interface
    
    def __init__(self):
        self.db = sqlite3.connect(self.dbname, detect_types=sqlite3.PARSE_DECLTYPES, check_same_thread=False)
        self.create_tables()


    def get_user_by_id(self, user_id):
        cursor = self.db.cursor()
        cursor.execute('''SELECT user_id FROM users where user_id == (?)''', (user_id,))
        user = cursor.fetchone()
        if user is not None:
            return user_id
        else:
            cursor.execute(''' INSERT INTO users(user_id) VALUES(?) ''', (user_id, ))
            self.db.commit()
            return user_id


    def get_user_data(self, user_id):
        cursor = self.db.cursor()
        cursor.execute('''SELECT * FROM users where user_id == (?)''', (user_id,))
        user = cursor.fetchone()
        if user is not None:
            return {"user_id": row[0],
                    "name": row[1],
                    "email": row[2],
                    "remote_ip":row[3],
                    "user_agent":row[4],
                    "last_accessed":row[5]}
        else:
            return None
        
        

    def update_user(self, user_id, name=None, email=None,
                    remote_ip=None, user_agent=None, last_accessed=None):
        first = True
        cursor = self.db.cursor()
        query = "UPDATE users SET "
        vals = []
        if name is not None:
            query = query + ("" if first else ",") + " name == ?"
            first = False;
            vals.append(name)
        if email is not None:
            query = query + ("" if first else ",") + " email == ?"
            first = False
            vals.append(email)
        if remote_ip is not None:
            query = query + ("" if first else ",") + " remote_ip == ?"
            first = False
            vals.append(remote_ip)
        if user_agent is not None:
            query = query + ("" if first else ",") + " user_agent == ?"
            first = False
            vals.append(user_agent)
        if last_accessed is not None:
            query = query + ("" if first else ",") + " last_accessed == ?"
            first = False
            vals.append(last_accessed)
        vals.append(user_id)
        query = query + " WHERE user_id == ?"
        tvals = tuple(vals)
        
        cursor.execute(query, tvals)
        self.db.commit()


        
        

    def record_response(self, response):
        cursor = self.db.cursor()
        cursor.execute(''' INSERT INTO responses(user_id, question_id, list_id, response_type, time, duration, correct, incorrect, questions)
                  VALUES(:user_id, :question_id, :list_id, :response_type, :time, :duration, :correct, :incorrect, :questions)''', \
                       response)
        self.db.commit()


    # END - Common methods to implement storage interface
    ##################################################################

    

        
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
                     users(user_id TEXT PRIMARY KEY, 
                           name TEXT,
                           email TEXT,
                           remote_ip TEXT,
                           user_agent TEXT, 
                           last_accessed INTEGER)
        ''')
        self.db.commit()


        # Responses
        cursor = self.db.cursor()
        cursor.execute('''
              CREATE TABLE IF NOT EXISTS 
                     responses(id INTEGER PRIMARY KEY AUTOINCREMENT, 
                                     user_id TEXT, 
                                     question_id TEXT, 
                                     list_id TEXT,
                                     response_type TEXT,             /* SUBMIT or SKIP */
                                     time INTEGER,                   /* Time in seconds epoch from when the question is generated */
                                     duration INTEGER,               /* Time in seconds epoch from when the question is generated to when the answer is created*/
                                     correct INTEGET,                /* Number of correct answers on the form */
                                     incorrect INTEGER,              /* Number of incorrect answers on the form */
                                     questions TEXT                  /* Detailed answers for each question */)
        ''')
        self.db.commit()
            


            


        
    def print_all_responses(self, user_id = None):
        cursor = self.db.cursor()
        if user_id is None:
            cursor.execute(''' SELECT * from responses ''')
        else:
            cursor.execute(''' SELECT * from responses WHERE user_id == ?''', (user_id,))


        if user_id is None:
            print("            USER_ID            ", end='')
        else:
            print("USER_ID = {}\n".format(user_id))

        print("     QUESTION_ID          LIST_ID     RESPONSE_TYPE           TIME                DURATION      CORRECT   INCORRECT                QUESTIONS")
        for row in cursor:
            if user_id is None:
                print("{:^30} ".format(row[1]), end='')                                                      # UID
            print("{:^20} ".format(row[2]), end='')                                                          # QID
            print("{:^16} ".format(row[3]), end='')                                                          # List ID
            print("{:^12} ".format(row[4]), end='')                                                          # RESPONSE TYPE
            print("{:^26} ".format(time.strftime("%d-%m-%y %H:%M:%S", time.localtime(row[5]))), end='')      # TIME
            print("{:^16} ".format(row[6]), end='')                                                          # DURATION
            print("{:^10} ".format(row[7]), end='')                                                          # CORRECT
            print("{:^10} ".format(row[8]), end='')                                                          # INCORRECT
            print("{:^38} ".format(row[9]))                                                                  # QUESTIONS

        print("\n")



    def print_all_users(self):
        cursor = self.db.cursor()
        cursor.execute(''' SELECT * from users ''')
        print("           USER ID                    NAME                      EMAIL                 LAST ACCESSED          REMOTE IP                      USER AGENT          ")
        for row in cursor:
            print("{:^30} {:^20} {:^30} {:^20} {:^20} {:^40}".format(row[0], row[1], row[2], time.strftime("%d-%m-%y %H:%M:%S", time.localtime(row[5])), row[3], row[4]))
        
        print("\n")

        
            

if __name__ == '__main__':
    
    storage = storage()

    wipe_all = False
    #wipe_all = True

    add_test_data = False
    #add_test_data = True
    
    if wipe_all:
        storage.delete_all_tables()
        storage.create_tables()



    if add_test_data:
        epoch_ms = int(time.time())
        delta = 3600

        user0 = storage.get_user_by_id("test0")
        user1 = storage.get_user_by_id("test1")
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

    

