from server.storage import get_storage
import logging
#import pprint


class Stats(object):

    # Takes the list of detailed results in format:
    # q_res0=false,q_res1=false,q_res2=true,q_res3=false,
    # and produces an array of 0s and 1s:
    # [0, 0, 1, 0]
    @staticmethod
    def _parse_questions(q):
        return list(map(lambda x : (1 if x.split("=")[1] == "true" else 0), q.split(",")[:-1]))


    @staticmethod
    def render_question_stats(page, l_id=None, q_id=None, from_date=None):
        storage = get_storage()
        if not from_date:
            from_date = "2020-03-15T00:00:00.000Z"
        results = storage.get_question_stats(from_date=from_date)

        stats = {}
        for r in results:
            q_id = r["question_id"]
            u_id = r["user_id"]
            if len(u_id) >= len("local:") and u_id[:len("local:")] == "local:":
                u_id = u_id[len("local:"):]
            folder = q_id.split("/")[0]
            
            #subq = list(map(lambda x : (1 if x.split("=")[1] == "true" else 0), r["questions"].split(",")[:-1]))
            subq = Stats._parse_questions(r["questions"])

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




    @staticmethod
    def _update_stats(stats, correct, total):
        stats["q_correct"] = stats["q_correct"] + (1 if (correct == total) else 0)
        stats["q_total"] = stats["q_total"] + 1
        stats["sq_correct"] = stats["sq_correct"] + correct
        stats["sq_total"] = stats["sq_total"] + total


        

    @staticmethod
    def _calculate_stats(stats):
        return {
            "total" : stats["q_total"],
            "subtotal" : stats["sq_total"],
            "questions" : stats["q_correct"] / stats["q_total"],
            "subquestions" : stats["sq_correct"] / stats["sq_total"]
        }



    @staticmethod
    def render_user_stats(page, u_id, from_date=None):
        storage = get_storage()
        if not from_date:
            from_date = "2020-03-15T00:00:00.000Z"
        results = storage.get_user_stats(u_id=u_id, from_date=from_date)


        # Classify in categories
        stats = { 
            "all" : { "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0 },
            "theme" : {},
            "difficulty" : {}
        }

        for r in results:
            q_id = r["question_id"]
            l_id = r["list_id"]

            if l_id not in page.repository.lists.keys():
                logging.warning("List {} from result ({}) not in the list of lists!".format(l_id, r))
                continue

            theme = page.repository.lists[l_id]["theme"]
            q_info = None
            for q in page.repository.lists[l_id]["questions"]:
                if q["name"] == q_id:
                    q_info = q
                    break
            
            if q_info == None:
                logging.warning("Question {} from result ({}) not in list {}!".format(q_id, r, l_id))
                continue

            subtheme = q_info["subtheme"]
            #period = q_info["period"]
            difficulty = q_info["difficulty"]

            parsed_q = Stats._parse_questions(r["questions"])
            correct = sum(parsed_q) 
            total = len(parsed_q)

            if not theme in stats["theme"].keys():
                stats["theme"][theme] = {
                    "all" : { "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0 },
                    "subtheme" : {},
                    "difficulty" : {}
                }

            if not subtheme in stats["theme"][theme]["subtheme"].keys():
                stats["theme"][theme]["subtheme"][subtheme] = {
                    "all" : {"q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0}, 
                    "difficulty" : {}
                }

            if not difficulty in stats["difficulty"].keys():
                stats["difficulty"][difficulty] = {
                    "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0
                }
            
            if not difficulty in stats["theme"][theme]["difficulty"].keys():
                stats["theme"][theme]["difficulty"][difficulty] = {
                    "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0
                }

            if not difficulty in stats["theme"][theme]["subtheme"][subtheme]["difficulty"].keys():
                stats["theme"][theme]["subtheme"][subtheme]["difficulty"][difficulty] = {
                    "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0
                }

            Stats._update_stats(stats["all"], correct, total)
            Stats._update_stats(stats["difficulty"][difficulty], correct, total)
            Stats._update_stats(stats["theme"][theme]["all"], correct, total)
            Stats._update_stats(stats["theme"][theme]["difficulty"][difficulty], correct, total)
            Stats._update_stats(stats["theme"][theme]["subtheme"][subtheme]["all"], correct, total)
            Stats._update_stats(stats["theme"][theme]["subtheme"][subtheme]["difficulty"][difficulty], correct, total)


        # print("AAAAAAAAAAAAAAAAA\n")
        # pp = pprint.PrettyPrinter(indent=4)
        # pp.pprint(stats)


        # Calculate and update aggregate stats
        stats["all"] = Stats._calculate_stats(stats["all"])
        for difficulty,v in stats["difficulty"].items():
            stats["difficulty"][difficulty] = Stats._calculate_stats(v)

        for theme,v in stats["theme"].items():
            stats["theme"][theme]["all"] = Stats._calculate_stats(v["all"])
            for difficulty,v1 in stats["theme"][theme]["difficulty"].items():
                stats["theme"][theme]["difficulty"][difficulty] = Stats._calculate_stats(v1)

            for subtheme,v1 in stats["theme"][theme]["subtheme"].items():
                stats["theme"][theme]["subtheme"][subtheme]["all"] = Stats._calculate_stats(v1["all"])
                for difficulty,v2 in stats["theme"][theme]["subtheme"][subtheme]["difficulty"].items():
                    stats["theme"][theme]["subtheme"][subtheme]["difficulty"][difficulty] = Stats._calculate_stats(v2)


        # print("BBBBBBBBBBBBBBBBBB\n")
        # pp = pprint.PrettyPrinter(indent=4)
        # pp.pprint(stats)

        return stats