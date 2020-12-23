import jinja2


page = {}
page['title'] = 'Shkola'
page['item_path'] = 'item?url='

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""

page["total_bar"] = {}
page["total_bar"]["star1"] = 2
page["total_bar"]["star2"] = 2
page["total_bar"]["star3"] = 2
page["total_bar"]["missed"] = 2

page["type_bar"] = {}
page["type_bar"]["star1"] = 2
page["type_bar"]["star2"] = 2
page["type_bar"]["star3"] = 2
page["type_bar"]["missed"] = 2


file_loader = jinja2.FileSystemLoader("..")
env = jinja2.Environment(loader=file_loader)

template = env.get_template("rsc/summary.html.j2")
print(template.render(template_params=page))






