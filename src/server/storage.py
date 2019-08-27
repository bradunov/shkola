import sqlite3
import datetime

    



class storage(object):
    db = None
    dbname = "shkola.sql"
    
    def __init__(self):
        self.db = sqlite3.connect(self.dbname, detect_types=sqlite3.PARSE_DECLTYPES, check_same_thread=False)
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
                                 user_id TEXT, 
                                 name TEXT,
                                 email TEXT,
                                 remote_ip TEXT,
                                 user_agent TEXT, 
                                 last_accessed TIMESTAMP)
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
            


            
    def get_user_by_id(self, user_id):
        cursor = self.db.cursor()
        cursor.execute('''SELECT id FROM users where user_id == (?)''', (user_id,))
        user = cursor.fetchone()
        if user is not None:
            return user[0]
        else:
            cursor.execute(''' INSERT INTO users(user_id) VALUES(?) ''', (user_id, ))
            self.db.commit()
            return cursor.lastrowid


    def get_user_data(self, user_id):
        cursor = self.db.cursor()
        cursor.execute('''SELECT * FROM users where user_id == (?)''', (user_id,))
        user = cursor.fetchone()
        if user is not None:
            return {"id": row[0],
                    "user_id": row[1],
                    "name": row[2],
                    "email": row[3],
                    "remote_ip":row[4],
                    "user_agent":row[5],
                    "last_accessed":row[6]}
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
        query = query + " WHERE id == ?"
        tvals = tuple(vals)
        
        cursor.execute(query, tvals)
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
        print("   ID               USER ID                    NAME                      EMAIL                LAST ACCESSED        REMOTE IP                      USER AGENT          ")
        for row in cursor:
            print("{:^8} {:^30} {:^20} {:^30} {:%d-%m-%y %H:%M:%S} {:^20} {:^40}".format(row[0], row[1], row[2], row[3], row[6], row[4], row[5]))
        
        print("\n")

        
            

if __name__ == '__main__':
    
    storage = storage()

    #wipe_all = True
    wipe_all = False

    if wipe_all:
        storage.delete_all_tables()
        storage.create_tables()
    
    now = datetime.datetime.now()
    delta = datetime.timedelta(hours=1, minutes=2, seconds=3)

    user0 = storage.get_user_by_id("test0")
    user1 = storage.get_user_by_id("test1")
    storage.update_user(user0, name="User0", email="Email0", remote_ip="100.200.300.400", user_agent="agent0", last_accessed=now)
    storage.update_user(user1, name="User1", email="Email1", remote_ip="200.300.400.500", user_agent="agent1", last_accessed=now)
    # storage.update_user_name(user1, "User1")
    # storage.update_user_email(user0, "Email0")
    # storage.update_user_email(user1, "Email1")
    # storage.update_user_remote_ip(user0, "100.200.300.400")
    # storage.update_user_remote_ip(user1, "200.300.400.500")
    # storage.update_user_remote_agent(user0, "agent0")
    # storage.update_user_remote_agent(user1, "agent1")


    
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

    

