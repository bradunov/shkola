import jinja2


page = {}
page['title'] = 'Shkola'

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""

page['year'] = "PRVI"

page['themes'] = []

page['themes'].append({
    'title' : 'BROJEVI',
    'subthemes' : [
      {
        'title' : 'Brojanje',
        'link' : 'b'
      },
      {
        'title' : 'Operacije',
        'link' : 'o'
      },
      {
        'title' : 'Poredjenje',
        'link' : 'p'
      }
    ]
})


page['themes'].append({
    'title' : 'GEOMETRIJA',
    'subthemes' : [
      {
        'title' : 'Brojanje',
        'link' : 'b'
      },
      {
        'title' : 'Operacije',
        'link' : 'o'
      },
      {
        'title' : 'Poredjenje',
        'link' : 'p'
      }
    ]
})


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

template = env.get_template("theme.html.j2")
print(template.render(template_params=page))






