style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f90",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

position_up = {"J", "E"}
position_down = {"A", "T"}
position_on = {"O", "M"}
dot = {""}

answ = {" na pravoj i određuju duž.", "sa iste strane prave.", " sa raznih strana prave." }
index = math.random(3)
ind = index - 1

if (index == 1) then
    dot[1] = "O"
	dot[2] = "M"
end	

if (index == 2) then
    sign = math.random(2)
	if (sign == 1) then
        dot[1] = position_up[sign]
	    dot[2] = position_up[3-sign]
	else
        dot[1] = position_down[sign]
	    dot[2] = position_down[3-sign]
	end
end	

if (index == 3) then
    sign = math.random(2)
	if (sign == 1) then
        dot[1] = position_up[sign]
	    dot[2] = position_down[3-sign]
	else
        dot[1] = position_down[sign]
	    dot[2] = position_up[3-sign]
	end
end		
	

mycanvas = function(no)
  lib.start_canvas(300, 150, "center")
  
  lib.add_straight_path(40, 40, {{250, 100}}, style, true, false)

  lib.add_text(112, 58, ".", dot_style, false, false)
  lib.add_text(112, 56, "O", text_style, false, false)
  
  lib.add_text(240, 109, ".", dot_style, false, false)
  lib.add_text(240, 107, "M", text_style, false, false)

  lib.add_text(60, 130, ".", dot_style, false, false)
  lib.add_text(60, 128, "A", text_style, false, false)
  
  lib.add_text(150, 40, ".", dot_style, false, false)
  lib.add_text(150, 38, "J", text_style, false, false)

  lib.add_text(170, 110, ".", dot_style, false, false)
  lib.add_text(170, 108, "T", text_style, false, false)

  lib.add_text(230, 30, ".", dot_style, false, false)
  lib.add_text(230, 28, "E", text_style, false, false)
    
  lib.end_canvas()
end

