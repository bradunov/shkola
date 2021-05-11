# import numpy as np
# #import matplotlib
# import matplotlib.pyplot as plt
# import pybase64

import sys
sys.path.append("..")

from server import stats

if __name__ == '__main__':
    from server import page

from server.types import PageOperation
from server.types import PageLanguage
from server.repository import Repository
import server.context as context
import json


# For anonymous users, we use anon_stats dictionary in the context block to track stats
# during a session and display it in the stats menu, since we don't store it in the table 
def add_anon_stats(page, anon_stats, q_id, language, year, theme, subtheme, difficulty, correct, incorrect):

    if difficulty == "*":
        q_info = page.repository.get_content_question_detail(language, year, theme, subtheme, q_id)
        if not q_info or "difficulty" not in q_info.keys():
            difficulty = "1"
        else:
            difficulty = q_info["difficulty"]

    if 'level' not in anon_stats.keys():
        anon_stats['level'] = {}
    if year not in anon_stats['level'].keys():
        anon_stats['level'][year] = {'theme':{}, 'level_short':year}
    if theme not in anon_stats['level'][year]['theme'].keys():
        anon_stats['level'][year]['theme'][theme] = {'subtheme':{}}
    if subtheme not in anon_stats['level'][year]['theme'][theme]['subtheme'].keys():
        anon_stats['level'][year]['theme'][theme]['subtheme'][subtheme] = {'difficulty':{}}
    if difficulty not in anon_stats['level'][year]['theme'][theme]['subtheme'][subtheme]['difficulty'].keys():
        anon_stats['level'][year]['theme'][theme]['subtheme'][subtheme]['difficulty'][difficulty] = \
            {
                "correct": 0, "total": 0
            }
    total = correct + incorrect + anon_stats['level'][year]['theme'][theme]['subtheme'][subtheme]['difficulty'][difficulty]["total"]
    correct += anon_stats['level'][year]['theme'][theme]['subtheme'][subtheme]['difficulty'][difficulty]["correct"] * \
        anon_stats['level'][year]['theme'][theme]['subtheme'][subtheme]['difficulty'][difficulty]["total"]
    anon_stats['level'][year]['theme'][theme]['subtheme'][subtheme]['difficulty'][difficulty]["correct"] = correct / total
    anon_stats['level'][year]['theme'][theme]['subtheme'][subtheme]['difficulty'][difficulty]["total"] = total

    #print(json.dumps(anon_stats, indent=2))
    

def render_stats_data(pg, u_ID):
    #pg = page.Page()
    stats_for_user, _ = stats.Stats.calc_user_stats(pg, u_ID) #get stats from calc_user_stats
    #create values of user_stats dictionary
    user_stats={'level':{}}
    for level_key, level_val in stats_for_user['level'].items():
        user_stats['level'][level_key]={'theme':{}}
        user_stats['level'][level_key]['level_short']=stats_for_user['level'][level_key]['level_short']
        for theme_key, theme_val in level_val['theme'].items():
            user_stats['level'][level_key]['theme'][theme_key]={'subtheme':{}}
            for subtheme_key, subtheme_val in theme_val['subtheme'].items():
                user_stats['level'][level_key]['theme'][theme_key]['subtheme'][subtheme_key] = {'difficulty': {}}
                for difficulty_key, difficulty_val in subtheme_val['difficulty'].items():
                     user_stats['level'][level_key]['theme'][theme_key]['subtheme'][subtheme_key]['difficulty'][difficulty_key] = {
                         'correct':difficulty_val['questions'], 'total':difficulty_val['total']}
#                         'correct':difficulty_val['correct'], 'total':difficulty_val['total']}
    return user_stats

