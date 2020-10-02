
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = 
	{["off_color"] = "fff",
        ["on_color"] = "faf",
        ["line_color"] = "000",
        ["line_width"] = "1"};


text_style = {["font_size"] = "16"}

number = {}

term = math.random(9) - 1
add = math.random(2)

if (term > 4) then
add = 1
end


number[1] = term 
for i = 1, 8 do
    number[i+1] = (term + i*add)  
end	

first = tostring(math.floor(number[1]))
midl = tostring(math.floor(number[2]))
midr = tostring(math.floor(number[6]))
last = tostring(math.floor(number[9]))

mycanvas = function(no)
  lib.start_canvas(350, 150, "center")

hscale = 1.5
vscale = 5

  lib.add_straight_path(10*hscale, 15*vscale, {{220*hscale, 0}}, style, false, true)
  
  lib.add_straight_path(15*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(13*hscale, 19*vscale, first, text_style) 

  lib.add_straight_path(40*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(40*hscale, 19*vscale, midl, text_style)

  lib.add_straight_path(65*hscale, 14*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(50*hscale, 17*vscale, 50, 33, lib.check_number(number[3],15))

  lib.add_straight_path(90*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(75*hscale, 17*vscale, 50, 33, lib.check_number(number[4],15))  

  lib.add_straight_path(115*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(100*hscale, 17*vscale, 50, 33, lib.check_number(number[5],15))

  lib.add_straight_path(140*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(140*hscale, 19*vscale, midr, text_style)

  lib.add_straight_path(165*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(150*hscale, 17*vscale, 50, 33, lib.check_number(number[7],15))  

  lib.add_straight_path(190*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(175*hscale, 17*vscale, 50, 33, lib.check_number(number[8],15))
  
  lib.add_straight_path(215*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(215*hscale, 19*vscale, last, text_style)  
 
  lib.end_canvas()
end                
                    
      
            