 
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
						
text_style = {["font_size"] = "14"}		

meas = {"\(^\circ\)", "'"}
numb = {"α", "β", "γ"}

name = {"BC", "AC", "AB"}
answ = {"=", ">", "<"}
            
mycanvas = function(no)

  ow = 5
  w = 125
  ov = 75
  v = 20

  lib.start_canvas(200, 100, "center") 
           
    lib.add_straight_path(ow, ov, {{w+v+5*ow, 0}, {-2*v, -ov}, {-w-ow, ov} }, style, true, false)  


    lib.add_text(v-2*ow, ov+2*ow, "A", text_style) 
    lib.add_text(w+10*ow, ov+2*ow, "B", text_style)
    lib.add_text(w+5*ow, ow, "C", text_style) 
	
    lib.add_text(7*ow, ov-2*ow, numb[1], text_style) 
    lib.add_text(w+6*ow, ov-2*ow, numb[2], text_style) 
    lib.add_text(w+ow, 2*ow, numb[3], text_style)	
     
  lib.end_canvas()
end   