
blue_style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};		

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}

ang = {"105°", "135°", "150°", "165°"}
resm = {60, 0, 30, 60}
resp = 90
ind = math.random(4)
 if (ind == 1) then
     term1 = "β - α"
     term2 = "β + α"	 
 else
     term1 = "α - β"
     term2 = "α + β"	 
 end

mycanvas = function(no)

  ow = 20
  ov = 200
  v = 100
  
  y = 2*ind * ow
  if (ind == 1) then
      sh = 8
  else
      if (ind == 2) then
          sh = -ow-5
      else
          sh = -ind*ow	  
          if (ind == 4) then
              sh = sh-5
          end
      end
  end
  
  lib.start_canvas(250, 250, "center")

  lib.add_straight_path(v, v+4*ow, {{ 0, -3*ow}, {-4*ow, -2*ow+sh}}, blue_style, true, false) 
 
  lib.add_line(v, ow+v, v, 0, style, true, false)
  lib.add_line(v, ow, 0, ov, style, false, false)
   lib.add_line(ov, ow+v+y, -ov, -2*y, style, true, false) 

  lib.add_input(v+2*ow, v+ow, 30, 30, "α")   
  lib.add_input(v-ow-5, v-ow,  30, 30, "β")  
  lib.add_input(v-5, v, 30, 30, "⦜") 

  lib.add_input(v/2, v+2*ow, 40, 50, ang[ind])
  lib.add_text(v, v+10, ".", dot_style, false, false)
  lib.add_input(v-ow-5, v+15, 30, 30, "O")
 		
  lib.end_canvas()
end     	        
      