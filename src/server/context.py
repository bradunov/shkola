from contextlib import contextmanager
from contextvars import ContextVar

request = ContextVar('request')
headers = ContextVar('headers')
timers = ContextVar('timers')
session = ContextVar('session')
user = ContextVar('user')

# This class (and c variable) is not necessary. In the code, one can just use:
# context.user.set(...) instead of: context.c.user = ...
# and
# user = context.user.get() instead of: user = context.c.user
#
# However, it order to avoid refactoring the old code, this class is added.
#
class ContextAccess():
    def __setattr__(self, k, v):
        globals()[k].set(v)

    def __getattr__(self, k):
        return globals()[k].get()

c = ContextAccess()

@contextmanager
def new_context(prequest, pheaders):

    token_request = request.set(prequest)
    token_headers = headers.set(pheaders)
    token_timers = timers.set(None)
    token_session = session.set(None)
    token_user = user.set(None)

    try:
        yield

    finally:
        request.reset(token_request)
        headers.reset(token_headers)
        timers.reset(token_timers)
        session.reset(token_session)
        user.reset(token_user)

