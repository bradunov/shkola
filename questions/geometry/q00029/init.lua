
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
 
  lib.start_canvas(340, 350, "center", "result[0] == 1 && result[1] == 0 && result[2] == 1 && result[3] == 1 && result[4] == 0")

  w = 30
  ow = 10

  lib.add_rectangle (2*ow, ow+w, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+w/2, ow+w, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow+3*w/2, ow+w, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+2*w, ow+w, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow, ow, w/2, w, style, false, false)
  lib.add_rectangle (2*ow+w/2, ow+3*w, w, w/2, style, false, false)

  lib.add_rectangle (2*ow+5*w, ow, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+11*w/2, ow, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow+13*w/2, ow, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+7*w, ow, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow+8*w, ow, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+11*w/2, ow+2*w, w, w/2, style, false, false)

  lib.add_rectangle (2*ow+5*w, ow+5*w, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+11*w/2, ow+5*w, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow+13*w/2, ow+5*w, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+7*w, ow+5*w, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow+11*w/2, ow+9*w/2, w, w/2, style, false, false)
  lib.add_rectangle (2*ow+11*w/2, ow+7*w, w, w/2, style, false, false)

  lib.add_rectangle (2*ow, ow+5*w, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+w/2, ow+5*w, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow+3*w/2, ow+5*w, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+w/2, ow+7*w, w, w/2, style, false, false)  
  lib.add_rectangle (2*ow+w/2, ow+15*w/2, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow+w/2, ow+19*w/2, w, w/2, style, false, false)


  lib.add_rectangle (2*ow+5*w, ow+9*w, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+11*w/2, ow+9*w, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow+13*w/2, ow+9*w, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+7*w, ow+9*w, w, 2*w, style, false, false)
  lib.add_rectangle (2*ow+8*w, ow+9*w, w/2, 2*w, style, false, false)
  lib.add_rectangle (2*ow+4*w, ow+9*w, w, 2*w, style, false, false)

--[[  markeri  ]]--
  lib.add_circle(2*w-ow, 2*w+ow, 7, marker_style, false, true) 
  lib.add_circle(2*ow+6*w, ow+w, 7, marker_style, false, true)
  lib.add_circle(2*w-ow, 6*w+ow, 7, marker_style, false, true) 
  lib.add_circle(2*ow+6*w, 6*w+ow, 7, marker_style, false, true) 
  lib.add_circle(2*ow+6*w, ow+10*w, 7, marker_style, false, true)


  lib.end_canvas()
end           
       
