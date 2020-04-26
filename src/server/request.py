from server.helpers import extract_dict_from_post

import http.cookies
import logging

class Request:

    def __init__(self, azure_request):
        self._azure_request = azure_request

        logging.info("REQ HEADERS: %s", dict(azure_request.headers))
        logging.info("REQ PARAMS: %s", azure_request.params)
        logging.info("REQ ROUTE: %s", azure_request.route_params)

        self._parse_cookies()

        self._post = None


    def _parse_cookies(self):
        self._cookies = http.cookies.SimpleCookie()
        http_cookie = self.get_header('Cookie')
        if http_cookie:
            try:
                self._cookies.load(http_cookie)
            except http.cookies.CookieError as err:
                logging.info("Invalid cookie header received: %s", http_cookie)


    def get_header(self, header):
        h = self._azure_request.headers
        return h[header] if header in h else None


    def get_url(self):
        return self._azure_request.url


    def get_cookie(self, cookie):
        if cookie in self._cookies:
            return self._cookies[cookie].value

        return None


    def param_get(self, name, default = None):
        return self._azure_request.params.get(name, default)


    def get_post_data(self) -> dict:
        assert(self.method() == 'POST')

        if not self._post:
            self._post = extract_dict_from_post(self._azure_request.get_body())

        return self._post


    def get_query_data(self) -> dict:
        return dict(self._azure_request.params)


    def header_remote_addr(self):
        return self.get_header('x-client-ip')


    def header_user_agent(self):
        return self.get_header('user-agent')


    def method(self) -> str:
        return self._azure_request.method



