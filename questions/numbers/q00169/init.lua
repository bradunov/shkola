
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};


text_style = {["font_size"] = "16"}

number = {}

term = math.random(9)
add = math.random(5)


number[1] = term 
for i = 1, 10 do
    number[i+1] = (term + i*add)  
end	

first = tostring(math.floor(number[1]))
midl = tostring(math.floor(number[3]))
midr = tostring(math.floor(number[8]))
last = tostring(math.floor(number[11]))

mycanvas = function(no)
  lib.start_canvas(350, 150, "center")

hscale = 1.2
vscale = 5

  lib.add_straight_path(15*hscale, 15*vscale, {{270*hscale, 0}}, style, false, true)
  
  lib.add_straight_path(20*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(18*hscale, 19*vscale, first, text_style) 

  lib.add_straight_path(45*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(22*hscale, 17*vscale, 50, 33, lib.check_number(number[2],15))  
  
  lib.add_straight_path(70*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(68*hscale, 19*vscale, midl, text_style)

  lib.add_straight_path(95*hscale, 14*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(74*hscale, 17*vscale, 50, 33, lib.check_number(number[4],15))

  lib.add_straight_path(120*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(100*hscale, 17*vscale, 50, 33, lib.check_number(number[5],15))  

  lib.add_straight_path(145*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(126*hscale, 17*vscale, 50, 33, lib.check_number(number[6],15))

  lib.add_straight_path(170*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(150*hscale, 17*vscale, 50, 33, lib.check_number(number[7],15))

  lib.add_straight_path(195*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(195*hscale, 19*vscale, midr, text_style)

  lib.add_straight_path(220*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(200*hscale, 17*vscale, 50, 33, lib.check_number(number[9],15))

  lib.add_straight_path(245*hscale, 14*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(225*hscale, 17*vscale, 50, 33, lib.check_number(number[10],15))

  lib.add_straight_path(270*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(275*hscale, 19*vscale, last, text_style)
 
  lib.end_canvas()
end                
  