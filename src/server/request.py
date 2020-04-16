import http.cookies
import logging

class Request:

    def __init__(self, azure_request):
        self._azure_request = azure_request

        logging.info("REQ HEADERS: %s", dict(azure_request.headers))
        logging.info("REQ PARAMS: %s", azure_request.params)
        logging.info("REQ ROUTE: %s", azure_request.route_params)

        self._parse_cookies()


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


