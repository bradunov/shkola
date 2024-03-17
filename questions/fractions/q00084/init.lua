
include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};

color_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "f90",
        ["line_width"] = "0.2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

ind = {}
out = {}
for i = 1,8 do
    ind[i] = i
end
out = lib.math.random_shuffle(ind)
ch = math.random(7)

area = lib.math.round_dec(ch/8, 3)

mycanvas = function(no)

  lib.start_canvas(200, 200, "center")

     w = 180
     ov = 90
     ow = 10

     for j = 1,ch do     
         if (out[j] == 1) then
  	    lib.add_straight_path (ow, ow, {{ov, 0}, {-ov, ov}, {0, -ov}}, color_style,  true, false)
         end
     end
     for j = 1,ch do     
         if (out[j] == 2) then
 	     lib.add_straight_path (ow+ov, ow, {{0, ov}, {-ov, 0}, {ov, -ov}}, color_style, true, false)
         end
     end 
     for j = 1,ch do     
         if (out[j] == 3) then
	    lib.add_straight_path (ow+ov, ow, {{0, ov}, {ov, 0}, {-ov, -ov}}, color_style, true, false)
         end
     end
     for j = 1,ch do     
         if (out[j] == 4) then
  	    lib.add_straight_path (ow+ov, ow, {{ov, 0}, {0, ov}, {-ov, -ov}}, color_style, true, false)
         end
     end
     for j = 1,ch do     
         if (out[j] == 5) then
 	    lib.add_straight_path (ow, ow+ov, {{0, ov}, {ov, 0}, {-ov, -ov}}, color_style, true, false)
         end
     end
     for j = 1,ch do     
         if (out[j] == 6) then
 	    lib.add_straight_path (ow, ow+ov, {{ov, 0}, {0, ov}, {-ov, -ov}}, color_style,true, false)
         end
     end
     for j = 1,ch do     
         if (out[j] == 7) then
	    lib.add_straight_path (ow+ov, ow+ov, {{ov, 0}, {-ov, ov}, {0, -ov}}, color_style, true, false)
         end
     end
     for j = 1,ch do     
         if (out[j] == 8) then
  	    lib.add_straight_path (ow+w, ow+ov, {{0, ov}, {-ov, 0}, {ov, -ov}}, color_style, true, false)
         end
     end

     lib.add_rectangle (ow, ow, w, w, style, true, false)
     lib.add_straight_path (ow+ov, ow, {{ov, ov}, {-ov, ov}, {-ov, -ov}, {ov, -ov}}, style, true, false)
     lib.add_line(ow+ov, ow, 0, w, dif_style, false, false)
     lib.add_line(ow, ow+ov, w, 0, dif_style, false, false)

  lib.end_canvas()
end   
             