
include("terms")

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};	
colour_style = 
	{["off_color"] = "fff",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "2"};			
		
text_style = {["font_size"] = "16"}		

ind = math.random(8)	

mycanvas = function()

  if (ind == 1) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 1 && result[5] == 0 && result[6] == 0 && result[7] == 1 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 1"
  end	
  if (ind == 2) then
      results = "result[0] == 1 && result[1] == 0 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 1 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 1 && result[11] == 0"
  end
  if (ind == 3) then
      results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 1 && result[7] == 0 && result[8] == 1 && result[9] == 1 && result[10] == 0 && result[11] == 0"
  end
  if (ind == 4) then
      results = "result[0] == 1 && result[1] == 1 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 1 && result[7] == 1 && result[8] == 1 && result[9] == 1 && result[10] == 0 && result[11] == 0"
  end
  if (ind == 5) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 1 && result[5] == 1 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 1 && result[11] == 0"
  end 
  if (ind == 6) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 1"
  end   
  if (ind == 7) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 1 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 0"
  end    
  if (ind == 8) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 1 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 1 && result[11] == 0"
  end 
  
  
  lib.start_canvas(350, 250, "center", results)  
  
  w = 20
  ow = 10

  v = 3*math.sqrt(3)

  lib.add_straight_path (2*w, 3*w, {{3*w, 0}, {-3*w, 4*w},  {0, -4*w}}, colour_style, false, true)       --[[COP; 2,4]]--
  lib.add_straight_path (2*w, 10*w, {{7*w, -w}, {2*w, w+3},  {-9*w, -2}}, colour_style, false, true)     --[[QTS; 3,4]]--
  lib.add_straight_path (15*w, 3*w, {{0, 7*w+3}, {-4*w, 0},  {4*w, -7*w-2}}, colour_style, false, true)  --[[ERS; 2,4]]--
  lib.add_straight_path (9*w, 3*w, {{3*w, v*w+2}, {-3*w, (6-v)*w}, {0, -6*w}}, colour_style, false, true)  --[[BMT; 1,5,7]]--
  lib.add_straight_path (5*w, 7*w, {{2*w, -2*w}, {2*w, 4*w}, {-4*w, -2*w}}, colour_style, false, true)   --[[AJT; 1,5,7]]--
  lib.add_straight_path (5*w, 3*w, {{4*w, 0}, {-2*w, 2*w}, {-2*w, -2*w}}, colour_style, false, true)     --[[OBJ; 2,5,8]]--
  lib.add_straight_path (7*w, 5*w, {{2*w, -2*w}, {0, 6*w}, {-2*w, -4*w}}, colour_style, false, true)     --[[JBT; 3,4]]--  
  lib.add_straight_path (5*w, 3*w, {{2*w, 2*w}, {-5*w, 2*w}, {3*w, -4*w}}, colour_style, false, true)    --[[OJP; 1,4]]--
  lib.add_straight_path (2*w, 7*w, {{5*w, -2*w}, {-5*w, 5*w},  {0, -3*w}}, colour_style, false, true)    --[[PJQ; 3,4]]--
  lib.add_straight_path (5*w, 7*w, {{4*w, 2*w}, {-7*w, w}, {3*w, -3*w}}, colour_style, false, true)      --[[ATQ; 3,4]]--
  lib.add_straight_path (9*w, 9*w, {{3*w+2, -w+3}, {-w-2, 2*w}, {-2*w-2, -w-2}}, colour_style, false, true)  --[[TMS; 2,5,8]]--
  lib.add_straight_path (9*w, 3*w, {{6*w, 0}, {-3*w, v*w+2}, {-3*w, -v*w-2}}, colour_style, false, true)     --[[BEM; 1,6]]--

--[[
  lib.add_text(2*w+ow, 2*w+ow, "C", text_style)
  lib.add_text(5*w+ow, 6*w+ow, "A", text_style)
  lib.add_text(9*w+ow, 2*w+ow, "B", text_style)
  lib.add_text(15*w+ow, 2*w+ow, "E", text_style)
  lib.add_text(7*w+ow, 4*w+ow, "J", text_style)
  lib.add_text(12*w+ow, (2+v)*w+ow, "M", text_style)	 
  lib.add_text(5*w+ow, 2*w+ow, "O", text_style)  
  lib.add_text(2*w+ow, 6*w+ow, "P", text_style)	
  lib.add_text(2*w+ow, 9*w+ow, "Q", text_style)
  lib.add_text(15*w+ow, 9*w+ow, "R", text_style)
  lib.add_text(11*w+ow, 9*w+ow, "S", text_style)	  
  lib.add_text(9*w+ow, 8*w+ow, "T", text_style)
]]--
	 
    for i = 1,12 do
    lib.add_line(w, i*w, 15*w, 0, style, false, false)
  end

  for i = 1,16 do
    lib.add_line(i*w, w, 0, 11*w, style, false, false)
  end

	
  lib.end_canvas()
end     
