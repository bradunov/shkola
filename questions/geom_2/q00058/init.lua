
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
line_style = 
	{["line_color"] = "f30",
        ["line_width"] = "2"};		
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};			
colour_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};			
		
text_style = {["font_size"] = "16"}	

trian = "△"
eq =  "≅"

name_1 = {"AOB", "AOC", "AOD", "AOE", "BOC", "BOD", "BOE", "COD", "COE", "DOE"}	
name_2 = {"POQ", "POR", "POS", "POT", "QOR", "QOS", "QOT", "ROS", "ROT", "SOT"}	

ind = math.random(10)
if (ind == 6) then 
    ind = ind - math.random(4)
end	
	
value = name_1[ind]

mycanvas = function()

  if (ind == 1) then
      results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0"  	
  end
  if (ind == 2) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 1"
  end
  if (ind == 3) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 1 && result[7] == 0 && result[8] == 0 && result[9] == 0"  
  end
  if (ind == 4) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0"
  end  
  if (ind == 5) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 1 && result[8] == 0 && result[9] == 0"
  end   
  if (ind == 6) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0"
  end     
  if (ind == 7) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 1 && result[9] == 0"
  end      
  if (ind == 8) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 1 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0"
  end   
  if (ind == 9) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 1"
  end  
  if (ind == 10) then
      results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0"
  end   
  
  lib.start_canvas(350, 350, "center", results)  
  
    w = 20
    ow = 10
    v = 5
   
    if (ind < 5) then
       lib.add_line(ow+2*w, ow+w, 6*w, 4*w, line_style, true, false) 
    else
       lib.add_line(ow+2*w, ow+w, 6*w, 4*w, style, true, false) 	
    end
    if (ind == 1 or ind == 5 or ind == 6 or ind == 7) then
       lib.add_line(ow+2*w, ow+4*w, 6*w, w, line_style, true, false) 
    else
       lib.add_line(ow+2*w, ow+4*w, 6*w, w, style, true, false) 
    end	
    if (ind == 2 or ind == 5 or ind == 8  or ind == 9) then
       lib.add_line(ow+2*w, ow+5*w, 6*w, 0, line_style, true, false) 
    else
       lib.add_line(ow+2*w, ow+5*w, 6*w, 0, style, true, false) 
    end	 
    if (ind == 3 or ind == 6 or ind == 8  or ind == 10) then
       lib.add_line(ow+2*w, ow+7*w, 6*w, -2*w, line_style, true, false) 
    else	
       lib.add_line(ow+2*w, ow+7*w, 6*w, -2*w, style, true, false) 
    end
    if (ind == 4 or ind == 7 or ind == 9 or ind == 10) then
       lib.add_line(ow+2*w, ow+9*w, 6*w, -4*w, line_style, true, false) 
    else
       lib.add_line(ow+2*w, ow+9*w, 6*w, -4*w, style, true, false)
    end
    if (ind < 5) then
       lib.add_line(ow+2*w, ow+w, 0, 3*w, line_style, true, false) 
    else
       lib.add_line(ow+2*w, ow+w, 0, 3*w, style, true, false)  
    end
    if (ind > 1 and ind < 8) then
       lib.add_line(ow+2*w, ow+4*w, 0, w, line_style, true, false) 
    else	
       lib.add_line(ow+2*w, ow+4*w, 0, w, style, true, false) 
    end
    if (ind == 3 or ind == 4 or ind > 5 and ind < 10) then
       lib.add_line(ow+2*w, ow+5*w, 0, 2*w, line_style, true, false) 
    else	
       lib.add_line(ow+2*w, ow+5*w, 0, 2*w, style, true, false)   
    end
    if (ind == 4 or ind == 7 or ind > 8) then
       lib.add_line(ow+2*w, ow+7*w, 0, 2*w, line_style, true, false) 
    else	
       lib.add_line(ow+2*w, ow+7*w, 0, 2*w, style, true, false)   
    end
	
    lib.add_line(ow+8*w, ow+5*w, 6*w, -4*w, style, false, false) 
    lib.add_line(ow+8*w, ow+5*w, 6*w, -2*w, style, false, false) 
    lib.add_line(ow+8*w, ow+5*w, 6*w, -w, style, false, false)  
    lib.add_line(ow+8*w, ow+5*w, 6*w, 0, style, false, false)  
    lib.add_line(ow+8*w, ow+5*w, 6*w, 4*w, style, false, false)  
    lib.add_line(ow+14*w, ow+w, 0, 8*w, style, false, false)  

    reply = trian .. value .. " " .. eq .. " " .. trian
    lib.add_input(ow+4*w, ow+11*w, 150, 40, reply)
	
    st_i = 4 * w
    st_j = w + ow  
    nr = 0
    for j = 1,3 do  
  	    y = 12*w+ow+j*st_j
	    if (j < 3) then
	        min = 1
	        max = 4
	    else
	        min = 2
	        max = 3	
        end		  
        for  i = min,max do
	         nr = nr + 1
	         x = w+ow+(i-1)*st_i
             lib.add_circle (x, y, v, colour_style, false, true)
             lib.add_input(x+v, y-ow, 50, 30, name_2[nr])
	     end
    end
		   
    for i = 1,11 do
        lib.add_line(w+ow, ow+(i-1)*w, 14*w, 0, grid_style, false, false)
    end
    for i = 1,15 do
        lib.add_line(ow+i*w, ow, 0, 10*w, grid_style, false, false)
    end
	
	lib.add_text(2*w, w+ow, "A", text_style)
    lib.add_text(2*w, 4*w+ow, "B", text_style)
    lib.add_text(2*w, 5*w+ow, "C", text_style)
    lib.add_text(2*w, 7*w+ow, "D", text_style)
    lib.add_text(2*w, 9*w+ow, "E", text_style)
    lib.add_text(8*w+ow, 4*w+ow, "O", text_style)  
    lib.add_text(15*w, w+ow, "P", text_style)	
    lib.add_text(15*w, 3*w+ow, "Q", text_style)
    lib.add_text(15*w, 4*w+ow, "R", text_style)
    lib.add_text(15*w, 5*w+ow, "S", text_style)	  
    lib.add_text(15*w, 9*w+ow, "T", text_style)

  lib.end_canvas()
end               
 