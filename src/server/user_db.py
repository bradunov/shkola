import os
import server.context as context

import google.oauth2.id_token
import google.auth.transport.requests

import time
import logging
from collections import namedtuple
from server.timers import timer_section


GOOGLE_CLIENT_ID = os.environ['GOOGLE_CLIENT_ID'] if 'GOOGLE_CLIENT_ID' in os.environ.keys() else ""
GOOGLE_SITE_VERIFICATION = os.environ['GOOGLE_SITE_VERIFICATION'] if 'GOOGLE_SITE_VERIFICATION' in os.environ.keys() else ""


DOMAINS = ["local", "google"]

User = namedtuple("User", "user_id domain domain_user_id picture name")


class UserDB(object):
    
    def __init__(self, storage):
        self._storage = storage
        logging.debug("User DB initialized")
        

    def session_login_and_update_user(self, domain, user_id, name, picture, user_language):
        assert(user_id)
        assert(domain in DOMAINS)
        assert(name)

        remote_ip = context.c.request.header_remote_addr()
        user_agent = context.c.request.header_user_agent()

        full_user_id = self.make_user_id(domain, user_id)
        now = int(time.time())

        logging.info(
            "User logged in: %s %s (%s, %s, %s, %s, %s)",
            user_id, name, remote_ip, user_agent, picture, user_language, now
        )

        context.c.session.set_user_id(full_user_id)
        if not user_id == "UNKNOWN":
            context.c.session.set("user_picture", picture)
            context.c.session.set("user_name", name)

        self._storage.update_user(full_user_id, name=name,  
                remote_ip=remote_ip, user_agent=user_agent, picture=picture,  
                user_language=user_language, last_accessed=now)


    @timer_section("get_user")
    def get_user(self, user_id):
        if not user_id:
            return None

        d = self._storage.get_user(user_id)
        if d is None:
            return None

        user_id = d['user_id']
        domain, domain_user_id = user_id.split(":")
        assert domain in DOMAINS

        return User(
            user_id = user_id,
            domain = domain,
            domain_user_id = domain_user_id,
            picture = d['picture'] if 'picture' in d.keys() else "",
            name = d['name'] if 'name' in d.keys() else ""
        )


    def make_user_id(self, domain, user_id):
        return "{}:{}".format(domain, user_id)


    def login_test(self, user_id, name, picture, language) -> bool:
        self.session_login_and_update_user(
            'local', user_id,
            name = name,
            picture = picture,
            user_language = language
        )

        return True


    def login_google(self, id_token) -> (bool, str):
        try:
            idinfo = google.oauth2.id_token.verify_oauth2_token(
                id_token,
                google.auth.transport.requests.Request(),
                GOOGLE_CLIENT_ID
            )
            if idinfo['iss'] not in ['accounts.google.com', 'https://accounts.google.com']:
                raise ValueError('Wrong issuer: {}'.format(idinfo['iss']))

            auth_user_id = idinfo['sub']
            logging.info("Google validation success: {}".format(idinfo))

            # Example my user info: 
            # {'iss': 'accounts.google.com', 
            # 'azp': '345432061367-f37577gsljsanetog1b0f2i2hmu3ji38.apps.googleusercontent.com', 
            # 'aud': '345432061367-f37577gsljsanetog1b0f2i2hmu3ji38.apps.googleusercontent.com', 
            # 'sub': '100168932003331800480', 
            # 'email': 'bozidar.radunovic@gmail.com', 
            # 'email_verified': True, 
            # 'at_hash': 'dbcN3WCTS4w_hUmOCCzv0Q', 
            # 'name': 'Bozidar Radunovic', 
            # 'picture': 'https://lh5.googleusercontent.com/-3VJ2UlD0Y3U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucnCsCk0v-JmKlQX7QXTrFI--Y_WXA/s96-c/photo.jpg', 
            # 'given_name': 'Bozidar', 'family_name': 'Radunovic', 
            # 'locale': 'en', 
            # 'iat': 1589737766, 
            # 'exp': 1589741366, 
            # 'jti': '1dce94a20bd47b3acb8719e36825b1f5223bc1ae'}

            if 'email' in idinfo:
                logging.info("Google login user: {}".format(idinfo["email"]))


            # Do not full name and email 
            name = idinfo['given_name']
            #email = idinfo['email']
            language = idinfo['locale']
            picture = idinfo['picture']

        except ValueError as ex:
            logging.info("Failed google authentication: {}".format(ex))

            # DEBUGDEBUG!!!: 
            # I currently get authentication error from Google:
            # "Failed google authentication: Token used too early, 1587897345 < 1587939823"
            # Not sure why so I'll just ignore for now for testing
            #return False
            return False, str(ex)

        except Exception as ex:
            logging.info("Google authentication unknown error: {}".format(ex))
            return False, str(ex)


        self.session_login_and_update_user(
            'google', auth_user_id,
            name=name,
            picture=picture,
            user_language = language
        )

        return True, ""


