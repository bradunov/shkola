import jinja2


page = {}
page['title'] = 'Shkola'
page['item_path'] = 'item?url='

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""

page['year'] = "1"

page['themes'] = []

page['themes'].append({
    'title' : 'BROJEVI',
    'subthemes' : [
      {
        'title' : 'Brojanje',
        'topics' : [
          {
            'title' : 'Tema 1',
            'link' : 'b1'
          },
          {
            'title' : 'Tema 2',
            'link' : 'b2'
          }
        ]
      },
      {
        'title' : 'Operacije',
        'topics' : [
          {
            'title' : 'Tema 1',
            'link' : 'o1'
          },
          {
            'title' : 'Tema 2',
            'link' : 'o2'
          }
        ]
      },
      {
        'title' : 'Merenje nestandardnim jedinicama mere',
        'topics' : [
          {
            'title' : 'Tema 1',
            'link' : 'p1'
          },
          {
            'title' : 'Tema 2',
            'link' : 'p2'
          }
        ]
      }
    ]
})


page['themes'].append({
    'title' : 'GEOMETRIJA',
    'subthemes' : [
      {
        'title' : 'Brojanje2',
        'topics' : [
          {
            'title' : 'Tema 21',
            'link' : 'b21'
          },
          {
            'title' : 'Tema 22',
            'link' : 'b22'
          }
        ]
      },
      {
        'title' : 'Operacije2',
        'topics' : [
          {
            'title' : 'Tema 21',
            'link' : 'o21'
          },
          {
            'title' : 'Tema 22',
            'link' : 'o22'
          }
        ]
      },
      {
        'title' : 'Poredjenje2',
        'topics' : [
          {
            'title' : 'Tema 21',
            'link' : 'p21'
          },
          {
            'title' : 'Tema 22',
            'link' : 'p22'
          }
        ]
      }
    ]
})



page['themes'].append({
    'title' : 'MERE',
    'subthemes' : [
      {
        'title' : 'Brojanje2',
        'topics' : [
          {
            'title' : 'Tema 21',
            'link' : 'b21'
          },
          {
            'title' : 'Tema 22',
            'link' : 'b22'
          }
        ]
      },
      {
        'title' : 'Operacije2',
        'topics' : [
          {
            'title' : 'Tema 21',
            'link' : 'o21'
          },
          {
            'title' : 'Tema 22',
            'link' : 'o22'
          }
        ]
      },
      {
        'title' : 'Poredjenje2',
        'topics' : [
          {
            'title' : 'Tema 21',
            'link' : 'p21'
          },
          {
            'title' : 'Tema 22',
            'link' : 'p22'
          }
        ]
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






