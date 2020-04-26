import http.cookies

class Headers:
    def __init__(self):
        self._headers = dict()
        self._cookies = http.cookies.SimpleCookie()
        self._no_store = False
        self._status_code = 200
        self._content_type = 'text/html'


    def set_cookie(self, name, value, attrs=dict()):
        self._cookies[name] = value
        for k, v in attrs.items():
            self._cookies[name][k] = v


    def set_content_type(self, ctype):
        self._content_type = ctype


    def content_type(self):
        return self._content_type


    def status_code(self):
        return self._status_code


    def redirect(self, url):
        self._status_code = 303
        self.set_header('Location', url)


    def set_no_store(self):
        self._no_store = True


    def set_header(self, name, value):
        self._headers[name] = value


    def get_headers(self):
        headers = self._headers.copy()

        cookies = list(self._cookies.items())
        if len(cookies) > 1:
            raise Exception("Cannot set multiple cookies")

        if cookies:
            n, v = cookies[0]
            headers['Set-Cookie'] = "{}={}".format(n, v.coded_value)

        if self._no_store:
            headers['Cache-Control'] = 'no-store'

        return headers


