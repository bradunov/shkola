
style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "1"};

diff_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
meas = "°"
alpha = "α"
phi = "φ" 
spc = "\(\ \)" 

part = {2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 30, 36}
dim = 17

mycanvas = function()

  lib.start_canvas(150, 110, "center")
  
    w = 48
    ow = 15
    v = 6
 
    lib.add_circle (ow+w, v+w, w, diff_style, false, false ) 
    lib.add_input(w-v, w-2*v, 50, 30, "O")  
 	
    lib.add_input(w-3, w+ow-v-2, 50, 30, phi) 
    lib.add_input(ow-3, w+ow, 50, 30, alpha)	

	lib.add_line(ow, w+2*v, 2*w-v-2, ow+v, style, false, false)
	lib.add_line(ow, w+2*v, w-v-4, w-v, style, false, false)
	lib.add_line(ow+w, v+w, w+v-ow, 2*ow-v+4, style, false, false)				
	lib.add_line(ow+w, v+w, -ow+v, w, style, false, false)
	  

  lib.end_canvas()
  
end      