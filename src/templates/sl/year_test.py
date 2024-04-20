import jinja2


page = {}
page['title'] = 'Shkola'
page['item_path'] = '../src/'

page['google_signin_client_id'] = ""
page['google_site_verification'] = ""


page['button'] = {
    'width' : '137px',
    'height' : '140px',
    'font_size' : '111px',
    'margin' : '10px',
    'choices' : []
}

page['button']['choices'].append({
    'title' : '1',
    'obj_type' : 'A',
    'front_color' : '#ff6956',
    'back_color' : '#f9f9f9',
    'link' : 'href="1"'
})

page['button']['choices'].append({
    'title' : '2',
    'obj_type' : 'A',
    'front_color' : '#489cba',
    'back_color' : '#f9f9f9',
    'link' : 'href="2"'
})

page['button']['choices'].append({
    'title' : '3',
    'obj_type' : 'A',
    'front_color' : '#ff6956',
    'back_color' : '#f9f9f9',
    'link' : 'href="1"'
})

page['button']['choices'].append({
    'title' : '4',
    'obj_type' : 'A',
    'front_color' : '#489cba',
    'back_color' : '#f9f9f9',
    'link' : 'href="2"'
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



file_loader = jinja2.FileSystemLoader("..")
env = jinja2.Environment(loader=file_loader)

template = env.get_template("rs/year.html.j2")
print(template.render(template_params=page))






