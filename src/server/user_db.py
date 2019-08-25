import cherrypy
import google.oauth2.id_token
import google.auth.transport.requests

GOOGLE_CLIENT_ID = "221670444651-i7ock63nksbnqeag7l3s2u0nf6jdb2bk.apps.googleusercontent.com"

USER_DATA = dict()


logger = cherrypy.log

class UserDB(object):

    def __init__(self):
        logger("User DB initialized")
        self.update_user_data(
            self.make_user_id('local', 'test'),
            "Test User",
            "test_user@shkola.vladap.com"
        )

    def check_no_user(self):
        s = cherrypy.session
        if "user_id" in s:
            raise Exception("User alredy logged in")

    def session_login(self, domain, user_id):
        s = cherrypy.session

        assert "user_id" not in s
        s["user_id"] = user_id = self.make_user_id(domain, user_id)

        return user_id

    def session_login_and_update_user(self, domain, user_id, name, email):
        user_id = self.session_login(domain, user_id)
        self.update_user_data(user_id, name, email)

    def make_user_id(self, domain, user_id):
        return "{}:{}".format(domain, user_id)

    def get_user_data(self, user_id = None):
        s = cherrypy.session
        if not user_id:
            user_id = s["user_id"]

        return USER_DATA[user_id]

    def update_user_data(self, user_id, name, email):
        USER_DATA[user_id] = dict(name=name, email=email)

    @cherrypy.expose
    def login_test(self):
        self.check_no_user()
        self.session_login('local','test')

        s = cherrypy.session
        if 'login_return' in s:
            raise cherrypy.HTTPRedirect(s['login_return'])

    @cherrypy.expose
    def login_google(self, id_token):
        self.check_no_user()

        try:
            idinfo = google.oauth2.id_token.verify_oauth2_token(
                id_token,
                google.auth.transport.requests.Request(),
                GOOGLE_CLIENT_ID
            )
            if idinfo['iss'] not in ['accounts.google.com', 'https://accounts.google.com']:
                raise ValueError('Wrong issuer: {}'.format(idinfo['iss']))

            auth_user_id = idinfo['sub']
            logger("Google validation success: {}".format(idinfo))

            name = idinfo['name']
            email = idinfo['email']

        except ValueError as ex:
            logger("Failed google authentication: {}".format(ex))
            return "ERROR"

        self.session_login_and_update_user('google', auth_user_id, name=name, email=email)

        return "OK"



