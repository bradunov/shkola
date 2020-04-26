import server.context as context

import google.oauth2.id_token
import google.auth.transport.requests

import time
import logging
from collections import namedtuple

GOOGLE_CLIENT_ID = "221670444651-i7ock63nksbnqeag7l3s2u0nf6jdb2bk.apps.googleusercontent.com"

DOMAINS = ["local", "google"]

TEST_USERS = ["Aran", "Petar", "Oren", "Thomas", "Ben", "Luke", "Leo", "Oliver", "Felix", "Darragh", "Jovana", "Zomebody"]

User = namedtuple("User", "user_id domain domain_user_id email name")


class UserDB(object):
    
    def __init__(self, storage):
        self._storage = storage
        logging.debug("User DB initialized")
        

    def session_login_and_update_user(self, domain, user_id, name, email, user_language):
        assert(user_id)
        assert(domain in DOMAINS)
        assert(name)

        remote_ip = context.c.request.header_remote_addr()
        user_agent = context.c.request.header_user_agent()

        full_user_id = self.make_user_id(domain, user_id)
        now = int(time.time())

        logging.info(
            "User logged in: %s %s (%s, %s, %s, %s, %s)",
            user_id, name, email, remote_ip, user_agent, user_language, now
        )

        context.c.session.set_user_id(full_user_id)

        self._storage.update_user(full_user_id, name=name, email=email, 
                remote_ip=remote_ip, user_agent=user_agent, user_language=user_language, last_accessed=now)


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
            email = d['email'] if 'email' in d.keys() else "",
            name = d['name'] if 'name' in d.keys() else ""
        )


    def make_user_id(self, domain, user_id):
        return "{}:{}".format(domain, user_id)


    def login_test(self, user_id, name, email, language) -> bool:
        self.userdb.session_login_and_update_user(
            'local', user_id,
            name = name,
            email = email,
            user_language = language
        )

        return True


    def login_google(self, id_token) -> bool:
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

            name = idinfo['name']
            email = idinfo['email']
            language = idinfo['locale']

        except ValueError as ex:
            logging.info("Failed google authentication: {}".format(ex))
            return False

        self.session_login_and_update_user(
            'google', auth_user_id,
            name=name,
            email=email,
            user_language = language
        )

        return True


