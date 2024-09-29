
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "2"};

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};	
							
text_style = {["font_size"] = "16"}

meas =  {"cm", "cm²"}

dim = 30 + math.random(10)
dim2 = math.floor(dim/2)
numb1 = 5 + math.random(dim2 -6)
numb2 = numb1 + math.random(dim -numb1 + 1)
area = 0.5 * ((numb1 + numb2)*dim - numb1 * numb2)
area = lib.math.round_dec(area, 1)	

mycanvas = function()
	 		  
  lib.start_canvas(190, 200, "center")   
  
	w = 10
	ow = 5
	v = 20

	lib.add_rectangle (v+ow, v+w, 14*w, 14*w, style, false, false) 
	lib.add_straight_path(v+ow, v+10*w, {{6*w,-9*w}, {8*w,14*w}, {-14*w, -5*w,} }, dif_style, true, false)  
	lib.add_text(v+6*w, v+8*w, "P", text_style, false, false)
	lib.add_text(v-w, v+5*w, tostring(numb2), text_style, false, false)
	lib.add_text(v+3*w, v-ow, tostring(numb1), text_style, false, false)
	lib.add_text(v+16*w, v+8*w, tostring(dim), text_style, false, false)
	lib.add_text(v+8*w, v+16*w, tostring(dim), text_style, false, false)

--[[    
  for i = 1,15 do
    lib.add_line(v, v+i*w, 14*w, 0, grid_style, false, false)
  end
  for i = 1,15 do
    lib.add_line(v+(i-1)*w, v+w, 0, 14*w, grid_style, false, false)
  end  
]]--

  lib.end_canvas()
end       