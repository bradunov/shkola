
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

dif_style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};
				
line_style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

dig_style = {["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

text_style = {["font_size"] = "14"}		

edge = {"s", "a", "P", "V"} 
meas = {"cm", "cm²", "cm³"}  

numb = 4 + math.random(10)	

area_o = 1.5 * numb^2
area = 0.5 * (math.sqrt(3) + 3) * numb^2
vol =  numb^3 / 6

rel_p = 4
rel_v = 6
area = lib.math.round_dec(area, 1)	
vol = lib.math.round_dec(vol,1)
   
mycanvas = function(no)

  lib.start_canvas(280, 130, "center")

	w = 80
	ow = 8
	v = 56
	ov =  104

    lib.add_straight_path(ov-2*ow, 2*ow, {{w, w}, {-4*ow, -v}, {-v+ow, -3*ow}}, dif_style,  true, false) 
   lib.add_straight_path(ov-2*ow, 2*ow, {{v-ow, 3*ow}, {4*ow, v},{0, -w}, {-w,0}}, dig_style,  true, false) 

    lib.add_rectangle (v, v-2*ow, w, w, style, true, false)
    lib.add_straight_path(v, v-2*ow, {{4*ow, -3*ow}, {w, 0}, {-4*ow, 3*ow}, {-w, 0}}, style,  false, false)
    lib.add_straight_path(w+v, v-2*ow, {{4*ow, -3*ow}, {0, w}, {-4*ow, 3*ow}, {0, -w}}, style,  false, false)
    lib.add_rectangle (ov-2*ow, 2*ow, w, w, line_style, true, false)
    lib.add_straight_path(v, ov+2*ow, {{4*ow, -3*ow}}, line_style,  false, false) 
 
     lib.add_text(2*v, v-ow, "a", text_style, false, false) 
     lib.add_text(2*w+2*ow, v+ow, "s", text_style, false, false)  

  lib.end_canvas()
end
      
      