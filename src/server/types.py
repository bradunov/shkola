from enum import Enum, unique
from helper import *


class PageParameterParsingError(Exception):
    pass


# Register response in the table
@unique
class ResponseOperation(Enum):
    SUBMIT = auto()
    SKIP = auto()
    @classmethod
    def toStr(cls, enum : ResponseOperation) -> str:
        if enum == ResponseOperation.SUBMIT:
            return "SUBMIT"
        elif enum == ResponseOperation.SKIP:
            return "SKIP"
            



@unique
class PageDesign(Enum):
    DEFAULT = auto()
    DEV = auto()
    @classmethod
    def toStr(cls, enum : PageDesign) -> str:
        if enum == PageDesign.DEFAULT:
            return "default"
        elif enum == PageDesign.DEV:
            return "dev"

    @classmethod
    def fromStr(cls, name:str) -> PageDesign:
        if name.lower() == "default":
            return PageDesign.DEFAULT
        elif name.lower() == "dev":
            return PageDesign.DEV
        else:
            return PageDesign.DEFAULT
   




@unique
class PageOperation(Enum):
    # Testing - the default view for users
    TEST = auto()
    # View one question (DEV mode)
    VIEW = auto()
    # Editor view of one question (DEV mode)
    EDIT = auto()
    # View all questions in a list (DEV mode)
    LIST = auto()
    # Generate modified question in editor mode (DEV mode)
    GENERATE = auto()
    # Register new a result in the table
    REGISTER = auto()
    # Submit login request
    LOGIN = auto()

    @classmethod
    def toStr(cls, enum : PageOperation) -> str:
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

    @classmethod
    def fromStr(cls, name:str, with_exception : bool = False) -> PageOperation:
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
        else:
            if with_exception:
                raise PageParameterParsingError
            else:
                # Default operation
                return PageOperation.TEST





@unique
class PageLanguage(Enum):
    RS = auto()
    UK = auto()

    @classmethod
    def toStr(cls, enum : PageLanguage) -> str:
        if enum == PageLanguage.RS:
            return "rs"
        elif enum == PageLanguage.UK:
            return "uk"

    @classmethod
    def fromStr(cls, name : str, with_exception : bool = False) -> PageOperation:
        if name.lower() == "rs":
            return PageLanguage.RS
        elif name.lower() == "uk":
            return PageLanguage.UK
        else:
            if with_exception:
                raise PageParameterParsingError
            else:
                # Default language
                return PageLanguage.RS








class PageUserID(object):
    user_id : str

    def __init__(self, user_id : str):
        self.user_id = user_id

    def toStr(self) -> str:
        return self.user_id




class PageParameters(object):
    # Parameters learned about the user from HTTP request
    class UserParameters(object):
        remote_ip : str
        user_agent : str
        user_laguage : str
        def __init__(self, remote_ip=None, user_agent=None, user_laguage=None):
            self.remote_ip = remote_ip if remote_ip else ""
            self.user_agent = user_agent if user_agent else ""
            self.user_laguage = user_laguage if user_laguage else ""


    # General parameters
    op : PageOperation = PageOperation.TEST
    q_id : str = ""
    l_id : str = ""
    language : str = PageLanguage.RS
    user_id : PageUserID = None
    user_param : UserParameters = UserParameters()

    # Parameters for edit mode
    init_code : str = ""
    iter_code : str = ""
    text : str = ""


    # Design style
    design : PageDesign = PageDesign.DEFAULT
    # Is user on a mobile device
    mobile : bool = True

    # Raise exception on any error - useful for testing
    # Set raise_exception=1 in URL to trigger exceptions
    with_exception = False


    # The entire state as arrived in the request 
    # (with encoded state decoded and added to the dict)
    all_state : dict



    @staticmethod
    def encode_params(args : dict):
        return encode_dict(args)


    @staticmethod
    def decode_params(args : dict, with_exception : bool = False):
        if not "state" in args.keys() or not args["state"]:
            if with_exception:
                raise PageParameterParsingError
            else:
                return {}
        return decode_dict(args["state"])


    def __init__(self, args : dict = None):
        if not args is None:
            self.parse(args)


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

        if "op" in args.keys():
            self.op = PageOperation.fromStr(args["op"], self.with_exception)

        if "design" in args.keys():
            self.design = PageDesign.fromStr(args["design"])

        if "language" in args.keys():
            self.language = PageLanguage.fromStr(args["language"], self.with_exception)

        if "user_id" in args.keys():
            self.user_id = PageUserID(args["user_id"])

        if ("q_id" in args.keys()) and (not args["q_id"] is None) and (not args["q_id"]):
            self.q_id = args["q_id"]
            #self.q_id = self.get_all_questions(language)[0]
        else:
            self.q_id = ""

        if ("l_id" in args.keys()) and (not args["l_id"] is None) and (not args["l_id"]):
            self.l_id = args["l_id"]
            #self.l_id = self.get_all_lists(language)[0]
        else:
            self.l_id = ""
            
        if "user_id" in args.keys():
            self.language = PageUserID(args["user_id"])

        if "user_agent" in args.keys():
            self.user_param.user_agent = args["user_agent"]

        if "user_language" in args.keys():
            self.user_param.user_language = args["user_language"]




    def add_code(self, init_code : str = "", iter_code : str = "", text : str = ""):
        self.init_code = init_code
        self.iter_code = iter_code
        self.text = text
