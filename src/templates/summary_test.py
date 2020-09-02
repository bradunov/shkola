import jinja2


page = {}
page['title'] = 'Shkola'

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""

page["bar"] = {}
page["bar"]["star1"] = 2
page["bar"]["star2"] = 2
page["bar"]["star3"] = 2
page["bar"]["missed"] = 2



file_loader = jinja2.FileSystemLoader("../templates")
env = jinja2.Environment(loader=file_loader)

template = env.get_template("summary.html.j2")
print(template.render(template_params=page))






