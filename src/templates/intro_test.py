import jinja2


page = {}
page['title'] = 'Shkola'

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""






file_loader = jinja2.FileSystemLoader("../templates")
env = jinja2.Environment(loader=file_loader)

template = env.get_template("intro.html.j2")
print(template.render(template_params=page))





