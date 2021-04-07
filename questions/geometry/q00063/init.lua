
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

text_style = {["font_size"] = "16"}
symb = "\(\small\angle\)"  

sign = {" "}

name = {"aOb", "cOd", "bOc", "aOc", "bOd", "aOd"}
meas = {1, 1, 2, 3, 3, 4}

index = {1,2,3,4,5,6}
ind = lib.math.random_shuffle(index)

for i = 1,3 do
    if (meas[ind[i]] == meas[ind[i+3]]) then
        sign[i] = "="
    else	
        if (meas[ind[i]] < meas[ind[i+3]]) then
     	    sign[i] = "<"  
        else
     	    sign[i] = ">" 
        end
    end	
end	

  w = 10 
  ow = 100
  ov = 130
  wy = 100
	
mycanvas = function()

  lib.start_canvas(250, 150, "center")

  lib.add_straight_path(ow, ov, {{wy, 0}}, style,  false, false)
  lib.add_text(ow+wy-w, ov-w, "a", text_style, false, false) 

  lib.add_straight_path(ow, ov, {{wy, -wy/2}}, style,  false, false)
  lib.add_text(ow+wy-w, ov-wy/2-w, "b", text_style, false, false) 

  lib.add_straight_path(ow, ov, {{0, -wy}}, style,  false, false)
  lib.add_text(ow-w, ov-wy, "c", text_style, false, false) 

  lib.add_straight_path(ow, ov, {{-wy/2, -wy}}, style,  false, false)
  lib.add_text(ow-wy/2-w, ov-wy, "d", text_style, false, false) 

  lib.add_text(ow, ov+w, "O", text_style, false, false) 
        
  lib.end_canvas()
end    

 
  