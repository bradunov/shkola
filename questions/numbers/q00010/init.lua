
left_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
right_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

frame_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

answ = {"=", "<", ">"}

mycanvas = function(no)

  w = 40
  ow = 10
  
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

dim = 3 * w 

lib.start_canvas(350, 300, "center")

  lib.add_ellipse (90, 130, 70, dim, frame_style, true, true)

  for i = 1, lindex1 do
      x = w + (w-ow)/2 + 10
      y = i*w + (w-ow)/2 
      lib.add_circle(x, y, ow, left_style, false, true)
  end
  for j = 1,lindex2 do
     x = 2*w + (w-ow)/2 + 20
      y = j*w + (w-ow)/2 
      lib.add_circle(x, y, ow, left_style, false, true)
  end 
  
  lib.add_ellipse (260, 130, 70, dim, frame_style, true, true)

  for i = 1, rindex1 do
      x = w + (w-ow)/2 + 180
      y = i*w + (w-ow)/2 
      lib.add_circle(x, y, ow, right_style, false, true)
  end
  for j = 1,rindex2 do
     x = 2*w + (w-ow)/2 + 190
      y = j*w + (w-ow)/2 
      lib.add_circle(x, y, ow, right_style, false, true)
  end

  lib.add_straight_path (90, 250, {{0, 30}}, frame_style, true, true)  
  lib.add_input(65, 280, 50, 50, lib.check_number(lsumm))
  lib.add_straight_path (260, 250, {{0, 30}}, frame_style, true, true)
  lib.add_input(235, 280, 50, 50, lib.check_number(rsumm))
  lib.add_input(150, 280, 50, 50, lib.check_one_option_dropdown(answ,sign))
  
  lib.end_canvas()
end                   
                  
