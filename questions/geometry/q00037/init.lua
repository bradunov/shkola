include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

yelow_style = {["off_color"] = "fff",
               ["on_color"] = "ff0",
               ["line_color"] = "000",
               ["line_width"] = "1"};

red_style = {["off_color"] = "fff",
                ["on_color"] = "f30",
                ["line_color"] = "000",
                ["line_width"] = "1"};

blue_style = {["off_color"] = "fff",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "1"};
			   
text_style = {["font_size"] = "16"}

 

number = 4

ind = math.random(3)

w = 10
ow = 20
ov = 250
  
 	
mycanvas = function(result)

  lib.start_canvas(320, 270, "center", result)

  lib.add_straight_path(ow, 5*ow, {{ov+2*ow, 0}}, style,  false, false)
  lib.add_straight_path(5*ow, ow, {{0, ov+ow}}, style,  false, false)
  lib.add_straight_path(2*ow, ov+ow, {{ov, -ov+ow}}, style,  false, false)

 --[[  markeri  ]]--
  lib.add_circle(4*ow+w, 4*ow+w, 7, red_style, false, true) 
  lib.add_circle(4*ow+w, 6*ow-w, 7, red_style, false, true) 
  lib.add_circle(6*ow-w, 4*ow+w, 7, red_style, false, true) 
  lib.add_circle(6*ow-w, 6*ow-w, 7, red_style, false, true) 

  lib.add_circle(13*ow-w, 4*ow+w, 7, yelow_style, false, true) 
  lib.add_circle(10*ow, 6*ow-w, 7, yelow_style, false, true) 
  lib.add_circle(6*ow-w, 10*ow-w, 7, yelow_style, false, true) 
  lib.add_circle(4*ow+w, 12*ow, 7, yelow_style, false, true) 

  lib.add_circle(11*ow, 4*ow+w, 7, blue_style, false, true) 
  lib.add_circle(12*ow-w, 6*ow-w, 7, blue_style, false, true) 
  lib.add_circle(6*ow-w, 11*ow, 7, blue_style, false, true) 
  lib.add_circle(4*ow+w, 10*ow+w, 7, blue_style, false, true) 
 
  lib.end_canvas()
end    

if (ind == 1) then
   result = "result[0] == 1 && result[1] == 1 && result[2] == 1 && result[3] == 1 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 0"
end

if (ind == 2) then
   result = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 1 && result[5] == 1 && result[6] == 1 && result[7] == 1 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 0"
end  

if (ind == 3) then
   result = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 1 && result[9] == 1 && result[10] == 1 && result[11] == 1"
end      
       
            
    