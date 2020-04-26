import threading
from contextlib import contextmanager

class Context(threading.local):
    ATTRS = ["request", "headers", "session", "user"]

    def __setattr__(self, k, v):
        if not k in Context.ATTRS:
            raise Exception("Invalid context attribute")

        threading.local.__setattr__(self, k, v)

    def clear(self):
        for k in Context.ATTRS:
            setattr(self, k, None)


c = Context()


@contextmanager
def new_context(request, headers):
    global c

    c.request = request
    c.headers = headers
    c.session = None
    c.user = None

    try:
        yield c

    finally:
        c.clear()

