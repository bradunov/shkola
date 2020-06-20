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


def render_stats_data(pg, u_ID):
    #pg = page.Page()
    stats_for_user=stats.Stats.render_user_stats(pg, u_ID) #get stats from render_user_stats
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

        stats_per_subtask[subtheme_key.lower().capitalize()] = single_stat


    return stats_per_subtask



    # subtop_count=len(chart_data)

    # #initiate lists required for chart
    # dif1_pct = []
    # dif1_cnt = []
    # dif2_pct = []
    # dif2_cnt = []
    # dif12_pct = []
    # dif3_pct = []
    # dif3_cnt = []
    # dif123_pct = []
    # rest_pct = []
    # rest_count=[]


    # #assign values to lists for chart
    # for i in range(subtop_count):
    #     dif1_tmp=subtop_cor_dif[i][0]/subtop_total[i]*100
    #     dif1_pct.append(dif1_tmp)
    #     dif1_cnt.append(subtop_cor_dif[i][0])
    #     dif2_tmp=subtop_cor_dif[i][1]/subtop_total[i]*100
    #     dif2_pct.append(dif2_tmp)
    #     dif2_cnt.append(subtop_cor_dif[i][1])
    #     dif12_pct.append(dif1_tmp+dif2_tmp)
    #     dif3_tmp=subtop_cor_dif[i][2]/subtop_total[i]*100
    #     dif3_pct.append(dif3_tmp)
    #     dif3_cnt.append(subtop_cor_dif[i][2])
    #     dif123_pct.append(dif1_tmp+dif2_tmp+dif3_tmp)
    #     rest_count.append(subtop_total[i]-(subtop_cor_dif[i][0]+subtop_cor_dif[i][1]+subtop_cor_dif[i][2]))
    #     rest_pct.append(100-(subtop_total[i]-rest_count[i])/subtop_total[i]*100)


    # print("\n\nChart data: {}\n\n".format(json.dumps(chart_data, indent=2)))
    # print("\n\ndif1_pct:{} dif2_pct:{} dif3_pct:{} rest_pct:{}\n".format(
    #     dif1_pct, dif2_pct, dif3_pct, rest_pct
    # ))
    # print("\n\ndif1_pct:{} dif2_pct:{} dif3_pct:{} rest_pct:{}\n".format(
    #     dif1_cnt, dif2_cnt, dif3_cnt, rest_count
    # ))

    # print(subtop_task)

    # print(json.dumps(stats_per_subtask, indent=2))

    # # format font
    # plt.rcParams.update({'font.size': 10})
    # plt.rcParams.update({'font.family': 'sans-serif'})

    # fig, ax = plt.subplots()  # separate plt into fig (the "drawing" of the chart) and ax (the parameters)

    # chart_length = 60*subtop_count/80 #60 pixels for each subtopic, dividied by 80 for the size in inches
    # chart_width = 290/80

    # fig.set_size_inches(chart_width, chart_length)  # set chart size

    # index = np.arange(subtop_count)  # the locations for the groups
    # width = 0.4  # the width of the bars

    # bar1star = ax.barh(index, dif1_pct, width, color='#f7b500')  # correct with one star
    # bar2star = ax.barh(index, dif2_pct, width, left=dif1_pct, color='#6ab288')  # correct with two stars
    # bar3star = ax.barh(index, dif3_pct, width, left=dif12_pct, color='#489cba')  # correct with three stars
    # bar_rest = ax.barh(index, rest_pct, width, left=dif123_pct, color='#bec5c5')  # the rest of tasks

    # # remove axis
    # ax.xaxis.set_visible(False)
    # ax.yaxis.set_visible(False)

    # #invert y axis
    # plt.gca().invert_yaxis()

    # # remove frame
    # for spine in plt.gca().spines.values():
    #     spine.set_visible(False)

    # # show labels
    # for i in range(subtop_count):
    #     #plt.text(0, i - 0.3, subtop_name[i]+' ('+str(subtop_total[i])+' zadatak/a)', fontname='Lato')
    #     plt.text(0, i - 0.3, subtop_name[i], size=12, fontname='Lato')
    #     #plt.text(100, i - 0.3, ' (' + str(subtop_total[i]) + ' ' + subtop_task[i] + ')', fontname='Lato', size=9, horizontalalignment='right')
    #     plt.text(100, i - 0.3, pg.get_messages()['tasks'] + ' - ' + str(subtop_total[i]), fontname='Lato', size=9, horizontalalignment='right')
    #     if dif1_pct[i] > 0: plt.text(dif1_pct[i]/2, i + 0.1, str(dif1_cnt[i]), color = 'white',  fontname='Lato')
    #     if dif2_pct[i] > 0: plt.text(dif1_pct[i] + dif2_pct[i] / 2, i + 0.1, str(dif2_cnt[i]), color = 'white', fontname='Lato')
    #     if dif3_pct[i] > 0: plt.text(dif12_pct[i] + dif3_pct[i] / 2, i + 0.1, str(dif3_cnt[i]), color = 'white',  fontname='Lato')
    #     if rest_count[i] > 0: plt.text(dif123_pct[i] + rest_pct[i] / 2, i + 0.1, str(rest_count[i]), color = 'white',  fontname='Lato')

    # #fig.savefig('..\images'+'\chart_'+ theme_name + '.png')
    # plt.tight_layout() #tight margins
    # fig.savefig('tmp_chart.png')
    # with open('tmp_chart.png', 'rb') as imageFile:
    #     base64_code=pybase64.b64encode(imageFile.read())
    # os.remove('tmp_chart.png')
    # return base64_code




