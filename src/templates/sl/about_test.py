import jinja2


page = {}
page['title'] = 'Shkola'
page['item_path'] = '../src/'

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""



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

page["item_path"] = "file:///C:/Users/bozidar/Documents/Code/shkola/src/"

file_loader = jinja2.FileSystemLoader("..")
env = jinja2.Environment(loader=file_loader)

template = env.get_template("rs/about.html.j2")
print(template.render(template_params=page))






