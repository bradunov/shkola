
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
  index1 = math.random(4)+1
  index2 = math.random(index1 - 1)
 total = 10 - (index1 + index2)

lib.start_canvas(350, 200, "center")

lib.add_rectangle (5, 30, 340, 150, frame_style, true, true)

  for i = 1, index1 do
      x = (i+1/2)*w - w
      y = w + (w-ow)/2 - 20
      lib.add_triangle(x, y, ow, ow, style, false, true)
  end
  for i = 1,index2 do
     x = (i+1/2)*w - w
      y = 2*w + (w-ow)/2 - 20
      lib.add_triangle(x, y, ow, ow, style, false, true)
  end 
  
  lib.end_canvas()
end                   
                  
                           
   
        