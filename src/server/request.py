from server.helpers import extract_dict_from_post

from enum import Enum, unique
import http.cookies
import logging

@unique
class RequestType(Enum):
    AZURE = 0
    CHERRY_PY = 1


class Request:

    def __init__(self, request, rtype=RequestType.AZURE):
        self._request = request
        self._rtype = rtype

        self._parse_cookies()
        self._post = None


    def _parse_cookies(self):
        if self._rtype == RequestType.CHERRY_PY:
            self._cookies = self._request.cookie
        else:
            self._cookies = http.cookies.SimpleCookie()
            http_cookie = self.get_header('Cookie')
            if http_cookie:
                try:
                    self._cookies.load(http_cookie)
                except http.cookies.CookieError as err:
                    logging.info("Invalid cookie header received: %s", http_cookie)


    def get_header(self, header):
        h = self._request.headers
        return h[header] if header in h else None


    def get_url(self):
        if self._rtype == RequestType.CHERRY_PY:
            import cherrypy
            return cherrypy.url()

        else:
            return self._request.url


    def get_cookie(self, cookie):
        if cookie in self._cookies:
            return self._cookies[cookie].value

        return None


    def param_get(self, name, default = None):
        return self._request.params.get(name, default)


    def get_post_data(self) -> dict:
        assert self.method() == 'POST'

        if self._rtype == RequestType.CHERRY_PY:
            return self._request.body.params

        else:
            if not self._post:
                self._post = extract_dict_from_post(self._request.get_body())

            return self._post


    def get_query_data(self) -> dict:
        return dict(self._request.params)


    def header_remote_addr(self):
        return self.get_header('x-client-ip')


    def header_user_agent(self):
        return self.get_header('user-agent')


    def method(self) -> str:
        return self._request.method



