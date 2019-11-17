import cherrypy
from storage_sql import storage_sql



class Results(object):
    storage = None
    
    def __init__(self):
        self.storage = storage_sql()

    @cherrypy.expose
    def register(self, **args):
        #print("Register: ", args)
        correct = 0
        incorrect = 0
        questions = ""

        
        if "q_id" in args.keys() and "user_id" in args.keys() and "now" in args.keys() and args["user_id"]:
            if "l_id" not in args.keys() or not args["l_id"] or args["l_id"] is None:
                l_id = ""
            else:
                l_id = args["l_id"]
                

            for key, value in args.items():
                if key[0:5] == "q_res":
                    questions = questions + key + "=" + value + ","
                    if value == "true":
                        correct = correct + 1
                    else:
                        incorrect = incorrect + 1
                        
            response = {"user_id" : args["user_id"],
                        "question_id": args["q_id"],
                        "list_id": l_id,
                        "response_type": args["response_type"],
                        "time": args["start"],
                        "duration": int(args["now"]) - int(args["start"]),
                        "correct": correct,
                        "incorrect": incorrect,
                        "questions": questions}

            self.storage.record_response(response)

        
        return "OK"
    

