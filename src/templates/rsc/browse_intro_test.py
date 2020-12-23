import jinja2


page = {}
page['title'] = 'Shkola'
page['item_path'] = 'item?url='

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""

page["back"] = "back"
page["next"] = "next"




file_loader = jinja2.FileSystemLoader("..")
env = jinja2.Environment(loader=file_loader)

template = env.get_template("rsc/browse_intro.html.j2")
print(template.render(template_params=page))






