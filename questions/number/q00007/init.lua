
left_style = 
	{["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
right_style = 
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

frame_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

mycanvas = function(no)

  w = 40
  ow = 20
  
  lindex1 = math.random(4)+1
  lindex2 = math.random(lindex1 - 1)
  lsumm = lindex1 + lindex2
 
  rindex1 = math.random(4)+1
  rindex2 = math.random(rindex1 - 1)
  rsumm = rindex1 + rindex2
  
 if (lsumm == rsumm) then
  sign = "="
else
  if (lsumm > rsumm) then
    sign = ">"
  else
    sign = "<"
  end
end                   

dim = 6 * w 

lib.start_canvas(350, 300, "center")

lib.add_rectangle (30, 30, 120, dim, frame_style, true, true)

  for i = 1, lindex1 do
      x = w + (w-ow)/2 + 10
      y = i*w + (w-ow)/2 
      lib.add_rectangle(x, y, ow, ow, left_style, false, true)
  end
  for j = 1,lindex2 do
     x = 2*w + (w-ow)/2 + 10
      y = j*w + (w-ow)/2 
      lib.add_rectangle(x, y, ow, ow, left_style, false, true)
  end 
  
  lib.add_rectangle (200, 30, 120, dim, frame_style, true, true)

  for i = 1, rindex1 do
      x = w + (w-ow)/2 + 180
      y = i*w + (w-ow)/2 
      lib.add_rectangle(x, y, ow, ow, right_style, false, true)
  end
  for j = 1,rindex2 do
     x = 2*w + (w-ow)/2 + 180
      y = j*w + (w-ow)/2 
      lib.add_rectangle(x, y, ow, ow, right_style, false, true)
  end 
  
  lib.end_canvas()
end                   
                  
                  
                
                           
   
        