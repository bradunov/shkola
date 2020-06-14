import time
from contextlib import contextmanager
from functools import wraps

class Section:
    def __init__(self, name, ts_start):
        self._name = name
        self._start = ts_start
        self._stop = None
        self._children = []


    def set_stop(self, ts):
        assert self._stop is None
        self._stop = ts


    def __repr__(self):
        return "Timer section: {}".format(self._name)


    def add_child(self, child):
        assert self._stop is None
        self._children.append(child)


    def dump(self, lvl):
        assert self._stop is not None
        assert self._stop >= self._start

        ret = " " * (4 * lvl)
        ret += "{:.3f}s - {:.3f} {} ({:.3f}s)\n".format(self._start, self._stop, self._name, self._stop - self._start)
        for c in self._children:
            ret += c.dump(lvl + 1)

        return ret


class TimerControl:
    def __init__(self):
        self._start = time.time()
        self._root = None
        self._stack = []


    def add_section(self, name):
        s = Section(name, self.ts_rel())

        if self._root:
            self.top().add_child(s)
        else:
            self._root = s

        self._stack.append(s)


    def close_section(self):
        self.top().set_stop(self.ts_rel())
        self._stack.pop()


    def top(self):
        assert self._stack
        return self._stack[-1]


    def ts_rel(self):
        return time.time() - self._start


    def dump(self):
        assert not self._stack
        assert self._root

        return self._root.dump(0)


    def close(self):
        assert len(self._stack) == 1, self._stack
        self.close_section()


    @contextmanager
    def new_section(self, name):
        self.add_section(name)

        try:
            yield

        finally:
            self.close_section()


def timer_section(name):
    import server.context as context

    def timer_decorator(func):
        @wraps(func)
        def timer_wrapper(*args, **kwargs):
            assert context.c.timers is not None
            with context.c.timers.new_section(name):
                return func(*args, **kwargs)

        return timer_wrapper

    return timer_decorator

