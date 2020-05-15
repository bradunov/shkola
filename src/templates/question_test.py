import jinja2


page = {}
page['title'] = 'Shkola'

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""



page["q_number"] = "QN"
page["stats"] = {
  '1': {'correct': 1, 'incorrect': 0}, 
  '2': {'correct': 2, 'incorrect': 1},
  '3': {'correct': 1, 'incorrect': 1}
}


page["bar"] = {"star1": 0, "star2": 0, "star3": 0, "missed": 0}
for k, v in page["stats"].items():
  if k == "1":
    page["bar"]["star1"] = page["bar"]["star1"] + v["correct"]
    page["bar"]["missed"] = page["bar"]["missed"] + v["incorrect"]
  elif k == "2":
    page["bar"]["star2"] = page["bar"]["star2"] + v["correct"]
    page["bar"]["missed"] = page["bar"]["missed"] + v["incorrect"]
  elif k == "3":
    page["bar"]["star3"] = page["bar"]["star3"] + v["correct"]
    page["bar"]["missed"] = page["bar"]["missed"] + v["incorrect"]


page["root"] = "ROOT"
page["q_id"] = "QQQQ"
page["l_id"] = "LLLL"

page["year"] = "PRVI"
page["theme"] = "BROJEVI"
page["subtheme"] = "Operacije"
page["difficulty"] = 1

page["next"] = "NEXT"
page["back"] = "PREV"

page["question"] = "TEXT"




page['menu'] = [
    {
        'name' : 'Zadaci',
        'submenu' : {
            'id' : 'zadaci',
            'options' : [
                {
                    'name' : 'Cetvrti',
                    'link' : 'C',
                    'submenu' : {
                        'id' : 'cetvrti',
                        'options' : [
                            { 'name' : 'Brojevi', 'link' : '1'},
                            { 'name' : 'Geometrija', 'link' : '2'},
                            { 'name' : 'Razlomci', 'link' : '3'}
                        ]
                    }
                },
                {
                    'name' : 'Treci',
                    'link' : 'T',
                    'submenu' : {
                        'id' : 'treci',
                        'options' : [
                            { 'name' : 'Brojevi', 'link' : '1'},
                            { 'name' : 'Geometrija', 'link' : '2'},
                            { 'name' : 'Razlomci', 'link' : '3'}
                        ]
                    }
                }
            ]
        }
    },
    {
        'name' : 'Rezultati',
        'link' : 'R'
    }
]



file_loader = jinja2.FileSystemLoader("../templates")
env = jinja2.Environment(loader=file_loader)

template = env.get_template("question.html.j2")
print(template.render(template_params=page))