def draw_chart(chart_data, pg):
    #initiate lists
    subtop_name=[]
    subtop_total=[]
    subtop_cor_dif=[]
    # subtop_task=[]

    stats_per_subtask = {}

    #get data from chart_data into lists
    for subtheme_key, subtheme_val in chart_data.items():
        subtop_name.append(subtheme_key)
        st_tmp=0
        st_cor_tmp=[0, 0, 0]


        #for difficulty_key, difficulty_val in subtheme_val['difficulty'].items():
        #    st_tmp+= difficulty_val['total']
        #    curr_st=len(subtop_cor_dif)-1
        #    subtop_cor_dif[curr_st][int(difficulty_key)-1]=difficulty_val['correct']
        #subtop_total.append(st_tmp)


        for difficulty_key, difficulty_val in subtheme_val['difficulty'].items():
            st_tmp+= difficulty_val['total']
            # curr_st=len(subtop_cor_dif)-1
            st_cor_tmp[int(difficulty_key)-1] = round(difficulty_val['correct'] *  difficulty_val['total'])
        subtop_cor_dif.append(st_cor_tmp)
        subtop_total.append(st_tmp)

        #assing value of task in Serbian depending on the case
        subtop_task_tmp = pg.get_messages()['tasks'] #'zadataka'
        #st_tmp_mod=st_tmp % 10
        #if (st_tmp<= 4 or st_tmp >= 20):
        #    if st_tmp_mod == 1:
        #        subtop_task_tmp = 'zadatak'
        #    elif (st_tmp_mod >= 2 and  st_tmp_mod <= 4):
        #        subtop_task_tmp = 'zadatka'
        #subtop_task.append(subtop_task_tmp)
        subtop_task_tmp+=":"

        single_stat = {
            "diff1" : st_cor_tmp[0],
            "diff2" : st_cor_tmp[1],
            "diff3" : st_cor_tmp[2],
            "total" : st_tmp, 
            "wrong" : st_tmp - st_cor_tmp[0] - st_cor_tmp[1] - st_cor_tmp[2],
            "message" : subtop_task_tmp
        }

        print("SSS: ", single_stat)

        stats_per_subtask[subtheme_key.lower().capitalize()] = single_stat


    return stats_per_subtask






def prepare_user_stats_chart(pg, u_ID):

    if (u_ID == "UNKNOWN" or u_ID == "local:UNKNOWN"):
        user_stats = context.c.session.get("anon_stats")
    else:
        user_stats = render_stats_data(pg, u_ID)

    pg.template_params["template_name"] = pg.page_params.get_param("language").value + "/" + "stats.html.j2"

    pg.template_params["class_gen_str"] = pg.get_messages()["year"]
    #pg.template_params["class_gen_str"] = 'Razred'

    pg.template_params["stats"] = {}

    if user_stats:
        sorted_levels = list(user_stats['level'].keys())
        sorted_levels.sort()
    else:
        sorted_levels = []

    #for level_key, level_val in user_stats['level'].items():
    for level_key in sorted_levels:
        level_val = user_stats['level'][level_key]
        level_short=level_val['level_short']
        pg.template_params["stats"][level_key] = {}
        pg.template_params["stats"][level_key]['level_short'] = level_short
        for theme_key, theme_val in level_val['theme'].items():
            pg.template_params["stats"][level_key][theme_key] = draw_chart(theme_val['subtheme'], pg)

    pg.template_params["url_year"] = pg.page_params.create_url(
                                    op=PageOperation.MENU_YEAR, \
                                    language = PageLanguage.toStr(pg.page_params.get_param("language")), 
                                    year = "", \
                                    theme = "", \
                                    subtheme = "", \
                                    topic = "", \
                                    difficulty = "", \
                                    period = "", \
                                    beta = True if pg.page_params.get_param("beta") else None)

    pg.template_params["url_theme"] = pg.page_params.create_url(
                                    op=PageOperation.MENU_THEME, \
                                    language = PageLanguage.toStr(pg.page_params.get_param("language")), 
                                    year=pg.page_params.get_param("year"), \
                                    theme = "", \
                                    subtheme = "", \
                                    topic = "", \
                                    difficulty = "", \
                                    period = "", \
                                    beta = True if pg.page_params.get_param("beta") else None)


    #print(json.dumps(pg.template_params["stats"], indent=2))

    return



if __name__ == '__main__':

    pg = page.Page(template_path="..")
    #pg = page.Page()
    prepare_user_stats_chart(pg, 'Petar')
    print(pg.render())

