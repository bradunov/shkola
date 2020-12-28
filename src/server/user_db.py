import os
import server.context as context

import google.oauth2.id_token
import google.auth.transport.requests

import time
import logging
from collections import namedtuple
from server.timers import timer_section
from server.data_cache import DataCache


GOOGLE_CLIENT_ID = os.environ['GOOGLE_CLIENT_ID'] if 'GOOGLE_CLIENT_ID' in os.environ.keys() else ""
GOOGLE_SITE_VERIFICATION = os.environ['GOOGLE_SITE_VERIFICATION'] if 'GOOGLE_SITE_VERIFICATION' in os.environ.keys() else ""
GOOGLE_TAG_MANAGER = os.environ['GOOGLE_TAG_MANAGER'] if 'GOOGLE_TAG_MANAGER' in os.environ.keys() else ""

DOMAINS = ["local", "google"]

CACHE_SIZE = 1000

User = namedtuple("User", "user_id domain domain_user_id picture selected_language name")


class UserDB(object):
    
    def __init__(self, storage):
        self._storage = storage
        self._cache = DataCache(CACHE_SIZE)
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


    def update_selected_language(self, lang):
        if context.c.user and context.c.user.user_id and \
                    not context.c.user.user_id == "UNKNOWN" and \
                    context.c.user.selected_language != lang:
            #print("\n\n**** UPDATING: ", context.c.user, lang)
            context.c.user = User(
                user_id = context.c.user.user_id,
                domain = context.c.user.domain,
                domain_user_id = context.c.user.domain_user_id,
                picture = context.c.user.picture,
                selected_language = lang,
                name = context.c.user.name
            )

            self._storage.update_selected_language(context.c.user.user_id, lang)
            self._cache.set(context.c.user.user_id, DataCache.DEFAULT_STATE, context.c.user)


    @timer_section("get_user")
    def get_user(self, user_id):
        if not user_id:
            return None

        user = self._cache.get(user_id, DataCache.DEFAULT_STATE)
        if user:
            logging.debug("Userdb: got user from cache: {}".format(user_id))
            return user

        logging.debug("Userdb: user not found in cache, trying database: {}".format(user_id))

        d = self._storage.get_user(user_id)
        if d is None:
            return None

        user_id = d['user_id']
        domain, domain_user_id = user_id.split(":")
        assert domain in DOMAINS

        user = User(
            user_id = user_id,
            domain = domain,
            domain_user_id = domain_user_id,
            picture = d['picture'] if 'picture' in d.keys() else "",
            selected_language = "",
            name = d['name'] if 'name' in d.keys() else ""
        )

        self._cache.set(user_id, DataCache.DEFAULT_STATE, user)
        return user


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


