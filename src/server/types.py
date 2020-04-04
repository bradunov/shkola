from enum import Enum, unique

@unique
class Operation(Enum):
    SUBMIT = 0
    SKIP = 1
    @classmethod
    def toStr(cls, enum):
        if enum == Operation.SUBMIT:
            return "SUBMIT"
        elif enum == Operation.SKIP:
            return "SKIP"
            
