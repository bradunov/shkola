from server.storage import get_storage
#from server.page import Page


class Stats(object):

    @staticmethod
    def render_question_stats(page, l_id=None, q_id=None, timestamp=None):
        storage = get_storage()
        results = storage.get_question_stats(from_date="2020-03-15T00:00:00.000Z")

        stats = {}
        for r in results:
            q_id = r["question_id"]
            u_id = r["user_id"]
            if len(u_id) >= len("local:") and u_id[:len("local:")] == "local:":
                u_id = u_id[len("local:"):]
            folder = q_id.split("/")[0]
            subq = list(map(lambda x : (1 if x.split("=")[1] == "true" else 0), r["questions"].split(",")[:-1]))

            if not folder in stats.keys():
                stats[folder] = {}
            if not q_id in stats[folder].keys():
                stats[folder][q_id] = {}
            if not u_id in stats[folder][q_id].keys():
                stats[folder][q_id][u_id] = subq
            else:
                for i in range(0, len(subq)):
                    stats[folder][q_id][u_id][i] = 1 if (stats[folder][q_id][u_id][i] + subq[i] > 0) else 0

        summary = {}
        for folder in stats.keys():
            summary[folder] = {"content" : [], "width" : 0}

            for q_id in stats[folder]:
                correct = []
                total = 0
                for u_id in stats[folder][q_id]:
                    if sum(stats[folder][q_id][u_id]) > 0:
                        # Answered at least one
                        total = total + 1
                        if len(correct) == 0:
                            correct = stats[folder][q_id][u_id]
                        else:
                            for i in range(0, len(correct)):
                                correct[i] = correct[i] + stats[folder][q_id][u_id][i]


                if total > 0:
                    summary[folder]["content"].append({
                        "q_id" : q_id, 
                        "total" : total,
                        "correct" : correct
                    })
                    summary[folder]["width"] = len(correct) if len(correct) > summary[folder]["width"] else summary[folder]["width"]


        return summary