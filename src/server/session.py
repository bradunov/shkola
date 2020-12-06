import json
import uuid
import logging
from contextlib import contextmanager
# from server.timers import timer_section

from .data_cache import DataCache

SESSION_COOKIE = "shkola_session_id"
CACHE_SIZE = 1000

class Session:
    def __init__(self, session_id, user_id, data, state_id):
        self._session_id = session_id

        self._data = data
        self._user_id = user_id
        self._state_id = state_id
        self._valid = True


    def session_id(self):
        return self._session_id


    def state_id(self):
        return self._state_id


    def set(self, key, value):
        self._data[key] = value
        self._set_dirty()

    def delete(self, key):
        if key in self._data.keys():
            del self._data[key]
            self._set_dirty()


    # For lists
    def list_append(self, key, value):
        if key not in self._data.keys():
            self._data[key] = []

        if not key in self._data.keys(): 
            self._data[key] = []

        self._data[key].append(value)
        self._set_dirty()


    def list_delete(self, key, index):
        del self._data[key][index]
        self._set_dirty()


    def set_user_id(self, user_id):
        assert self._user_id == None

        self._user_id = user_id
        self._set_dirty()


    def user_id(self):
        return self._user_id


    def keys(self):
        return self._data.keys()


    def get(self, key, default_value = None):
        return self._data.get(key, default_value)


    def data(self):
        return self._data


    def has_updates(self):
        return self._state_id is None


    def close(self):
        logging.debug("Session: Closing session: %s", self.session_id())
        self._set_invalid()


    def _set_invalid(self):
        self._set_dirty()
        self._valid = False


    def _set_dirty(self):
        assert self._valid
        logging.debug("Session: Setting session dirty: %s", self.session_id())
        self._state_id = None


    def is_valid(self):
        return self._valid


    def generate_state_id(self):
        self._state_id = uuid.uuid4().hex


    def print(self):
        logging.debug("\n\nSession dump: {} - {} - {}\n\n".format(
            self._session_id, self._user_id, json.dumps(self._data, indent=2)
        ))


    def session_dict(self):
        return {
            'data': self._data,
            'state_id': self._state_id,
            'user_id': self._user_id,
            'valid': self._valid,
        }


class SessionDB:
    def __init__(self, storage):
        self._storage = storage
        self._session_cache = DataCache(CACHE_SIZE)


    @contextmanager
    def init_session(self, req, headers):
        sid, state_id = self._parse_cookie(req)
        assert state_id is None or sid is not None

        session_data = None

        if sid is not None:
            logging.info("Session: got sid from cookie: %s, cookie state_id: %s", sid, state_id)

            session_data = self._session_cache.get(sid, state_id)

            if session_data is None:
                logging.info("Session: not found in cache, loading from storage: %s", sid)

                session_data = self._storage.get_session(sid)

                if not session_data:
                    logging.info("Session: not found in storage: %s", sid)

            else:
                logging.info("Session: cached session is valid")


        if session_data and not session_data['valid']:
            logging.info("Session: session is not valid: %s", sid)
            session_data = None

        if session_data is None:
            sid = uuid.uuid4().hex

            session_data = {
                "data": dict(),
                "user_id": None,
                'state_id': None
            }

            logging.info("Session: creating new: %s", sid)

        session = Session(
            sid,
            session_data['user_id'],
            session_data['data'],
            session_data['state_id']
        )

        logging.debug("Session: setup: ID={}, USER={}, DATA={}, state_id={}\n\n".format(
            session.session_id(), session.user_id(), session.data(), session.state_id()
        ))

        try:
            yield session

        finally:
            logging.debug("Session: cleanup: sid=%s, state=%s", session.session_id(), session.state_id())
            if session.has_updates():
                session.generate_state_id()

                logging.debug(
                    "Session: Data changed, storing state to database: id=%s, user=%s, state=%s, data=%s",
                    session.session_id(), session.user_id(), session.state_id(), session.data()
                )

                self._storage.update_session(session.session_id(), session.session_dict())

            self._session_cache.set(session.session_id(), session.state_id(), session.session_dict())

            assert session.state_id() is not None

            if state_id != session.state_id:
                logging.debug("Session: setting session cookie: %s, %s", session.session_id(), session.state_id())
                self._set_cookie(session, headers)


    def _set_cookie(self, session, headers):
        cookie = "{}:{}".format(session.session_id(), session.state_id())

        headers.set_cookie(SESSION_COOKIE, cookie)
        headers.set_no_store()


    def _parse_cookie(self, req):
        # Cookie format is: <session_id>:<state_id>
        cookie = req.get_cookie(SESSION_COOKIE)
        if cookie is None:
            return None, None

        if ":" not in cookie:
            # Compatibility: cookie only contains session_id
            return cookie, None

        values = cookie.split(":")
        if not len(values) == 2:
            logging.info("Invalid cookie format: %s", cookie)
            return None, None

        return values




    # Create test session for testing without HTTP requests
    @contextmanager
    def init_test_session(self):
        sid = uuid.uuid4().hex

        session_data = {
            "data": dict(),
            "user_id": None,
            'state_id': None
        }

        session = Session(
            sid,
            session_data['user_id'],
            session_data['data'],
            session_data['state_id']
        )

        logging.debug("Session: setup: ID={}, USER={}, DATA={}, state_id={}\n\n".format(
            session.session_id(), session.user_id(), session.data(), session.state_id()
        ))

        try:
            yield session

        finally:
            logging.debug("Session: cleanup: sid=%s, state=%s", session.session_id(), session.state_id())
