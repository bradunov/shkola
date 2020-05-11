
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

orange_style = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "f90",
        ["line_width"] = "2"};

orange1_style = 
	{["off_color"] = "f90e",
        ["on_color"] = "f90",
        ["line_color"] = "f90",
        ["line_width"] = "1"};

green_style = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "6f6",
        ["line_width"] = "2"};
		
green1_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "6f6",
        ["line_width"] = "1"};		

brown_style = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "c90",
        ["line_width"] = "2"};
		
brown1_style = 
	{["off_color"] = "c90",
        ["on_color"] = "c90",
        ["line_color"] = "c90",
        ["line_width"] = "1"};		

text_style = {["font_size"] = "14"}

number = {}

term = math.random(9)
add = math.random(5)
deg = 1 + math.random(2)

number[1] = term * 100
for i = 1, 10 do
    number[i+1] = (term + i*add) * 100 
end	

first = tostring(math.floor(number[1]))
middle = tostring(math.floor(number[8]))
last = tostring(math.floor(number[11]))

value1 = number[1]
value2 = number[5] - number[1]
value3 = number[11] - number[5]
value4 = number[11] - number[3]

result = number[3]

mycanvas = function(no)
  lib.start_canvas(500, 150, "center")

hscale = 1.5
vscale = 5

  lib.add_straight_path(15*hscale, 15*vscale, {{270*hscale, 0}}, style, false, true)
  
  lib.add_straight_path(20*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(10*hscale, 18*vscale, first, text_style) 

  lib.add_straight_path(45*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(22*hscale, 20*vscale, 50, 33, lib.check_number(number[2],30))  
  
  lib.add_straight_path(70*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(50*hscale, 20*vscale, 50, 33, lib.check_number(number[3],30))  

  lib.add_straight_path(95*hscale, 14*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(78*hscale, 20*vscale, 50, 33, lib.check_number(number[4],30))

  lib.add_straight_path(120*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(105*hscale, 20*vscale, 50, 33, lib.check_number(number[5],30))  

  lib.add_straight_path(145*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(133*hscale, 20*vscale, 50, 33, lib.check_number(number[6],30))

  lib.add_straight_path(170*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(160*hscale, 20*vscale, 50, 33, lib.check_number(number[7],30))

  lib.add_straight_path(195*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_text(195*hscale, 18*vscale, middle, text_style)

  lib.add_straight_path(220*hscale, 14*vscale, {{0, 10}}, style, false, true)
  lib.add_input(205*hscale, 20*vscale, 50, 33, lib.check_number(number[9],30))

  lib.add_straight_path(245*hscale, 14*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(233*hscale, 20*vscale, 50, 33, lib.check_number(number[10],30))

  lib.add_straight_path(270*hscale, 14*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(275*hscale, 18*vscale, last, text_style)

  lib.add_curved_path (20*hscale, 14*vscale, {{50, -50, 100*hscale, 0}}, orange_style, false, false) 
  lib.add_curved_path (120*hscale, 14*vscale, {{50, -50, 152*hscale, 0}}, green_style, false, false) 
  lib.add_curved_path (70*hscale, 14*vscale, {{100, -100, 202*hscale, 0}}, brown_style, false, false)   
    
  lib.add_straight_path (120*hscale, 14*vscale, {{-7, 0}, {3, -6}, {7, 6}, {-7, 0}, {3, -3}}, orange1_style, true, false)
  lib.add_straight_path (272*hscale, 14*vscale, {{-7, 0}, {3, -6}, {7, 6}, {-7, 0}, {3, -3}}, green1_style, true, false)
  lib.add_straight_path (70*hscale, 14*vscale, {{7, 0}, {-6, -3}, {-3, 7}, {7, -3}}, brown1_style, true, false)

  lib.end_canvas()
end
                               
                   