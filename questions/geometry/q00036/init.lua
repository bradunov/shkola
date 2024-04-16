
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

text_style = {["font_size"] = "16"}

  x = {}
  y = {}
  index = {1,2,3,4,5,6}
  ind = {}
 
  ind = lib.math.random_shuffle(index)

  ow = 12
  ov = 40
  wx = 120
  wy = 88

  for i = 1,2 do
      x[i] = ow  + (i-1) * wx
	  x[i+2] = x[i]
	  x[i+4] = x[i]
  end
	
  for i = 1,3 do
      y[i] = ow + (i-1) * wy
	  y[i+3] = y[i]
  end
 	
mycanvas = function()

  lib.start_canvas(240, 240, "center")

  lib.add_straight_path(x[ind[1]], y[ind[1]], {{0, ov}, {ov, 0}}, style,  false, false)
  lib.add_input(x[ind[1]]+2*ow, y[ind[1]]+ow, 30, 30, lib.check_number(2, 15)) 

  lib.add_straight_path(x[ind[2]], y[ind[2]], {{ov, ov}, {ov, 0}}, style,  false, false)
  lib.add_input(x[ind[2]]+3*ow, y[ind[2]]+ow, 30, 30, lib.check_number(3, 15)) 

  lib.add_straight_path(x[ind[3]], y[ind[3]], {{ov, 0}, {ov, ov}}, style,  false, false)
  lib.add_input(x[ind[3]]+2*ow, y[ind[3]]+ow, 30, 30, lib.check_number(3, 15)) 

  lib.add_straight_path(x[ind[4]]+ov, y[ind[4]], {{-ov, ov}, {ov, 0}}, style,  false, false)
  lib.add_input(x[ind[4]]+3*ow, y[ind[4]]+ow, 30, 30, lib.check_number(1, 15)) 

  lib.add_straight_path(x[ind[5]], y[ind[5]]+ov, {{ov/2, -ov}, {ov/2, ov}}, style,  false, false)
  lib.add_input(x[ind[5]]+10, y[ind[5]]+3*ow, 30, 30, lib.check_number(1, 15)) 

  lib.add_straight_path(x[ind[6]]+ov, y[ind[6]], {{-ov, 0}, {0, ov}}, style,  false, false)
  lib.add_input(x[ind[6]]+2*ow, y[ind[6]]+ow, 30, 30, lib.check_number(2, 15)) 
        
  lib.end_canvas()
end    
