
style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

marker_style = {["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};			 

mycanvas = function()

index = {1,2,3,4}
indup = lib.math.random_shuffle(index)
inddown = lib.math.random_shuffle(index)
 
  lib.start_canvas(340, 380, "center", "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 1 && result[5] == 0")

  w = 30
  ow = 10


  for i = 1, 4 do
      lib.add_rectangle (ow+(i-1)*w, ow+w, w, w, style, false, false)
  end
  lib.add_rectangle (ow+(indup[1]-1)*w, ow, w, w, style, false, false)
  lib.add_rectangle (ow+(inddown[1]-1)*w, ow+2*w, w, w, style, false, false)

  for i = 1, 3 do
      lib.add_rectangle (ow+ 6*w+(i-1)*w, ow, w, w, style, false, false)
	  lib.add_rectangle (ow+ 6*w+(i-1)*w, ow+w, w, w, style, false, false)
  end

  for i = 1, 4 do
      lib.add_rectangle (ow+(i-1)*w, ow+5*w, w, w, style, false, false)
  end
  if (indup[2] == inddown[2]) then
      temp = inddown[4]
  else
      temp = inddown[2]
  end 
  lib.add_rectangle (ow+(indup[2]-1)*w, ow+6*w, w, w, style, false, false)  
  lib.add_rectangle (ow+(temp-1)*w, ow+6*w, w, w, style, false, false) 
  
 for i = 1, 4 do
      lib.add_rectangle (ow+6*w+(i-1)*w, ow+5*w, w, w, style, false, false)
  end
  lib.add_rectangle (ow+6*w+(indup[3]-1)*w, ow+4*w, w, w, style, false, false)	  
  lib.add_rectangle (ow+6*w+(inddown[3]-1)*w, ow+6*w, w, w, style, false, false)   

  for i = 1, 4 do
      lib.add_rectangle (ow+(i-1)*w, ow+10*w, w, w, style, false, false)
  end
  lib.add_rectangle (ow+(indup[4]-1)*w, ow+9*w, w, w, style, false, false)
  lib.add_rectangle (ow+(inddown[4]-1)*w, ow+11*w, w, w, style, false, false)
  
  for i = 1, 4 do
      lib.add_rectangle (ow+ 6*w+(i-1)*w, ow+10*w, w, w, style, false, false)
  end
    if (indup[3] == inddown[3]) then
      temp = indup[4]
  else
      temp = indup[3]
  end 	  
  lib.add_rectangle (ow+ 6*w+(temp-1)*w, ow+9*w, w, w, style, false, false)
  lib.add_rectangle (ow+ 6*w+(inddown[3]-1)*w, ow+9*w, w, w, style, false, false) 

--[[  markeri  ]]--
  lib.add_circle(2*ow, 2*ow+w, 7, marker_style, false, true) 
  lib.add_circle(2*ow+6*w, 2*ow+w, 7, marker_style, false, true)
  lib.add_circle(2*ow, 2*ow+5*w, 7, marker_style, false, true) 
  lib.add_circle(2*ow+6*w, 2*ow+5*w, 7, marker_style, false, true) 
  lib.add_circle(2*ow, 2*ow+10*w, 7, marker_style, false, true)
  lib.add_circle(2*ow+6*w, 2*ow+10*w, 7, marker_style, false, true)


  lib.end_canvas()
end           
 
