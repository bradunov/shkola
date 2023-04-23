import copy
import json

from enum import Enum, unique
from server.helpers import encode_dict
from server.helpers import decode_dict
from server.helpers import is_user_on_mobile
from server.helpers import encap_str
# from server.timers import timer_section

import server.context as context

import logging


class PageParameterParsingError(Exception):
    pass

# Register response in the table
@unique
class ResponseOperation(Enum):
    NONE = 0
    SUBMIT = 1
    SKIP = 2
    @classmethod
    def toStr(cls, enum ) -> str:
        if enum == ResponseOperation.NONE:
            return "NONE"
        elif enum == ResponseOperation.SUBMIT:
            return "SUBMIT"
        elif enum == ResponseOperation.SKIP:
            return "SKIP"
        else:
            return "NONE"




@unique
class PageDesign(Enum):
    DEFAULT = 0
    DEV = 1
    @classmethod
    def toStr(cls, enum) -> str:
        if enum == PageDesign.DEFAULT:
            return "default"
        elif enum == PageDesign.DEV:
            return "dev"

    @classmethod
    def fromStr(cls, name:str):
        if name.lower() == "default":
            return PageDesign.DEFAULT
        elif name.lower() == "dev":
            return PageDesign.DEV
        else:
            return PageDesign.DEFAULT





@unique
class PageOperation(Enum):
    # Testing - the default view for users
    TEST = "test"
    # View one question (DEV mode)
    VIEW = "view"
    # Editor view of one question (DEV mode)
    EDIT = "edit"
    # View all questions in a list (DEV mode)
    LIST = "list"
    # Browse through questions
    BROWSE = "browse"
    # Generate modified question in editor mode (DEV mode)
    GENERATE = "generate"
    # Register new a result in the table
    REGISTER = "register"
    # Submit test login request
    LOGIN_TEST = "login_test"
    # Submit google login request
    LOGIN_GOOGLE = "login_google"
    # Submit anonymous login request
    LOGIN_ANON = "login_anon"
    # Page that asks to confirm anonymous login
    CONFIRM_ANON = "confirm_anon"
    # Logout handler
    LOGOUT = "logout"
    # Menu - select user
    MENU_USER = "menu_user"
    # Menu - select year
    MENU_YEAR = "menu_year"
    # Menu - select theme
    MENU_THEME = "menu_theme"
    # Set this when not specified, so each menu can decide
    DEFAULT = "default"
    # Stats
    STATS = "stats"
    # Intro into test
    TEST_INTRO = "test_intro"
    # Intro into browse
    BROWSE_INTRO = "browse_intro"
    # Summary
    SUMMARY = "summary"
    # Previous question in test
    TEST_PREV = "test_prev"
    # Report an issue in question
    FEEDBACK = "feedback"
    # View existing feedbacks
    VIEW_FEEDBACK = "feedbacks"
    # About the site
    ABOUT = "about"

    # TODO: remove this method
    @classmethod
    def toStr(cls, enum) -> str:
        return enum.value

    @classmethod
    def isValid(cls, val) -> bool:
        return val in tuple(item.value for item in cls)




@unique
class PageLanguage(Enum):
    RS = "rs"
    RSC = "rsc"             # Serbian cyrillic
    UK = "uk"

    # TODO: remove this method
    @classmethod
    def toStr(cls, enum) -> str:
        return enum.value

    @classmethod
    def toJSON(cls, enum):
        return enum.value

    @classmethod
    def isValid(cls, val) -> bool:
        return val in tuple(item.value for item in cls)

    @classmethod
    def fromStr(cls, lang : str, with_exception : bool = False):
        for name, member in PageLanguage.__members__.items():
            if lang.lower() == name.lower():
                return member

        if with_exception:
            raise PageParameterParsingError()
        else:
            # Default language
            return PageLanguage.RS

    @classmethod
    def get_default(cls, browser_lang):
        # Default (for now)
        default = PageLanguage.RSC

        browser_mapping = [
            ["sr-Latn", PageLanguage.RS], 
            ["sr", PageLanguage.RSC], 
            ["hr", PageLanguage.RS], 
            ["bs", PageLanguage.RS]
            #["en", PageLanguage.UK]
        ]

        if not browser_lang:
            return default

        for map in browser_mapping:            
            if browser_lang and len(browser_lang) >= len(map[0]) and browser_lang[0:len(map[0])] == map[0]:
                return map[1]

        return default





