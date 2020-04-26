import copy
import json

from enum import Enum, unique
from server.helpers import encode_dict
from server.helpers import decode_dict
from server.helpers import is_user_on_mobile
from server.helpers import encap_str

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
    TEST = 0
    # View one question (DEV mode)
    VIEW = 1
    # Editor view of one question (DEV mode)
    EDIT = 2
    # View all questions in a list (DEV mode)
    LIST = 3
    # Generate modified question in editor mode (DEV mode)
    GENERATE = 4
    # Register new a result in the table
    REGISTER = 5
    # Submit login request
    LOGIN = 6
    # Menu - select user
    MENU_USER = 7
    # Menu - select year
    MENU_YEAR = 8
    # Menu - select theme
    MENU_THEME = 9
    # Menu - select subtheme
    MENU_SUBTHEME = 10
    # Set this when not specified, so each menu can decide
    DEFAULT = 11
    # Stats
    STATS = 12
    # Intro
    INTRO = 13
    # Summary
    SUMMARY = 14
    # Previous question in test
    TEST_PREV = 15
    # Report an issue in question
    FEEDBACK = 16

    @classmethod
    def toStr(cls, enum) -> str:
        if enum == PageOperation.VIEW:
            return "view"
        elif enum == PageOperation.EDIT:
            return "edit"
        elif enum == PageOperation.TEST:
            return "test"
        elif enum == PageOperation.LIST:
            return "list"
        elif enum == PageOperation.GENERATE:
            return "generate"
        elif enum == PageOperation.REGISTER:
            return "register"
        elif enum == PageOperation.LOGIN:
            return "login"
        elif enum == PageOperation.MENU_USER:
            return "menu_user"
        elif enum == PageOperation.MENU_YEAR:
            return "menu_year"
        elif enum == PageOperation.MENU_THEME:
            return "menu_theme"
        elif enum == PageOperation.MENU_SUBTHEME:
            return "menu_subtheme"
        elif enum == PageOperation.DEFAULT:
            return "default"
        elif enum == PageOperation.STATS:
            return "stats"
        elif enum == PageOperation.INTRO:
            return "intro"
        elif enum == PageOperation.SUMMARY:
            return "summary"
        elif enum == PageOperation.TEST_PREV:
            return "test_prev"
        elif enum == PageOperation.FEEDBACK:
            return "feedback"

    @classmethod
    def fromStr(cls, name:str, with_exception : bool = False):
        if name.lower() == "view":
            return PageOperation.VIEW
        elif name.lower() == "edit":
            return PageOperation.EDIT
        elif name.lower() == "test":
            return PageOperation.TEST
        elif name.lower() == "list":
            return PageOperation.LIST
        elif name.lower() == "generate":
            return PageOperation.GENERATE
        elif name.lower() == "login":
            return PageOperation.LOGIN
        elif name.lower() == "menu_user":
            return PageOperation.MENU_USER
        elif name.lower() == "menu_year":
            return PageOperation.MENU_YEAR
        elif name.lower() == "menu_theme":
            return PageOperation.MENU_THEME
        elif name.lower() == "menu_subtheme":
            return PageOperation.MENU_SUBTHEME
        elif name.lower() == "default":
            return PageOperation.DEFAULT
        elif name.lower() == "stats":
            return PageOperation.STATS
        elif name.lower() == "intro":
            return PageOperation.INTRO
        elif name.lower() == "summary":
            return PageOperation.SUMMARY
        elif name.lower() == "test_prev":
            return PageOperation.TEST_PREV
        elif name.lower() == "feedback":
            return PageOperation.FEEDBACK
        else:
            if with_exception:
                raise PageParameterParsingError()
            else:
                return PageOperation.DEFAULT





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
        "period" : "",
        "difficulty" : "",
        "language" : PageLanguage.RS,
        "user_param" : {
            "remote_ip" : "",
            "user_agent" : "",
            "user_laguage" : ""
        },

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
                self._params["op"] = PageOperation.fromStr(params["op"])
            if "language" in params.keys():
                self._params["language"] = PageLanguage.fromStr(params["language"])
            if "design" in params.keys():
                self._params["design"] = PageDesign.fromStr(params["design"])

    def save_params(self):
        context.c.session.set("params", self.copy_to_serializible_state())
        logging.debug("\n\n Saving parameters: {}\n\n".format(context.c.session.get("params")))
        
    def load_params(self):
        self.load_from_serializible_state(context.c.session.get("params"))
        logging.debug("\n\n Loading parameters: {}\n\n".format(context.c.session.get("params")))

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

        if legacy:
            update_only=False
        else:
            update_only=True

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
            self._params["op"] = PageOperation.fromStr(args["op"], self.with_exception)
            updated = True
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

        if ("period" in args.keys()) and (not args["period"] is None) and args["period"]:
            self._params["period"] = args["period"]
            updated = True

        if ("difficulty" in args.keys()) and (not args["difficulty"] is None) and args["difficulty"]:
            self._params["difficulty"] = args["difficulty"]
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


        if "remote_ip" in args.keys():
            self._params["user_param"]["remote_ip"] = args["remote_ip"]
            updated = True
        else:
            if not update_only:
                self._params["user_param"]["remote_ip"] = ""

        if "user_agent" in args.keys():
            self._params["user_param"]["user_agent"] = args["user_agent"]
            self._params["mobile"] = is_user_on_mobile(self._params["user_param"]["user_agent"])
            updated = True
        else:
            if not update_only:
                self._params["mobile"] = False

        if "user_language" in args.keys():
            self._params["user_param"]["user_language"] = args["user_language"]
            updated = True
        else:
            if not update_only:
                self._params["user_param"]["user_language"] = ""

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
                   theme=None, subtheme=None, period=None, difficulty=None,
                   language=None, design=None, js=False):
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
        period = self._str_to_url(period, self._params["period"], js)
        difficulty = self._str_to_url(difficulty, self._params["difficulty"], js)

        if js:
            url = ("{} + \"?op=\" + {} + \"&q_id=\" + {} + \"&l_id=\" + {} " \
                  "+ \"&year=\" + {} + \"&theme=\" + {} " \
                  "+ \"&subtheme=\" + {} + \"&period=\" + {} + \"&difficulty=\" + {} " \
                  "+ \"&language=\" + {} + \"&design=\" + {} ").format(
                      root, op, q_id, l_id, year, theme, subtheme, period, difficulty, language, design
                  )
        else:
            url = ("{}?op={}&q_id={}&l_id={}&year={}" \
                  "&theme={}&subtheme={}&period={}" \
                  "&difficulty={}&language={}&design={}").format(
                      root, op, q_id, l_id, year, theme, subtheme, period, difficulty, language, design
                  )

        return url
