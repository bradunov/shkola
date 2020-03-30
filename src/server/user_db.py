import google.oauth2.id_token
import google.auth.transport.requests
import time
from server.storage import get_storage
import logging

GOOGLE_CLIENT_ID = "221670444651-i7ock63nksbnqeag7l3s2u0nf6jdb2bk.apps.googleusercontent.com"



class UserDB(object):
    storage = None

    
    def __init__(self):
        self.storage = get_storage()
        logging.debug("User DB initialized")
        

    def session_login_and_update_user(self, domain, user_id, name, email, remote_ip, user_agent, user_language):
        full_user_id = self.make_user_id(domain, user_id)

        now = int(time.time())
        #logging.debug("User %s %s (%s, %s, %s, %s, %s)", str(user_id), str(name), str(email), str(remote_ip), str(user_agent), str(user_language), str(now))
        self.storage.update_user(full_user_id, name=name, email=email, 
                remote_ip=remote_ip, user_agent=user_agent, user_language=user_language, last_accessed=now)


    def make_user_id(self, domain, user_id):
        return "{}:{}".format(domain, user_id)


        


