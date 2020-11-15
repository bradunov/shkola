import sqlite3
import time
import logging
import os

import sys
sys.path.append("..")


if __name__ == '__main__':
    # Added to test stats as a standalone
    import storage_az_table
    import stats
    import page


import pprint


class Storage_sql:
    db = None
    dbname = "shkola.sql"


    ##################################################################
    # BEGIN - Common methods to implement storage interface
    
    def __init__(self):

        if 'SHKOLA_SQL_PATH' in os.environ.keys():
            dbpath = os.environ['SHKOLA_SQL_PATH']
            if dbpath.endswith("/"):
                full_name = dbpath + self.dbname
            else:
                full_name = dbpath + "/" + self.dbname
        else:
            full_name = self.dbname
        logging.info("Opening SQL database: %s", full_name)
        self.db = sqlite3.connect(full_name, detect_types=sqlite3.PARSE_DECLTYPES, check_same_thread=False)
        self.create_tables()


    def insert_user_id(self, user_id):
        cursor = self.db.cursor()
        cursor.execute('''SELECT user_id FROM users where user_id == (?)''', (user_id,))
        user = cursor.fetchone()
        if user is not None:
            return user_id
        else:
            cursor.execute(''' INSERT INTO users(user_id) VALUES(?) ''', (user_id, ))
            self.db.commit()
            return user_id


    def get_user(self, user_id):
        cursor = self.db.cursor()
        query = "SELECT user_id, name, remote_ip, user_agent, last_accessed FROM users where user_id == (?)"
        cursor.execute(query, (user_id,))
        row = cursor.fetchone()
        if row is not None:
            return {"user_id": row[0],
                    "name": row[1],
                    "remote_ip":row[3],
                    "user_agent":row[4],
                    "last_accessed":row[5]}
        else:
            return None


    def update_user(self, user_id, **data):
        self.insert_user_id(user_id)
        self._update_data("users", "user_id", user_id, data)


    def _update_data(self, table_name, row_id_name, row_id, data):
        query = "UPDATE {} SET ".format(table_name)

        vals = list(data.values())[:]

        query_list = ["{} = ?".format(f) for f in data.keys()]
        query += ", ".join(query_list)

        query = query + " WHERE {} == ?".format(row_id_name)
        logging.info("QUERY: %s", query)
        vals.append(row_id)

        cursor = self.db.cursor()
        cursor.execute(query, vals)
        self.db.commit()


    def get_session(self, session_id):
        cursor = self.db.cursor()
        query = "SELECT user_id, data FROM sessions where id == (?)"
        cursor.execute(query, (session_id,))
        row = cursor.fetchone()
        if row is not None:
            return {
                "user_id": row[0],
                "data": row[1]
            }
        else:
            return None

    def insert_session(self, session_id):
        query = "INSERT INTO sessions(id) VALUES(?)"

        cursor = self.db.cursor()
        cursor.execute(query, [session_id])
        self.db.commit()
        

    def update_session(self, session_id, **data):
        self._update_data("sessions", "id", session_id, data)
        

    def record_response(self, response):
        logging.debug("Record response %s", str(response))

        cursor = self.db.cursor()
        cursor.execute(''' INSERT INTO responses(user_id, question_id, list_id, response_type, time, duration, correct, incorrect, attempt, questions)
                  VALUES(:user_id, :question_id, :list_id, :response_type, :time, :duration, :correct, :incorrect, :attempt, :questions)''', \
                       response)
        self.db.commit()


    def record_feedback(self, response):
        logging.debug("Record feedback %s", str(response))

        cursor = self.db.cursor()
        cursor.execute(''' INSERT INTO responses(user_id, question_id, list_id, type, comment, random_vals)
                  VALUES(user_id, question_id, list_id, type, comment, random_vals)''', \
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
            #record = cursor.fetchone()
            cursor.fetchone()
        #TBD:
        #except sqlite3.IntegrityError:
        except:
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
                           remote_ip TEXT,
                           user_agent TEXT,
                           user_language TEXT,
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
                                     attempt INTEGER,                /* Number of previous attempts on the same question */
                                     questions TEXT                  /* Detailed answers for each question */)
        ''')
        self.db.commit()
            
        # Sessions
        cursor = self.db.cursor()
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS sessions (
                id TEXT PRIMARY KEY,
                user_id TEXT,
                data TEXT,
                FOREIGN KEY(user_id) REFERENCES users(user_id)
            )
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

        print("     QUESTION_ID          LIST_ID     RESPONSE_TYPE           TIME                DURATION      CORRECT   INCORRECT         ATTEMPTS       QUESTIONS")
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
            print("{:^8} ".format(row[9]),  end='')                                                          # ATTEMPTS
            print("{:^38} ".format(row[10]))                                                                 # QUESTIONS

        print("\n")



    def print_all_users(self):
        cursor = self.db.cursor()
        cursor.execute(''' SELECT * from users ''')
        print("           USER ID                    NAME                      EMAIL                 LAST ACCESSED          REMOTE IP                      USER AGENT          ")
        for row in cursor:
            print("{:^30} {:^20} {:^30} {:^20} {:^20} {:^40}".format(row[0], row[1], row[2], time.strftime("%d-%m-%y %H:%M:%S", time.localtime(row[5])), row[3], row[4]))
        
        print("\n")

        
            
    def get_question_stats(self, q_id=None, from_date=None):
        req = ""

        if q_id:
            # Remove / from q_id
            mq_id = ("".join("fractions/q00022".split("/")))
            req = req + " QUESTION_ID BETWEEN '{}|' and '{}{}'".format(mq_id, mq_id, chr(255)) 

        # if from_date:
        #     if len(req) > 0:
        #         req = req + " and "
        #     req = req + "(Timestamp ge datetime'{}')".format(from_date)

        if req:
            req = ''' SELECT * from responses WHERE ''' + req
        else:
            req = ''' SELECT * from responses '''

        print("REQ: {}".format(req))

        cursor = self.db.cursor()
        #cursor.execute(''' SELECT * from responses WHERE ''')
        cursor.execute(req)



        result = []
        for row in cursor:
            r = {
                "user_id": row[1],
                "question_id": row[2],
                "list_id": row[3],
                "response_type": row[4],
                "time": row[5],
                "duration": row[6],
                "correct": row[7],
                "incorrect": row[8],
                "attempt": row[9],
                "questions": row[10]
            }

            # TBD DEBUG: temporary cleanup foer various user names we used over time
            if "user_id" not in r.keys() or \
                "local:Korisnik" in r["user_id"] or \
                "UNKNOWN" in r["user_id"] or \
                "Zomebody" in r["user_id"]:
                continue

            result.append(r)

        return result



    def get_all_user_results(self, u_id, from_date=None):

        # TBD DEBUG: temporary cleanup foer various user names we used over time
        req = " USER_ID = '{}' OR USER_ID = 'local:{}'".format(u_id, u_id) 

        # if from_date:
        #     if len(req) > 0:
        #         req = req + " and "
        #     req = req + "(Timestamp ge datetime'{}')".format(from_date)

        if req:
            req = ''' SELECT * from responses WHERE ''' + req
        else:
            req = ''' SELECT * from responses '''

        print("REQ: {}".format(req))

        cursor = self.db.cursor()
        cursor.execute(req)



        result = []
        for row in cursor:
            r = {
                "user_id": row[1],
                "question_id": row[2],
                "list_id": row[3],
                "response_type": row[4],
                "time": row[5],
                "duration": row[6],
                "correct": row[7],
                "incorrect": row[8],
                "attempt": row[9],
                "questions": row[10]
            }

            result.append(r)

        return result





if __name__ == '__main__':
    
    storage = Storage_sql()


    copy_from_azure = False

    if copy_from_azure:
        storage.delete_all_tables()
        storage.create_tables()

        storage_az = storage_az_table.Storage_az_table()
        users = storage_az.get_all_users()

        for row in users:
            storage.update_user(
                row['user_id'],
                name=row['name'],
                last_accessed="0", 
                remote_ip=(row['remote_ip'] if 'remote_ip' in row.keys() else ""),
                user_agent=(row['user_agent'] if 'user_agent' in row.keys() else ""),
                user_language=(row['user_language'] if 'user_language' in row.keys() else ""))

        results = storage_az.get_all_responses()
        for row in results:
            if 'attempt' not in row.keys():
                row['attempt'] = 0
            storage.record_response(row)




    wipe_all = False

    add_test_data = False



    if wipe_all:
        storage.delete_all_tables()
        storage.create_tables()



    if add_test_data:
        epoch_ms = int(time.time())
        delta = 3600

        user0 = storage.insert_user_id("test0")
        user1 = storage.insert_user_id("test1")
        storage.update_user(user0, name="User0", email="Email0", remote_ip="100.200.300.400", user_agent="agent0", user_language="", last_accessed=epoch_ms)
        storage.update_user(user1, name="User1", email="Email1", remote_ip="200.300.400.500", user_agent="agent1", user_language="", last_accessed=epoch_ms)
    
        response = {"user_id" : user0, "question_id": "q0", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms, "duration": 0, "correct": 0, "incorrect": 0, "attempt": 0, "questions": "abc"}
        storage.record_response(response)

        response = {"user_id" : user0, "question_id": "q1", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms+delta, "duration": 0, "correct": 0, "incorrect": 0, "attempt": 0, "questions": "abc"}
        storage.record_response(response)

        response = {"user_id" : user1, "question_id": "q0", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms, "duration": 0, "correct": 0, "incorrect": 0, "attempt": 0, "questions": "abc"}
        storage.record_response(response)

        response = {"user_id" : user1, "question_id": "q1", "list_id": "list", "response_type": "SUBMIT", "time": epoch_ms+delta, "duration": 0, "correct": 0, "incorrect": 0, "attempt": 0, "questions": "abc"}
        storage.record_response(response)




    # Change this True to see different outputs
    print_all_data = False
    print_question_stats = False
    print_user_stats = True


    if print_all_data:
        storage.print_all_users()
        storage.print_all_responses()
        #storage.print_all_responses("local:Korisnik1")


    if print_question_stats:
        pp = pprint.PrettyPrinter(indent=2)
        pp.pprint(stats.Stats.calc_question_stats())



    if print_user_stats:
        pg = page.Page()
        pp = pprint.PrettyPrinter(indent=2)
        pp.pprint(stats.Stats.calc_user_stats(pg, "Petar"))
        #pp.pprint(stats.Stats.calc_user_stats(pg, "UNKNOWN"))






