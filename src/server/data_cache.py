import threading

class DataCache:
    DEFAULT_STATE = 0

    def __init__(self, cache_size):
        self._cache_size = cache_size
        self._lock = threading.Lock()

        self._data = dict()


    def get(self, object_id, state_id):
        with self._lock:
            v = self._data.get(object_id)
            if v is None:
                return None

            state, data = v
            return data if state == state_id else None


    def set(self, object_id, object_state, object_data):
        with self._lock:
            if len(self._data) > self._cache_size:
                self._data = dict()


            self._data[object_id] = (object_state, object_data)



