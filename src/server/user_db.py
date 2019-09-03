import cherrypy
import google.oauth2.id_token
import google.auth.transport.requests
import time
from helpers import create_url
from storage import storage
from jinja2 import Template


GOOGLE_CLIENT_ID = "221670444651-i7ock63nksbnqeag7l3s2u0nf6jdb2bk.apps.googleusercontent.com"



logger = cherrypy.log

class UserDB(object):
    storage = None
    template_env = None
    
    def __init__(self, template_env):
        self.template_env = template_env
        self.storage = storage()
        logger("User DB initialized")

    def check_user(self):
        s = cherrypy.session
        if "user_id" in s:
            return True
        else:
            return False

    def session_logout(self):
        s = cherrypy.session
        if 'user_id' in s:
            del s['user_id']
        
    def session_login(self, domain, user_id):
        s = cherrypy.session

        #assert "user_id" not in s
        s["user_id"] = user_id = self.make_user_id(domain, user_id)

        return user_id

    def session_login_and_update_user(self, domain, user_id, name, email, remote_ip, user_agent):
        user_id = self.session_login(domain, user_id)
        self.update_user_data(user_id, name, email, remote_ip, user_agent)

    def make_user_id(self, domain, user_id):
        return "{}:{}".format(domain, user_id)

    def get_user_data(self, user_id = None):
        s = cherrypy.session
        if not user_id:
            user_id = s["user_id"]
        return self.get_user_data(user_id)

    def update_user_data(self, user_id, name, email, remote_ip, user_agent):
        user = self.storage.get_user_by_id(user_id)
        now = int(time.time())
        self.storage.update_user(user, name=name, email=email, remote_ip=remote_ip, user_agent=user_agent, last_accessed=now)

        
    @cherrypy.expose
    def logout(self):
        self.session_logout()

        s = cherrypy.session
        if 'login_return' in s:
            raise cherrypy.HTTPRedirect(s['login_return'])

    @cherrypy.expose
    def login_test(self, user_id = None):
        #self.check_no_user()
        headers = cherrypy.request.headers
        if user_id is None:
            self.session_login_and_update_user('local', 'test',
                                               name='test',
                                               email='test',
                                               remote_ip=headers["Remote-Addr"],
                                               user_agent=headers["User-Agent"])
        else:
            self.session_login_and_update_user('local', user_id,
                                               name=user_id,
                                               email=user_id,
                                               remote_ip=headers["Remote-Addr"],
                                               user_agent=headers["User-Agent"])

        s = cherrypy.session
        if 'login_return' in s:
            raise cherrypy.HTTPRedirect(s['login_return'])

    @cherrypy.expose
    def login_google(self, id_token):
        #self.check_no_user()
        headers = cherrypy.request.headers

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

        self.session_login_and_update_user('google', auth_user_id,
                                           name=name,
                                           email=email,
                                           remote_ip=headers["Remote-Addr"],
                                           user_agent=headers["User-Agent"])

        return "OK"



    def login_page(self, params, menu):
        if self.check_user():
            return ""


        template = self.template_env.get_template('login.rs.html')
        
        s = cherrypy.session
        s['login_return'] = "../" + create_url(page_name = params["page_name"], \
                                       q_id = params["q_id"], \
                                       l_id = params["l_id"], \
                                       lang = params["language"], \
                                       menu = menu, \
                                       js = False)

        url = cherrypy.url('/users/login_google')
        print("URL:", url)
        print(template.render(url=url))

        return template.render(url=url)
