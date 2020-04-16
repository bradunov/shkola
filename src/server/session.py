import uuid
import logging
from contextlib import contextmanager

from .helpers import encode_dict, decode_dict

SESSION_COOKIE = "shkola_session_id"

class Session:
    def __init__(self, session_id, user_id, data):
        self._session_id = session_id

        self._data = data
        self._user_id = user_id
        self._has_updates = False

    def session_id(self):
        return self._session_id

    def set(self, key, value):
        self._data[key] = value
        logging.info(f"\n\n\n set {key} {value} {self._data[key]} \n\n\n")
        self._has_updates = True


    # For lists
    def list_append(self, key, value):
        logging.info(f"\n\n\n list_append {key} {value} {self._data[key]} \n\n\n")
        if not key in self._data.keys(): 
            self._data[key] = []
        self._data[key].append(value)
        self._has_updates = True

    def list_delete(self, key, index):
        logging.info(f"\n\n\n list_delete {key} {index} {self._data[key]} \n\n\n")
        self._data[key][index]
        self._has_updates = True


    def set_user_id(self, user_id):
        assert self._user_id == None
        self._user_id = user_id
        self._has_updates = True


    def user_id(self):
        return self._user_id


    def keys(self):
        return self._data.keys()


    def get(self, key, default_value = None):
        return self._data.get(key, default_value)


    def data(self):
        return self._data


    def has_updates(self):
        return self._has_updates


class SessionDB:
    def __init__(self, storage):
        self._storage = storage


    @contextmanager
    def init_session(self, req, headers):
        sid = req.get_cookie(SESSION_COOKIE)

        session_data = None

        if sid is not None:
            session_data = self._storage.get_session(sid)
            logging.info("Session: existing: %s", sid)

            if session_data:
                session_data['data'] = decode_dict(session_data['data'])
            else:
                logging.info("Session: not found in storage: %s", sid)

        if session_data is None:
            sid = uuid.uuid4().hex
            headers.set_cookie(SESSION_COOKIE, sid)
            headers.set_no_store()

            self._storage.insert_session(sid)
            session_data = {
                "data": dict(),
                "user_id": None
            }

            logging.info("Session: creating new: %s", sid)

        session = Session(
            sid,
            session_data['user_id'],
            session_data['data'],
        )

        if session.user_id():
            logging.info("Session: user id associated: %s", session.user_id())

        try:
            yield session

        finally:
            if session.has_updates():
                self._storage.update_session(
                    session.session_id(),
                    user_id = session.user_id(),
                    data = encode_dict(session.data())
                )


