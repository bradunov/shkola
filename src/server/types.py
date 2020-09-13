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
    # Menu - select subtheme
    MENU_SUBTHEME = "menu_subtheme"
    # Set this when not specified, so each menu can decide
    DEFAULT = "default"
    # Stats
    STATS = "stats"
    # Intro
    INTRO = "intro"
    # Summary
    SUMMARY = "summary"
    # Previous question in test
    TEST_PREV = "test_prev"
    # Report an issue in question
    FEEDBACK = "feedback"

    # TODO: remove this method
    @classmethod
    def toStr(cls, enum) -> str:
        return enum.value


@unique
class PageLanguage(Enum):
    RS = 0
    UK = 1

    @classmethod
    def toStr(cls, enum) -> str:
        if enum == PageLanguage.RS:
            return "rs"
        elif enum == PageLanguage.UK:
            return "uk"

    @classmethod
    def fromStr(cls, name : str, with_exception : bool = False):
        if name.lower() == "rs":
            return PageLanguage.RS
        elif name.lower() == "uk":
            return PageLanguage.UK
        else:
            if with_exception:
                raise PageParameterParsingError()
            else:
                # Default language
                return PageLanguage.RS


class PageParameters(object):


    # General parameters
    _default_params = {
        "root" : "",                                         # main URL handle (http://<web_site>/<root>)
        "op" : PageOperation.DEFAULT,
        "q_id" : "",
        "l_id" : "",
        "year" : "",
        "theme" : "",
        "subtheme" : "",
        "topic" : "",
        "period" : "",
        "difficulty" : "",                                  # Difficulty level for the current test 
        "q_num" : "",
        "q_diff" : "",                                      # Difficulty level of the last question (may differ from the test)
        "language" : PageLanguage.RS,

        # Parameters for edit mode
        "init_code" : "",
        "iter_code" : "",
        "text" : "",

        # Design style
        "design" : PageDesign.DEV,

        # Is user on a mobile device
        "mobile" : True,

        # Current URL in the full form
        "url" : None
    }

    _params = _default_params


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
        self._params = self._default_params
        if not args is None:
            self.parse(args)


    def set_url(self, url):
        self.url = url
        

    def get_url(self):
        return self.url
        

    def delete_history(self):
        context.c.session.set("history", [])
        context.c.session.set("test_id", 0)


    def get_param(self, key):
        if key not in self._params:
            return None
        return self._params[key]

    def set_param(self, key, val):
        self._params[key] = val
        self.save_params()

    def delete_params(self):
        self._params = self._default_params
        self.save_params()

    def copy_to_serializible_state(self):
        new_dict = copy.deepcopy(self._params)
        if "op" in self._params.keys():
            new_dict["op"] = PageOperation.toStr(self._params["op"])
        if "language" in self._params.keys():
            new_dict["language"] = PageLanguage.toStr(self._params["language"])
        if "design" in self._params.keys():
            new_dict["design"] = PageDesign.toStr(self._params["design"])
        return new_dict

    def load_from_serializible_state(self, params):
        if params is None:
            self._params = self._default_params
        else:
            self._params = copy.deepcopy(params)
            if "op" in params.keys():
                try:
                    self._params["op"] = PageOperation(params["op"])
                except ValueError:
                    self._params["op"] = PageOperation.DEFAULT

            if "language" in params.keys():
                self._params["language"] = PageLanguage.fromStr(params["language"])
            if "design" in params.keys():
                self._params["design"] = PageDesign.fromStr(params["design"])

    def save_params(self):
        try:
            context.c.session.set("params", self.copy_to_serializible_state())
        except:
            # Temporary hack for edit menus that don't have context
            pass
        # logging.debug("\n\n Saving parameters: {}\n\n".format(context.c.session.get("params")))
        
    def load_params(self):
        try:
            self.load_from_serializible_state(context.c.session.get("params"))
            # Do not load op from state. See https://github.com/bradunov/shkola/issues/23
            if "op" in self._params.keys():
                del self._params["op"]
            # logging.debug("\n\n Loading parameters: {}\n\n".format(context.c.session.get("params")))
        except:
            # Temporary hack for edit menus that don't have context
            pass


    def print_params(self):
        logging.debug("\n\n Printing parameters: {}\n\n".format(json.dumps(self.copy_to_serializible_state(), indent=2)))

    def _str_to_url(self, s, default, js):
        if s is None:
            s = default                
            s = "" if s is None else s
            s = encap_str(s) if js else s
        return s


    def _dict_to_url(self, s, default, js):
        if s is None:
            s = default                
            s = {} if s is None else s
        s = encode_dict(s)
        s = encap_str(s) if js else s
        return s




    # legacy = True for pre-session design (used in EDIT mode)

    def parse(self, in_args : dict, legacy=False):

        update_only = not legacy
        updated = False

        # First check if there are any parameters packet encoded in "state" variable
        if "state" in in_args.keys():
            # Decode "state" and add to other parameters
            args = {**in_args, **PageParameters.decode_params(in_args, self.with_exception)}
        else:
            args = in_args

        if "raise_exception" in args.keys() and args["raise_exception"] == 1:
            self.with_exception = True



        if self._params == None:
            self._params = self._default_params


        if "root" in args.keys():
            self._params["root"] = args["root"]
            updated = True
        else:
            if not update_only:
                self._params["root"] = ""

        if "op" in args.keys():
            updated = True
            try:
                self._params["op"] = PageOperation(args["op"])
            except ValueError:
                if self.with_exception:
                    raise PageParameterParsingError()

                self._params["op"] = PageOperation.DEFAULT
        # Else do not set, use whatever is in the state
        # Otherwise use the menu (that shows on any page) to go wherever.
        # else:
        #     self._params["op"] = PageOperation.DEFAULT
        #     updated = True

        if "design" in args.keys():
            self._params["design"] = PageDesign.fromStr(args["design"])
            updated = True

        if "mobile" in args.keys():
            self._params["mobile"] = args["mobile"]
            updated = True
        else:
            if not update_only:
                self._params["mobile"] = True

        if "language" in args.keys():
            self._params["language"] = PageLanguage.fromStr(args["language"], self.with_exception)
            updated = True

        if ("q_id" in args.keys()) and (not args["q_id"] is None) and args["q_id"]:
            self._params["q_id"] = args["q_id"]
            updated = True
        else:
            if not update_only:
                self._params["q_id"] = ""

        if ("l_id" in args.keys()) and (not args["l_id"] is None) and args["l_id"]:
            self._params["l_id"] = args["l_id"]
            updated = True
        else:
            if not update_only:
                self._params["l_id"] = ""

        if ("year" in args.keys()) and (not args["year"] is None) and args["year"]:
            self._params["year"] = args["year"]
            updated = True

        if ("theme" in args.keys()) and (not args["theme"] is None) and args["theme"]:
            self._params["theme"] = args["theme"]
            updated = True

        if ("subtheme" in args.keys()) and (not args["subtheme"] is None) and args["subtheme"]:
            self._params["subtheme"] = args["subtheme"]
            updated = True

        if ("topic" in args.keys()) and (not args["topic"] is None) and args["topic"]:
            self._params["topic"] = args["topic"]
            updated = True

        if ("period" in args.keys()) and (not args["period"] is None) and args["period"]:
            self._params["period"] = args["period"]
            updated = True

        if ("difficulty" in args.keys()) and (not args["difficulty"] is None) and args["difficulty"]:
            self._params["difficulty"] = args["difficulty"]
            updated = True

        if ("q_num" in args.keys()) and (not args["q_num"] is None) and args["q_num"]:
            self._params["q_num"] = args["q_num"]
            updated = True

        if ("q_diff" in args.keys()) and (not args["q_diff"] is None) and args["q_diff"]:
            self._params["q_diff"] = args["q_diff"]
            updated = True

        if "init_code" in args.keys():
            self._params["init_code"] = args["init_code"]
            updated = True

        if "iter_code" in args.keys():
            self._params["iter_code"] = args["iter_code"]
            updated = True

        if "text" in args.keys():
            self._params["text"] = args["text"]
            updated = True

        if "user_agent" in args.keys():
            self._params["mobile"] = is_user_on_mobile(args["user_agent"])
            updated = True
        else:
            if not update_only:
                self._params["mobile"] = False

        if not legacy:
            if updated:
                self.save_params()



    def add_code(self, init_code : str = "", iter_code : str = "", text : str = ""):
        self._params["init_code"] = init_code
        self._params["iter_code"] = iter_code
        self._params["text"] = text




    # These parameters have to be strings (even op, language, design, user_id)
    # as they can be JS variables
    def create_url(self, root=None, op=None, q_id=None, l_id=None, year=None, 
                   theme=None, subtheme=None, topic=None, period=None, difficulty=None,
                   q_num=None, q_diff=None, language=None, design=None, js=False):
        if root is None:
            root = self._params["root"]
            root = encap_str(root) if js else root
        if op is None:
            op = PageOperation.toStr(self._params["op"])
            op = encap_str(op) if js else op
        q_id = self._str_to_url(q_id, self._params["q_id"], js)
        l_id = self._str_to_url(l_id, self._params["l_id"], js)
        if language is None:
            language = PageLanguage.toStr(self._params["language"])
            language = encap_str(language) if js else language
        if design is None:
            design = PageDesign.toStr(self._params["design"])
            design = encap_str(design) if js else design
        year = self._str_to_url(year, self._params["year"], js)
        theme = self._str_to_url(theme, self._params["theme"], js)
        subtheme = self._str_to_url(subtheme, self._params["subtheme"], js)
        topic = self._str_to_url(topic, self._params["topic"], js)
        period = self._str_to_url(period, self._params["period"], js)
        difficulty = self._str_to_url(difficulty, self._params["difficulty"], js)
        q_num = self._str_to_url(q_num, self._params["q_num"], js)
        q_diff = self._str_to_url(q_diff, self._params["q_diff"], js)

        if js:
            url = ("{} + \"?op=\" + {} + \"&q_id=\" + {} + \"&l_id=\" + {} " \
                  "+ \"&year=\" + {} + \"&theme=\" + {} " \
                  "+ \"&subtheme=\" + {} + \"&topic=\" + {} + \"&period=\" + {} + \"&difficulty=\" + {} " \
                  "+ \"&q_num=\" + {} + \"&q_diff=\" + {} + \"&language=\" + {} + \"&design=\" + {} ").format(
                      root, op, q_id, l_id, year, theme, subtheme, topic, period, difficulty, q_num, q_diff, language, design
                  )
        else:
            url = ("{}?op={}&q_id={}&l_id={}&year={}" \
                  "&theme={}&subtheme={}&topic={}&period={}" \
                  "&difficulty={}&q_num={}&q_diff={}&language={}&design={}").format(
                      root, op, q_id, l_id, year, theme, subtheme, topic, period, difficulty, q_num, q_diff, language, design
                  )

        return url
