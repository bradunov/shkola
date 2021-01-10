import sys
sys.path.append("..")

import server.storage
import logging
import json
# import pprint

from server.helpers import Transliterate
from server.types import PageLanguage


class Stats(object):

    # Takes the list of detailed results in format:
    # q_res0=false,q_res1=false,q_res2=true,q_res3=false,
    # and produces an array of 0s and 1s:
    # [0, 0, 1, 0]
    @staticmethod
    def _parse_questions_old(q):
        return list(map(lambda x : (1 if x.split("=")[1] == "true" else 0), q.split(",")[:-1]))


    # Takes the list of detailed results in format:
    # "{'q_res0': 'false', 'q_res1': 'false', 'q_res2': 'false', 'q_res3': 'false'}"
    # and produces an array of 0s and 1s:
    # [0, 0, 1, 0]
    @staticmethod
    def _parse_questions(q):
        try:
            q = q.replace("\'", "\"")
            js = json.loads(q)
            res = []
            for k in sorted(js.keys()):
                res.append(1 if js[k] == 'true' else 0)
        except:
            # TBD: this is the old format used in the SQL sample for testing - remove when done
            res = Stats._parse_questions_old(q)
        return res


    @staticmethod
    def calc_question_stats(l_id=None, q_id=None, from_date=None):
        storage = server.storage.get_storage()
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
            "questions" : stats["q_correct"] / stats["q_total"] if stats["q_total"] > 0 else 0,
            "subquestions" : stats["sq_correct"] / stats["sq_total"] if stats["sq_total"] > 0 else 0
        }




    # Query the results table for a user and create aggregate statistics.
    # 
    # Input:
    # - from_date: only include responses after <from_date>
    # 
    # Output: 
    # - <stats>: aggregated stats
    # - <stats_time>: time of the last update
    #
    # The <stats> is a JSON with aggregate results across years, themes, etc.
    # The deepest leaf is this:
    # - stats["level"][<year>]["theme"][<theme>]["subtheme"][<subtheme>]["difficulty"][<difficulty>]
    # Each intermediate step has a leaf ["all"] with aggregate results. 
    # 
    # Each leaf contains the following outputs:
    # - "total": Total number of question pages (e.g. numbers/q00001 is one question) 
    # - "subtotal": Total number of subquestions/inputs (one page can have multiple inputs)
    # - "questions": Fraction of questions that are correctly answered in its entirety
    # - "subquestions": Fractions of subquestions/inputs that are correctly answered 
    @staticmethod
    def calc_user_stats(page, u_id, from_date=None):
        storage = server.storage.get_storage()
        results = storage.get_all_user_results(u_id=u_id, from_date=from_date)
        lang = page.page_params.get_param("language")
        stats_time = None

        # Classify in categories
        stats = { 
            "all" : { "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0 },
            "level" : {},
            "difficulty" : {}
        }

        for r in results:
            q_id = r["question_id"]
            l_id = r["list_id"]

            if not stats_time or r["Timestamp"] > stats_time:
                stats_time = r["Timestamp"]

            if l_id not in page.repository.lists.keys():
                logging.warning("List {} from result ({}) not in the list of lists!".format(l_id, r))
                continue

            q_info = None
            for q in page.repository.lists[l_id]["questions"]:
                if q["name"] == q_id:
                    q_info = q
                    break
            
            if q_info == None:
                logging.warning("Question {} from result ({}) not in list {}!".format(q_id, r, l_id))
                continue

            level = page.repository.lists[l_id]["level"]
            level_short=page.repository.lists[l_id]["level_short"]
            theme = page.repository.lists[l_id]["theme"]
            subthemes = q_info["subtheme"]

            # subthemes can be an array or a singleton, so always convert to an array
            if type(subthemes) == str:
                subthemes = [subthemes]


            # Special provisioing for Serbian cyrillic
            # NOTE: result years, themes and subthemes are taken from l_id, which also stores language
            # So if a user answers a question in 1_numbers.uk, the results theme will be shown in English
            # regardless of page language as each list is bespoke for each language and it is not possible to "translate". 
            # Transliteration however works as it is the same language/list.
            if lang == PageLanguage.RSC:
                level = Transliterate.rs(level)
                level_short = Transliterate.rs(level_short)
                theme = Transliterate.rs(theme)
                subthemes = [Transliterate.rs(s) for s in subthemes]

            #period = q_info["period"]
            difficulty = q_info["difficulty"]


            parsed_q = Stats._parse_questions(r["questions"])
            correct = sum(parsed_q) 
            total = len(parsed_q)

            if not level in stats["level"].keys():
                stats["level"][level] = {
                    "all" : { "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0 },
                    "level_short" : level_short,
                    "theme" : {},
                    "difficulty" : {}
                }

            if not theme in stats["level"][level]["theme"].keys():
                stats["level"][level]["theme"][theme] = {
                    "all" : { "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0 },
                    "subtheme" : {},
                    "difficulty" : {}
                }

            for subtheme in subthemes: 
                if not subtheme in stats["level"][level]["theme"][theme]["subtheme"].keys():
                    stats["level"][level]["theme"][theme]["subtheme"][subtheme] = {
                        "all" : {"q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0}, 
                        "difficulty" : {}
                    }

            if not difficulty in stats["difficulty"].keys():
                stats["difficulty"][difficulty] = {
                    "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0
                }
            
            if not difficulty in stats["level"][level]["difficulty"].keys():
                stats["level"][level]["difficulty"][difficulty] = {
                    "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0
                }

            if not difficulty in stats["level"][level]["theme"][theme]["difficulty"].keys():
                stats["level"][level]["theme"][theme]["difficulty"][difficulty] = {
                    "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0
                }

            for subtheme in subthemes: 
                if not difficulty in stats["level"][level]["theme"][theme]["subtheme"][subtheme]["difficulty"].keys():
                    stats["level"][level]["theme"][theme]["subtheme"][subtheme]["difficulty"][difficulty] = {
                        "q_correct" : 0, "q_total" : 0, "sq_correct" : 0, "sq_total" : 0
                    }

            Stats._update_stats(stats["all"], correct, total)
            Stats._update_stats(stats["difficulty"][difficulty], correct, total)
            Stats._update_stats(stats["level"][level]["all"], correct, total)
            Stats._update_stats(stats["level"][level]["difficulty"][difficulty], correct, total)
            Stats._update_stats(stats["level"][level]["theme"][theme]["all"], correct, total)
            Stats._update_stats(stats["level"][level]["theme"][theme]["difficulty"][difficulty], correct, total)
            for subtheme in subthemes: 
                Stats._update_stats(stats["level"][level]["theme"][theme]["subtheme"][subtheme]["all"], correct, total)
                Stats._update_stats(stats["level"][level]["theme"][theme]["subtheme"][subtheme]["difficulty"][difficulty], correct, total)


        # print("AAAAAAAAAAAAAAAAA\n")
        # print(json.dumps(stats, indent=2))


        # Calculate and update aggregate stats
        stats["all"] = Stats._calculate_stats(stats["all"])
        for difficulty,v in stats["difficulty"].items():
            stats["difficulty"][difficulty] = Stats._calculate_stats(v)

        for level,u in stats["level"].items():
            stats["level"][level]["all"] = Stats._calculate_stats(u["all"])
            for difficulty,v1 in stats["level"][level]["difficulty"].items():
                stats["level"][level]["difficulty"][difficulty] = Stats._calculate_stats(v1)

            for theme,v in stats["level"][level]["theme"].items():
                stats["level"][level]["theme"][theme]["all"] = Stats._calculate_stats(v["all"])
                for difficulty,v1 in stats["level"][level]["theme"][theme]["difficulty"].items():
                    stats["level"][level]["theme"][theme]["difficulty"][difficulty] = Stats._calculate_stats(v1)

                for subtheme,v1 in stats["level"][level]["theme"][theme]["subtheme"].items():
                    stats["level"][level]["theme"][theme]["subtheme"][subtheme]["all"] = Stats._calculate_stats(v1["all"])
                    for difficulty,v2 in stats["level"][level]["theme"][theme]["subtheme"][subtheme]["difficulty"].items():
                        stats["level"][level]["theme"][theme]["subtheme"][subtheme]["difficulty"][difficulty] = Stats._calculate_stats(v2)


        # print("BBBBBBBBBBBBBBBBBB\n")
        # print(json.dumps(stats, indent=2))

        return stats, stats_time




    @staticmethod
    def update_user_stats(page, user_id, from_date=None):
        stats, stats_time = Stats.calc_user_stats(page, user_id, from_date)
        page.app_data.storage.update_user_stats(user_id, stats, stats_time)




if __name__ == '__main__':
    from server.page import Page
    from server.app_data import AppData

    use_azure_blob = False
    preload = True
    rel_path = "../.."

    print("Loading questions...")
    app_data = AppData(use_azure_blob=use_azure_blob, preload=preload, rel_path=rel_path)
    page = Page(app_data)
    print("Loaded questions.")
    res, _ = Stats.calc_user_stats(page, "google:100168932003331800480")
    print("\n\n\n")
    print(json.dumps(res, indent=2))

    Stats.update_user_stats(page, "google:100168932003331800480")

