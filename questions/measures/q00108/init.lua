
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["off_line_color"] = "000",
        ["line_width"] = "3"};
		
yellow_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

green_style = 
	{["off_color"] = "3c3",
        ["on_color"] = "3c3",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

dif_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "1"};		

text_style = {["font_size"] = "14"}

ptx = {}
pty = {}
ch = math.random(2)

              
mycanvas = function()

if (ch == 1) then
   result = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 "
else
   result = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 0"
end   
	
  lib.start_canvas(300, 200, "center", result)
  
  ow = 20
  ov = 90
  w = 60
  v = 5
   
  ptx[1] = 2*ow
  pty[1] = 2*w + ow 
  ptx[2] = 4 * w 
  pty[2] = w+ow
  difx = math.floor(0.5*(ptx[1]+ptx[2]))
  dify = math.floor(0.5*(pty[1]+pty[2]))
  ptx[6] = ptx[1] + w 
  pty[6] = pty[1] -w - 2*ow 
  ptx[7] = ptx[6] + w
  pty[7] = pty[6]  
  ptx[8] = ptx[7] + w/2 - 5
  pty[8] = pty[7]  
  ptx[3] = difx - ow + math.random(8)*v 
  pty[3] = dify + (3 + math.random(5))*v
  ptx[4] = ptx[6] - ow + math.random(8)*v
  pty[4] = dify + 2*ow + math.random(8)*v  
  ptx[5] = ptx[2] - ow - math.random(6)*v
  pty[5] = dify + ow + math.random(8)*v  

  lib.add_triangle (ptx[1] - ow, pty[1], 20, 30, yellow_style, true, false)
  lib.add_circle (ptx[1] - ow, pty[1] -ow, 5, yellow_style, true, false)
  lib.add_straight_path(ptx[2]+2*v, pty[2]-ow, {{0, 40}, {30, 0}, {0, -40}, {-15, -10}, {-15, 10}},  green_style, true, false)  

  lib.add_curved_path(ptx[1], pty[1]-v, {{40, -120, ptx[6]-ptx[1], pty[6]-pty[1]}, {40, 20, ptx[7]-ptx[6], pty[7]-pty[6]}, {20, -40, ptx[2]-ptx[7], pty[2]-pty[7]}}, style, false, true)   
  lib.add_straight_path(ptx[1], pty[1]+v, {{ptx[4] - ptx[1], pty[4] - pty[1]}, {ptx[5] - ptx[4], pty[5] - pty[4]}, {ptx[2] - ptx[5], pty[2] - pty[5]}}, style, false, true) 
  lib.add_straight_path(ptx[1], pty[1]+v, {{ptx[3] - ptx[1], pty[3] - pty[1]}, {ptx[2] - ptx[3], pty[2] - pty[3]}}, style, false, true)
  lib.add_line(ptx[1], pty[1], ptx[2] - ptx[1], pty[2] - pty[1], style, false, true)

  for i = 1,5 do
    if (i < 3) then
        lib.add_circle (ptx[i], pty[i], 4, dif_style, false, false)
    else
        lib.add_circle (ptx[i], pty[i]+v, 3, dif_style, false, false)
    end
--[[
    lib.add_text(ptx[i], pty[i], tostring(i), text_style, false, false)
]]--
  end
   
  lib.end_canvas()
end
     