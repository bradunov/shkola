import jinja2


page = {}
page['title'] = 'Shkola'
page['item_path'] = '../src/'

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""

page['exit'] = "EXIT"

page["debug_checkall"] = True

page["user_picture"] = "https://lh5.googleusercontent.com/-3VJ2UlD0Y3U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucnCsCk0v-JmKlQX7QXTrFI--Y_WXA/s96-c/photo.jpg"
page["user_name"] = "Pera Peric"

page["q_number"] = "QN"
page["stats"] = {
  '1': {'correct': 1, 'incorrect': 0}, 
  '2': {'correct': 2, 'incorrect': 1},
  '3': {'correct': 1, 'incorrect': 1}
}


page["total_bar"] = {"star1": 0, "star2": 0, "star3": 0, "missed": 0}
for k, v in page["stats"].items():
  if k == "1":
    page["total_bar"]["star1"] = page["total_bar"]["star1"] + v["correct"]
    page["total_bar"]["missed"] = page["total_bar"]["missed"] + v["incorrect"]
  elif k == "2":
    page["total_bar"]["star2"] = page["total_bar"]["star2"] + v["correct"]
    page["total_bar"]["missed"] = page["total_bar"]["missed"] + v["incorrect"]
  elif k == "3":
    page["total_bar"]["star3"] = page["total_bar"]["star3"] + v["correct"]
    page["total_bar"]["missed"] = page["total_bar"]["missed"] + v["incorrect"]


page["root"] = "ROOT"
page["q_id"] = "QQQQ"
page["l_id"] = "LLLL"

page["year"] = "PRVI"
page["theme"] = "BROJEVI"
page["subtheme"] = "Operacije"
page["difficulty"] = 1

page["next"] = "NEXT"
page["skip"] = "SKIP"
page["back"] = "PREV"

page["question"] = "TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>" \
                   "TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>" \
                   "TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>TEXT<br>"




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



file_loader = jinja2.FileSystemLoader("..")
env = jinja2.Environment(loader=file_loader)

template = env.get_template("rs/test.html.j2")
print(template.render(template_params=page))






