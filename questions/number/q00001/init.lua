
style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "2"};

frame_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

mycanvas = function(no)

  w = 70
  ow = 40 
  index1 = math.random(5)
  index2 = math.random(index1)
 total = index1 + index2

lib.start_canvas(400, 200, "center")

lib.add_rectangle (30, 30, 350, 150, frame_style, true, true)

  for i = 1, index1 do
      x = i*w + (w-ow)/2 - 20
      y = w + (w-ow)/2 - 20
      lib.add_triangle(x, y, ow, ow, style, false, true)
  end
  for i = 1,index2 do
     x = i*w + (w-ow)/2 - 20
      y = 2*w + (w-ow)/2 - 20
      lib.add_triangle(x, y, ow, ow, style, false, true)
  end 
  
  lib.end_canvas()
end                   
                                  
   
        