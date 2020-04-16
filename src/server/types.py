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
    SUBMIT = 0
    SKIP = 1
    @classmethod
    def toStr(cls, enum ) -> str:
        if enum == ResponseOperation.SUBMIT:
            return "SUBMIT"
        elif enum == ResponseOperation.SKIP:
            return "SKIP"
            



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
    # Full-screen menu
    MENU = 7
    # Set this when not specified, so each menu can decide
    DEFAULT = 8
    # Stats
    STATS = 9
    # Intro
    INTRO = 10
    # Summary
    SUMMARY = 11

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
        elif enum == PageOperation.MENU:
            return "menu"
        elif enum == PageOperation.DEFAULT:
            return "default"
        elif enum == PageOperation.STATS:
            return "stats"
        elif enum == PageOperation.INTRO:
            return "intro"
        elif enum == PageOperation.SUMMARY:
            return "summary"

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
        elif name.lower() == "login_test":
            return PageOperation.LOGIN
        elif name.lower() == "menu":
            return PageOperation.MENU
        elif name.lower() == "default":
            return PageOperation.DEFAULT
        elif name.lower() == "stats":
            return PageOperation.STATS
        elif name.lower() == "intro":
            return PageOperation.INTRO
        elif name.lower() == "summary":
            return PageOperation.SUMMARY
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
    # Parameters learned about the user from HTTP request
    class UserParameters(object):
        def __init__(self, remote_ip=None, user_agent=None, user_laguage=None):
            self.remote_ip = remote_ip if remote_ip else ""
            self.user_agent = user_agent if user_agent else ""
            self.user_laguage = user_laguage if user_laguage else ""


    # General parameters
    root = ""                                         # main URL handle (http://<web_site>/<root>)
    op = PageOperation.TEST
    q_id = ""
    l_id = ""
    year = ""
    theme = ""
    subtheme = ""
    period = ""
    difficulty = ""
    language = PageLanguage.RS
    user_param = UserParameters()
    back = False                                       # we went back from the last question


    # Parameters for edit mode
    init_code = ""
    iter_code = ""
    text = ""


    # Design style
    design = PageDesign.DEV

    # Is user on a mobile device
    mobile = True

    # Raise exception on any error - useful for testing
    # Set raise_exception=1 in URL to trigger exceptions
    with_exception = False


    # Current URL in the full form
    url = None


    # The entire state as arrived in the request 
    # (with encoded state decoded and added to the dict)
    all_state = {}



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
        if not args is None:
            self.parse(args)


    def set_url(self, url):
        self.url = url
        

    def get_url(self):
        return self.url
        

    def delete_history(self):
        context.c.session.set("history", [])


    def parse(self, in_args : dict):

        # First check if there are any parameters packet encoded in "state" variable
        if "state" in in_args.keys():
            # Decode "state" and add to other parameters
            args = {**in_args, **PageParameters.decode_params(in_args, self.with_exception)}
        else:
            args = in_args


        self.all_state = args

        if "raise_exception" in args.keys() and args["raise_exception"] == 1:
            self.with_exception = True

        if "root" in args.keys():
            self.root = args["root"]
        else:
            self.root = ""

        if "op" in args.keys():
            self.op = PageOperation.fromStr(args["op"], self.with_exception)
        else:
            self.op = PageOperation.DEFAULT

        if "design" in args.keys():
            self.design = PageDesign.fromStr(args["design"])

        if "back" in args.keys():
            self.design = (args["back"].lower() == "true")

        if "mobile" in args.keys():
            self.mobile = args["mobile"]
        else:
            self.mobile = True

        if "language" in args.keys():
            self.language = PageLanguage.fromStr(args["language"], self.with_exception)

        if ("q_id" in args.keys()) and (not args["q_id"] is None) and args["q_id"]:
            self.q_id = args["q_id"]
        else:
            self.q_id = ""

        if ("l_id" in args.keys()) and (not args["l_id"] is None) and args["l_id"]:
            self.l_id = args["l_id"]
        else:
            self.l_id = ""

        if ("year" in args.keys()) and (not args["year"] is None) and args["year"]:
            self.year = args["year"]

        if ("theme" in args.keys()) and (not args["theme"] is None) and args["theme"]:
            self.theme = args["theme"]

        if ("subtheme" in args.keys()) and (not args["subtheme"] is None) and args["subtheme"]:
            self.subtheme = args["subtheme"]

        if ("period" in args.keys()) and (not args["period"] is None) and args["period"]:
            self.period = args["period"]

        if ("difficulty" in args.keys()) and (not args["difficulty"] is None) and args["difficulty"]:
            self.difficulty = args["difficulty"]

        if "init_code" in args.keys():
            self.init_code = args["init_code"]

        if "iter_code" in args.keys():
            self.iter_code = args["iter_code"]

        if "text" in args.keys():
            self.text = args["text"]


        if "remote_ip" in args.keys():
            self.user_param.remote_ip = args["remote_ip"]

        if "user_agent" in args.keys():
            self.user_param.user_agent = args["user_agent"]
            self.mobile = is_user_on_mobile(self.user_param.user_agent)
        else:
            self.mobile = False

        if "user_language" in args.keys():
            self.user_param.user_language = args["user_language"]



    def add_code(self, init_code : str = "", iter_code : str = "", text : str = ""):
        self.init_code = init_code
        self.iter_code = iter_code
        self.text = text


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


    # These parameters have to be strings (even op, language, design, user_id)
    # as they can be JS variables
    def create_url(self, root=None, op=None, q_id=None, l_id=None, year=None, 
                   theme=None, subtheme=None, period=None, difficulty=None,
                   language=None, design=None, back=False, js=False):
        if root is None:
            root = self.root
            root = encap_str(root) if js else root
        if op is None:
            op = PageOperation.toStr(self.op)
            op = encap_str(op) if js else op
        q_id = self._str_to_url(q_id, self.q_id, js)
        l_id = self._str_to_url(l_id, self.l_id, js)
        if language is None:
            language = PageLanguage.toStr(self.language)
            language = encap_str(language) if js else language
        if design is None:
            design = PageDesign.toStr(self.design)
            design = encap_str(design) if js else design
        year = self._str_to_url(year, self.year, js)
        theme = self._str_to_url(theme, self.theme, js)
        subtheme = self._str_to_url(subtheme, self.subtheme, js)
        period = self._str_to_url(period, self.period, js)
        difficulty = self._str_to_url(difficulty, self.difficulty, js)

        if js:
            url = f"{root} + \"?op=\" + {op} + \"&q_id=\" + {q_id} + \"&l_id=\" + {l_id} " \
                  f"+ \"&year=\" + {year} + \"&theme=\" + {theme} " \
                  f"+ \"&subtheme=\" + {subtheme} + \"&period=\" + {period} + \"&difficulty=\" + {difficulty} " \
                  f"+ \"&language=\" + {language} + \"&design=\" + {design} " + \
                      (" + \"&back=true\"" if back else "")
        else:
            url = f"{root}?op={op}&q_id={q_id}&l_id={l_id}&year={year}" \
                  f"&theme={theme}&subtheme={subtheme}&period={period}" \
                  f"&difficulty={difficulty}&language={language}&design={design}" + \
                      ("&back=true" if back else "")

        return url
