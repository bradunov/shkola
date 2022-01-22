
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"};
style_dif = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "3"};		

red_line = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f00",
        ["line_width"] = "1"};


text_style = {["font_size"] = "14"}

tempA = -10 + math.random(5)
tempB = tempA + 2 + math.random(5)
tempH = tempB + 3 + math.random(4)

if (tempB == 0) then
    tempB = tempB - 1
end	

first = tempA - 1
last = tempH + 1
part = last - first

tempAmB = tempB - tempA
tempBmH = tempH - tempB
tempAmH = tempH - tempA

difA = 2 + math.random(4)
tempAr = tempA + difA
difH = 2 + math.random(3)
tempHf = tempH - difH

mycanvas = function(no)
  lib.start_canvas(350, 60, "center")

  hscale = math.floor(300/part)
  vscale = 3
  ow = 10
  v = 5

  lib.add_straight_path(ow, 9*vscale, {{270*hscale - ow, 0}}, style, false, true)
  
  for i = 1,part + 1 do  
      lib.add_straight_path(ow+i*hscale, 8*vscale, {{0, 10}}, style, false, true)
  end
  
  lib.add_text(ow + hscale, 15*vscale, first, text_style)
  lib.add_text(ow + (1+math.abs(first))*hscale, 15*vscale, "0", text_style)  
  lib.add_straight_path(ow + (1+math.abs(first))*hscale+2, 8*vscale, {{0, 10}}, style_dif, false, true) 
   lib.add_text(ow + (part + 1)*hscale, 15*vscale, last, text_style)  
  
  lib.add_text(ow+2*hscale, 2*vscale, "A", text_style)
  lib.add_straight_path(ow+2*hscale-2, 7*vscale-4, {{2, 6}, {2,-6}}, red_line, false, true)
  lib.add_straight_path(ow+2*hscale, 4*vscale, {{0, 15}}, red_line, false, true)
    
  lib.add_text(ow + (tempAmB+2)*hscale, 2*vscale, "B", text_style)
  lib.add_straight_path(ow + (tempAmB+2)*hscale - 2, 7*vscale-4, {{2, 6}, {2,-6}}, red_line, false, true)
  lib.add_straight_path(ow + (tempAmB+2)*hscale, 4*vscale, {{0, 15}}, red_line, false, true)

 lib.add_text(ow + (tempAmH+2)*hscale, 2*vscale, "H", text_style)
  lib.add_straight_path(ow + (tempAmH+2)*hscale - 2, 7*vscale-4, {{2, 6}, {2,-6}}, red_line, false, true)
  lib.add_straight_path(ow + (tempAmH+2)*hscale, 4*vscale, {{0, 15}}, red_line, false, true)
  
  lib.end_canvas()
end