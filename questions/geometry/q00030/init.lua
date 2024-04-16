
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "16"}		

test = {t_str, t_str, t_str, t_str}

ow = 16
w = 200
ov = 144

min = 2 * ow
max = ov - 4 * ow

y = min + math.random(max - min)

gdw = 80
gup = -120

if (y < 71) then 
   g = gdw
   cor = ow
   test[4] = n_str
else   
   g = gup
   cor = 0
   test[2] = n_str
   test[3] = n_str
end   

mycanvas = function(no)
  lib.start_canvas(240, 160, "center")
  
  lib.add_straight_path(ow, ow, {{w, gdw}}, style, true, false)
  lib.add_straight_path(ow, y, {{w, g}}, style, true, false)  
  lib.add_straight_path(ow, ov, {{w, gup}}, style, true, false)  

  lib.add_text(2*ow, 2*ow, "f", text_style, false, false)  
  lib.add_text(2*ow, ov, "g", text_style, false, false)
  lib.add_text(2*ow, y+cor, "h", text_style, false, false)
  
  lib.end_canvas()
end
   