class PageParameters(object):


    # Default version of all parameters
    _default_params = {
        "root" : "",                                         # main URL handle (http://<web_site>/<root>)
        "op" : PageOperation.DEFAULT,
        "q_id" : "",
        "l_id" : "",
        "interval": "",
        "year" : "",
        "theme" : "",
        "subtheme" : "",
        "topic" : "",
        "period" : "",
        "difficulty" : "",                                  # Difficulty level for the current test
        "q_num" : "",
        "skipped" : "",
        "language" : None,

        # Parameters for edit mode
        "init_code" : "",
        "iter_code" : "",
        "text" : "",

        # Design style
        # "design" : PageDesign.DEV,

        # Enable to get features in beta
        "beta" : False,

        # Current URL in the full form
        "url" : None
    }

    # Actions that should be applied only once and not saved in the state
    _default_actions = {
        "skipped" : "",
    }

    # Actions that should be saved in the state
    _default_states = {
        "l_id" : "",
        "interval" : "",
        "period" : "",
        "difficulty" : "",
        "q_num" : "",
        "beta" : True
    }


    _params = _default_params.copy()


    # Raise exception on any error - useful for testing
    # Set raise_exception=1 in URL to trigger exceptions
    with_exception = False





    @staticmethod
    def encode_params(args : dict):
        return encode_dict(args)


    @staticmethod
    def decode_params(args : dict, with_exception : bool = False):
        if not "state" in args.keys() or not args["state"]:
            if with_exception:
                raise PageParameterParsingError()
            else:
                return {}

        return decode_dict(args["state"])

    def __init__(self, args : dict = None):
        self._params = self._default_params.copy()
        if not args is None:
            self.parse(args)


    def set_url(self, url):
        self.url = url


    def get_url(self):
        return self.url


    def delete_history(self):
        context.c.session.set("history", [])
        context.c.session.set("test_id", 0)
        context.c.session.delete("browse_last_q")

        # Do not delete here as we call this after the start of the test
        # No need to delete, we'll just set to new
        # context.c.session.delete("period")
        # context.c.session.delete("difficulty")
        # context.c.session.delete("q_num")



    def get_param(self, key):
        if key not in self._params:
            return None
        return self._params[key]

    def set_param(self, key, val):
        self._params[key] = val

    def copy_to_serializible_state(self):
        new_dict = copy.deepcopy(self._params)
        if "op" in self._params.keys():
            new_dict["op"] = PageOperation.toStr(self._params["op"])
        if "language" in self._params.keys():
            new_dict["language"] = PageLanguage.toStr(self._params["language"])
        return new_dict

    def load_from_serializible_state(self, params):
        if params is None:
            self._params = self._default_params.copy()
        else:
            self._params = copy.deepcopy(params)
            if "op" in params.keys():
                try:
                    self._params["op"] = PageOperation(params["op"])
                except ValueError:
                    self._params["op"] = PageOperation.DEFAULT

            if "language" in params.keys():
                self._params["language"] = PageLanguage.fromStr(params["language"])



    def print_params(self):
        logging.debug("\n\n Printing parameters: {}\n\n".format(json.dumps(self.copy_to_serializible_state(), indent=2)))
        #print("\n\n Printing parameters: {}\n\n".format(json.dumps(self.copy_to_serializible_state(), indent=2)))

    def _str_to_url(self, s, default, js=False):
        if s is None:
            s = default
            s = "" if s is None else s
            s = encap_str(s) if js else s
        return s


    def _dict_to_url(self, s, default, js=False):
        if s is None:
            s = default
            s = {} if s is None else s
        s = encode_dict(s)
        s = encap_str(s) if js else s
        return s





    def parse(self, in_args : dict, session=None): 

        # First check if there are any parameters packet encoded in "state" variable
        if "state" in in_args.keys():
            # Decode "state" and add to other parameters
            args = {**in_args, **PageParameters.decode_params(in_args, self.with_exception)}
        else:
            args = in_args

        if "raise_exception" in args.keys() and args["raise_exception"] == 1:
            self.with_exception = True


        if self._params == None:
            self._params = self._default_params.copy()


        if "root" in args.keys():
            self._params["root"] = args["root"]


        if "permalink" in args.keys():
            ind = 0
            self._params["op"] = PageOperation.MENU_YEAR
            if len(args["permalink"]) > 1 and args["permalink"][0] == "language":
                self._params["language"] = PageLanguage.fromStr(args["permalink"][1], self.with_exception)
                ind = 2

            if len(args["permalink"]) > ind:
                if PageOperation.isValid(args["permalink"][ind]):
                    self._params["op"] = PageOperation(args["permalink"][ind])
                else:
                    if self.with_exception:
                        raise PageParameterParsingError()
                    self._params["op"] = PageOperation.DEFAULT

                if len(args["permalink"]) > ind+2 and args["permalink"][ind+1] == "year":
                    self._params["year"] = args["permalink"][ind+2]
                    if len(args["permalink"]) > ind+4 and args["permalink"][ind+3] == "theme":
                        self._params["theme"] = args["permalink"][ind+4]
                        ind = 7
                        while ind + 1 < len(args["permalink"]):
                            if args["permalink"][ind] == "subtheme":
                                self._params["subtheme"] = args["permalink"][ind+1]
                                ind += 2
                            elif args["permalink"][ind] == "topic":
                                self._params["topic"] = args["permalink"][ind+1]
                                ind += 2
                            elif args["permalink"][ind] == "question":
                                if ind + 2 < len(args["permalink"]):
                                    self._params["q_id"] = args["permalink"][ind+1] + "/" + args["permalink"][ind+2]
                                    ind += 3
                                else:
                                    logging.info("Expecting more inputs {}.".format(args["permalink"]))
                                    break
                            else:
                                break


        # Process actions from GET parameters
        for k,v in args.items():
            if k in self._default_actions.keys() or k in self._default_states.keys():
                # If v empty string use the default value
                if not v:
                    if k in self._default_actions.keys():
                        v = self._default_actions[k]
                    else:
                        v = self._default_states[k]
                self._params[k] = v
                if session and k in self._default_states.keys():
                    session.set(k, v)





    def _add_path_to_url(self, url, key, val=None):
        if val:
            url += "/" + key + "/" + val
        else:
            url += "/" + key
        return url

    def _add_val_to_url(self, url, first, key, val=None):
        if val:
            if first:
                url += "?{}={}".format(key, val)
            else:
                url += "&{}={}".format(key, val)
            return url, False

        return url, first





    def create_url(self, root=None, op=None, q_id=None, year=None, theme=None, 
        subtheme=None, topic=None, language=None, beta=None, **kwargs):

        if root is None:
            root = "/" + self._params["root"]

        if op is None:
            op = self._params["op"]
        q_id = self._str_to_url(q_id, self._params["q_id"])
        year = self._str_to_url(year, self._params["year"])
        theme = self._str_to_url(theme, self._params["theme"])
        subtheme = self._str_to_url(subtheme, self._params["subtheme"])
        topic = self._str_to_url(topic, self._params["topic"])

        url = root

        if language:
            url = self._add_path_to_url(url, "language", language)

        url = self._add_path_to_url(url, op.value)

        if op == PageOperation.MENU_YEAR or op == PageOperation.DEFAULT:
            pass
        elif op == PageOperation.MENU_THEME:
            url = self._add_path_to_url(url, "year", year)
        elif op == PageOperation.TEST or op == PageOperation.TEST_INTRO or \
             op == PageOperation.BROWSE or op == PageOperation.BROWSE_INTRO or \
             op == PageOperation.SUMMARY:
            url = self._add_path_to_url(url, "year", year)
            url = self._add_path_to_url(url, "theme", theme)
            if subtheme:
                url = self._add_path_to_url(url, "subtheme", subtheme)
                if topic:
                    url = self._add_path_to_url(url, "topic", topic)
            if op == PageOperation.TEST or op == PageOperation.BROWSE:
                url = self._add_path_to_url(url, "question", q_id)
            else:
                url = self._add_path_to_url(url, op.value)


        session = None
        try:
            session = context.c.session
        except:
            pass

        first = True
        for k,v in kwargs.items():
            if session and k in session.keys() and session.get(k) == v:
                continue
            if v is None:
                v = False
            if isinstance(v, str):
                val = self._str_to_url(v, self._default_params[k])
            elif isinstance(v, bool):
                val = "true" if v else ""
            url, first = self._add_val_to_url(url, first, k, v)


        return url








    def add_code(self, init_code : str = "", iter_code : str = "", text : str = ""):
        self._params["init_code"] = init_code
        self._params["iter_code"] = iter_code
        self._params["text"] = text

    
    # URL parse for EDIT mode
    def parse_edit(self, in_args : dict):

        # First check if there are any parameters packet encoded in "state" variable
        if "state" in in_args.keys():
            # Decode "state" and add to other parameters
            args = {**in_args, **PageParameters.decode_params(in_args, self.with_exception)}
        else:
            args = in_args

        if "raise_exception" in args.keys() and args["raise_exception"] == 1:
            self.with_exception = True


        if self._params == None:
            self._params = self._default_params.copy()


        if "root" in args.keys():
            self._params["root"] = args["root"]
        else:
            self._params["root"] = ""

        if "op" in args.keys():
            try:
                self._params["op"] = PageOperation(args["op"])
            except ValueError:
                if self.with_exception:
                    raise PageParameterParsingError()

                self._params["op"] = PageOperation.DEFAULT

        if "language" in args.keys():
            self._params["language"] = PageLanguage.fromStr(args["language"], self.with_exception)

        if ("q_id" in args.keys()) and (not args["q_id"] is None) and args["q_id"]:
            self._params["q_id"] = args["q_id"]
        else:
            self._params["q_id"] = ""

        if ("l_id" in args.keys()) and (not args["l_id"] is None) and args["l_id"]:
            self._params["l_id"] = args["l_id"]
        else:
            self._params["l_id"] = ""

        if ("interval" in args.keys()) and (not args["interval"] is None) and args["interval"]:
            self._params["interval"] = args["interval"]
        else:
            self._params["interval"] = "7"

        if "init_code" in args.keys():
            self._params["init_code"] = args["init_code"]

        if "iter_code" in args.keys():
            self._params["iter_code"] = args["iter_code"]

        if "text" in args.keys():
            self._params["text"] = args["text"]

        if "beta" in args.keys():
            self._params["beta"] = True

        if "user_agent" in args.keys():
            self._params["mobile"] = is_user_on_mobile(args["user_agent"])
        else:
            self._params["mobile"] = False


    # These parameters have to be strings (even op, language, design, user_id)
    # as they can be JS variables
    def create_url_edit(self, root=None, op=None, q_id=None, l_id=None, interval=None,
                   language=None, beta=None, js=False):
        if root is None:
            root = self._params["root"]
            root = encap_str(root) if js else root
        if op is None:
            op = PageOperation.toStr(self._params["op"])
            op = encap_str(op) if js else op
        q_id = self._str_to_url(q_id, self._params["q_id"], js)
        l_id = self._str_to_url(l_id, self._params["l_id"], js)
        interval = self._str_to_url(interval, self._params["interval"], js)
        if language is None:
            language = PageLanguage.toStr(self._params["language"])
            language = encap_str(language) if js else language
        beta = not (beta is None)

        if js:
            url = ("{} + \"?op=\" + {} + \"&q_id=\" + {} + \"&l_id=\" + {} + \"&interval=\" + {} + \"&language=\" + {}").format(
                      root, op, q_id, l_id, interval, language
                  )
            if beta:
                url += " + \"&beta\" "
        else:
            url = ("{}?op={}&q_id={}&l_id={}&interval={}&language={}").format(
                      root, op, q_id, l_id, interval, language
                  )
            if beta:
                url += "&beta"

        return url