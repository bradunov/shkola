
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};


text_style = {["font_size"] = "16"}

number = {}

term = math.random(9) * 10
add = math.random(9) * 10


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
  lib.add_text(18*hscale, 11*vscale, first, text_style) 

  lib.add_straight_path(45*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(25*hscale, 17*vscale, 50, 33, lib.check_number(number[2],25))  
  
  lib.add_straight_path(70*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(68*hscale, 11*vscale, midl, text_style)

  lib.add_straight_path(95*hscale, 14*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(68*hscale, 17*vscale, 50, 33, lib.check_number(number[4],25))

  lib.add_straight_path(120*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(98*hscale, 17*vscale, 50, 33, lib.check_number(number[5],25))  

  lib.add_straight_path(145*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(126*hscale, 17*vscale, 50, 33, lib.check_number(number[6],25))

  lib.add_straight_path(170*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(155*hscale, 17*vscale, 50, 33, lib.check_number(number[7],25))

  lib.add_straight_path(195*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(195*hscale, 11*vscale, midr, text_style)

  lib.add_straight_path(220*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(197*hscale, 17*vscale, 50, 33, lib.check_number(number[9],25))

  lib.add_straight_path(245*hscale, 14*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(227*hscale, 17*vscale, 50, 33, lib.check_number(number[10],25))

  lib.add_straight_path(270*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(275*hscale, 11*vscale, last, text_style)
 
  lib.end_canvas()
end                
   
   
   