def prepare_user_stats_chart(pg, u_ID):

    user_stats=render_stats_data(pg, u_ID)

    pg.template_params["template_name"] = "stats.html.j2"

    #pg.template_params["class_gen_str"] = pg.get_messages()['messages']['class']
    pg.template_params["class_gen_str"] = 'Razred'

    pg.template_params["stats"] = {}


    for level_key, level_val in user_stats['level'].items():
        level_short=level_val['level_short']
        pg.template_params["stats"][level_key] = {}
        pg.template_params["stats"][level_key]['level_short'] = level_short
        for theme_key, theme_val in level_val['theme'].items():
            pg.template_params["stats"][level_key][theme_key] = draw_chart(theme_val['subtheme'], pg)

    pg.template_params["url_year"] = pg.page_params.create_url(op=PageOperation.toStr(PageOperation.MENU_YEAR), \
                                    year = "", \
                                    theme = "", \
                                    subtheme = "", \
                                    difficulty = "", \
                                    period = "", \
                                    js=False)

    pg.template_params["url_theme"] = pg.page_params.create_url(op=PageOperation.toStr(PageOperation.MENU_THEME), \
                                    year=pg.page_params.get_param("year"), \
                                    theme = "", \
                                    subtheme = "", \
                                    difficulty = "", \
                                    period = "", \
                                    js=False)


    #print(json.dumps(pg.template_params["stats"], indent=2))

    return


    # star = '&#9733'  # star_symbol
    # clr = []
    # clr.append('#dc3d39')  # red
    # clr.append('#489cba')  # blue
    # clr.append('#f3b051')  # yellow
    # clr.append('#8f53cb')  # violet
    # clr.append('#6ab288')  # green
    # clr.append('#ec8e43')  # orange
    # clr.append('#df367c')  # pink
    # clr.append('#636661')  # medium grey
    # clr.append('#b0b6b6')  # light grey

    # red=0
    # blue=1
    # yellow=2
    # green=4
    # medium_grey=7
    # light_grey=8

    # user_stats=render_stats_data(pg, u_ID)

    # #pg.add_lines('<style>#container{width:360px;}</style>')  # canvas width

    # pg.add_lines('<style> * .column{float:left; width:50%} .row:after{content: ""; display:table; clear:both} </style>') #prepare columns for the stars

    # for level_key, level_val in user_stats['level'].items():

    #     for theme_key, theme_val in level_val['theme'].items():

    #         # add class in the page
    #         class_gen_str = pg.get_messages()['class']
    #         class_str = '<span style = "color:' + clr[red] + '" >' + level_key + '</span> <span style = "color:' + clr[medium_grey] + '" >' + class_gen_str + '</span>'

    #         #'<span style = "color:' + clr[red] + '" >' + level_key + '</span> <span style = "color:' + clr[medium_grey] + '" >' + class_gen_str + '</span>'

    #         pg.add_lines('<div class="row" style="width:360px">')
    #         pg.add_lines('<div class="column" align="left" style="display:content; font-family:\'Lato\'; font-weight:550; font-size: 18px; margin-top:4px;">')#
    #         pg.add_lines('<div style="margin-left:20px">')
    #         pg.add_lines(class_str+'<br>')
    #         #pg.add_lines("</div>")

    #         #add theme in the page
    #         theme_str=''
    #         c=0
    #         for ch in theme_key:
    #             theme_str=theme_str+'<span style = "color:'+clr[c]+'" >' + ch + '</span>'
    #             c+=1
    #             if c==6: c=0
    #         #pg.add_lines('<div id="container" align="left" style="display:content; font-family:\'Bubblegum Sans\'; font-weight:400; font-size: 18px; margin-top:4px">')
    #         pg.add_lines(theme_str)
    #         pg.add_lines('</div>')
    #         pg.add_lines('</div>')

    #         #add stars in the page
    #         pg.add_lines('<div class="column" align="right" style="display:content; margin-top:4px;">')  # ; position: absolute; z-index:-5 \">")
    #         pg.add_lines('<div style="margin-right:25px; align="right"; font-size:18px">')
    #         stars_str=  '<table  border-collapse=collapse cellpadding=0 cellspacing=0> <tr><td><span style = "color:'+clr[yellow]+'" >' + star +               '</span></td></tr>' \
	#                                                                  '<tr><td><span style = "color:'+clr[green] +'" >' + star + star +        '</span></td></tr>' \
	#                                                                  '<tr><td><span style = "color:'+clr[blue]  +'" >' + star + star + star + '</span></td></tr></table>'

    #         pg.add_lines(stars_str)
    #         pg.add_lines('</div>')
    #         pg.add_lines('</div>')
    #         pg.add_lines('</div>')

    #         ####################### THIS WORKS - CHART ONLY ##################################
    #         base64_str=draw_chart(theme_val['subtheme'], pg) #create chart and save base64 string
    #         base64_str=base64_str.decode("utf-8") #convert from byte to string

    #         #add chart in the page
    #         pg.add_lines('<img src=data:image/png;base64,'+ base64_str + ' alt="File Missing"> </div>')

if __name__ == '__main__':

    pg = page.Page(template_path="..")
    #pg = page.Page()
    prepare_user_stats_chart(pg, 'Petar')
    print(pg.render())

