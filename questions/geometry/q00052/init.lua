
include("terms")

style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
		
text_style = {["font_size"] = "16"}		


teme = {"A", "B", "C"}
duz = {"AB", "BC", "CA"}
triang = "ABC"

ind = math.random(3)

mycanvas = function(no)

  ow = 16
  w = 4
  v = 80
  ov = 120

  if (ind == 1) then
     x = -v+2*ow
     y = ov-3*ow/2
     z = x
  end 
  if (ind == 2) then
     x = -(v+ow)*0.6
     y = 1.2*(v+ow)
     z = x
  end 
  if (ind == 3) then
     x = -v-ow
     y = ov+v/2+w
     z = -v+ow-w
  end   

  lib.start_canvas(240, 190, "center")
  
  lib.add_straight_path (ov, 2*ow, {{x, v+ow}, {y, 0}, {z, -v-ow}}, style, true, false)
  lib.add_text(ov+x, v+ov/2, teme[1], text_style, false, false) 
  lib.add_text(ov+x+y, v+ov/2, teme[2], text_style, false, false) 
  lib.add_text(ov, ow+w, teme[3], text_style, false, false)    
  lib.add_input(ov-v, 2*v-w, 150, 30, lib.check_one_option_dropdown(name, name[ind]))
  
  lib.end_canvas()
end       
   