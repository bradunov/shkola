
include("terms")

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "3"};

dif_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "606",
        ["line_width"] = "1"};

red_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f30",
        ["line_width"] = "2"};

blue_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "0cf",
        ["line_width"] = "2"};
		
green_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "3c3",
        ["line_width"] = "2"};		
				
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};	

text_style = {["font_size"] = "16"}

ind = math.random(4)

mycanvas = function()
	 		  
  lib.start_canvas(330, 200, "center")   
  
   v = 20
   if (ind < 4) then
      ow = 80
      w = 40
	  bound = 4
      ch = ind 
      lib.add_straight_path (ow+2, v, {{w, w}, {0, 2*w}, {w, 0}, {0, -w}}, red_style, false, false)
      lib.add_curved_path (ow+2*w+2, v+2*w, {{2*w, 0, 2*w, 2*w}}, red_style, false, false)
      lib.add_curved_path (ow+2*w, v+2*w, {{0, 2*w, -2*w, 2*w}}, blue_style, false, false)
      lib.add_straight_path (ow+4*w, v, {{-w, w}, {-2*w, 0}, {0, w}, {w, 0}}, blue_style, false, false)
      lib.add_curved_path (ow+2*w-2, v+2*w, {{0, -2*w, 2*w, -2*w}}, green_style, false, false)
      lib.add_straight_path (ow-2, v+4*w, {{w, -w}, {2*w, 0}, {0, -w},{-w, 0}}, green_style, false, false)		  
   else
      ow = 5
      w = 40
	  bound =  8
	  ch = math.random(3)
	  if (ch == 1) then
          first_style = red_style
		  second_style = blue_style
		  third_style = green_style
	  end 
	  if (ch == 2) then
		  first_style =  blue_style 
		  second_style = green_style 
		  third_style =  red_style
	  end
	  if (ch == 3) then	  
		  first_style =  green_style 
		  second_style = red_style 
		  third_style =  blue_style
	  end

      lib.add_straight_path (ow+4*w+2, v, {{w, w}, {0, 2*w}, {w, 0}, {0, -w}}, first_style, false, false)
      lib.add_curved_path (ow+6*w+2, v+2*w, {{2*w, 0, 2*w, 2*w}}, first_style, false, false)
	  
      lib.add_curved_path (ow+4*w, v+4*w, {{0, -2*w,  2*w, -2*w}}, second_style, false, false)
      lib.add_straight_path (ow+6*w, v+2*w, {{0, w}, {w, 0}, {0, -2*w}, {w, -w}}, second_style, false, false)

      lib.add_curved_path (ow+6*w-2, v+2*w, {{2*w, 0, 2*w, -2*w}}, third_style, false, false)
      lib.add_straight_path (ow+4*w-2, v+4*w, {{w, -w}, {0, -2*w}, {w, 0},{0, w}}, third_style, false, false)	
	  
   end	  

--[[black]]-- 
    lib.add_curved_path (ow, v+4*w, {{0, -2*w,  2*w, -2*w}}, style, false, false)
    lib.add_straight_path (ow+2*w, v+2*w, {{0, w}, {w, 0}, {0, -2*w}, {w, -w}}, style, false, false)
 
	if (ind == 1) then
	 lib.add_line(ow+2*w, 5, 0, ow+4*w, dif_style, false, false)
	   lib.add_text(ow+2*w, v-10, "Q", text_style, false, false)
	   lib.add_text(ow+2*w, v+4*w+10, "P", text_style, false, false)
	end
	if (ind == 2) then
	 lib.add_line(ow, v+4*w, 4*w, -4*w, dif_style, false, false)
	   lib.add_text(ow+4*w+5, v-10, "Q", text_style, false, false)
	   lib.add_text(ow-5, v+4*w+10, "P", text_style, false, false)
	end   
	if (ind == 3) then
	 lib.add_line(ow, v, 4*w, 4*w, dif_style, false, false)
	   lib.add_text(ow+4*w+5, v+4*w+10, "P", text_style, false, false)
	   lib.add_text(ow-5, v-10, "Q", text_style, false, false)
	end
	if (ind == 4) then
	 lib.add_line(ow+4*w, v+4*w, 0, -ow-4*w, dif_style, false, false)
	   lib.add_text(ow+4*w, v+4*w+10, "P", text_style, false, false)
	   lib.add_text(ow+4*w, v-10, "Q", text_style, false, false)
	end

	for i = 1,5 do
	lib.add_line(ow, v+(i-1)*w, bound*w, 0, grid_style, false, false)
	end
	for i = 1,bound + 1 do
	lib.add_line(ow+(i-1)*w, v, 0, 4*w, grid_style, false, false)
	end

  lib.end_canvas()
end           
        