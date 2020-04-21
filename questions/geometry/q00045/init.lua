style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

diff_style = 
	{["off_color"] = "fff",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
check_style =
        {["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "fff",
        ["line_width"] = "1"};		


array_position = {"gore levo", "dole levo", "dole desno", "gore desno"}
choice = math.random(4)
place = array_position[choice] 

part  = {"spoljašnju", "unutrašnju"}
out = math.random(2)
figure = part[out]

include("shapes")

mycanvas = function()

  if (out == 1) then
      results = ""
      for i = 1,4 do  
          if (i > 1) then
              results = results .. "&& "
          end
          results = results .. "result[" .. tostring(i-1) .. "] == "
          if (i == choice) then
              results = results .. "1 "
          else
              results = results .. "0 "
          end       
      end
      results = results .. "&& result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0"	  
  else
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 "
      for i = 4,7 do  
          results = results .. "&& result[" .. tostring(i) .. "] == "
          if (i == choice + 3) then
             results = results .. "1 "
          else
             results = results .. "0 "
          end
          if (i == 7 and choice == 4) then
              results = results .. "&& " .. "result[8] == " .. "1" 
          end         
       end
   end  


  lib.start_canvas(300, 250, "center", results)

  w = 100
  ow = 40
  for i = 1,3 do
      lib.add_line(ow, ow+(i-1)*w, 2*w, 0, style, false, false)
      lib.add_line(ow+(i-1)*w, ow, 0, 2*w, style, false, false)
  end	

  lib.add_rectangle(ow+5, ow+5, w-10, w-10, check_style, false, true)
  lib.add_rectangle(ow+5, ow+5+w, w-10, w-10, check_style, false, true)
  lib.add_rectangle(ow+w+5, ow+5+w, w-10, w-10, check_style, false, true)
  lib.add_rectangle(ow+w+5, ow+5, w-10, w-10, check_style, false, true)		

  scale = 1.5

  lib.add_triangle (85, 80, 50, 50, diff_style, false, true)
  diamond(lib, 65, 190, scale, diff_style, false, true)
  lib.add_ellipse(190, 190, 35, 20, diff_style, false, true)
  heart(lib, 190, 120, scale, diff_style, false, true)

  lib.end_canvas()
end
                             