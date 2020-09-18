
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

text_style = {["font_size"] = "14"}

number = {}

term = (math.random(10) - 1) * 1000
add = math.random(9) * 1000


number[1] = term 
for i = 1, 9 do
    number[i+1] = (term + i*add)  
end	

first = tostring(math.floor(number[1]))
midl = tostring(math.floor(number[3]))
midr = tostring(math.floor(number[7]))
last = tostring(math.floor(number[10]))


mycanvas = function(no)
  lib.start_canvas(480, 150, "center")

hscale = 1.3
vscale = 5

  lib.add_straight_path(15*hscale, 15*vscale, {{245*hscale, 0}}, style, false, true)
  
  lib.add_straight_path(20*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(18*hscale, 11*vscale, first, text_style) 

  lib.add_straight_path(45*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(25*hscale, 17*vscale, 50, 33, lib.check_number(number[2],35))  
  
  lib.add_straight_path(70*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(68*hscale, 11*vscale, midl, text_style)

  lib.add_straight_path(95*hscale, 14*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(68*hscale, 17*vscale, 50, 33, lib.check_number(number[4],35))

  lib.add_straight_path(120*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(100*hscale, 17*vscale, 50, 33, lib.check_number(number[5],35))  

  lib.add_straight_path(145*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(135*hscale, 17*vscale, 50, 33, lib.check_number(number[6],35))

  lib.add_straight_path(170*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(170*hscale, 11*vscale, midr, text_style)  

  lib.add_straight_path(195*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(175*hscale, 17*vscale, 50, 33, lib.check_number(number[8],35))

  lib.add_straight_path(220*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(210*hscale, 17*vscale, 50, 33, lib.check_number(number[9],35))

  lib.add_straight_path(245*hscale, 14*vscale, {{0, 10}}, style, false, true) 
  lib.add_text(245*hscale, 11*vscale, last, text_style)
 
  lib.end_canvas()
end 
   