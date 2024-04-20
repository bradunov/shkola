import jinja2


page = {}
page['title'] = 'Shkola'
page['item_path'] = '../src/'

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""
page["guest_link"] = ""

page['current_lang'] = "lang"
page['menu_lang'] = []
page['menu_lang'].append({"name" : "test1", "link": "link1"})
page['menu_lang'].append({"name" : "test2", "link": "link2"})


file_loader = jinja2.FileSystemLoader("..")
env = jinja2.Environment(loader=file_loader)

template = env.get_template("rs/user.html.j2")
print(template.render(template_params=page))






