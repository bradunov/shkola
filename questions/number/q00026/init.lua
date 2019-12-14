style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

diff_style = 
	{["off_color"] = "fff",
        ["on_color"] = "faf",
        ["line_color"] = "00f",
        ["line_width"] = "2"};


array_position = {"gore levo", "gore desno", "dole levo", "dole desno"}
choice = math.random(4)
place = array_position[choice] 

mycanvas = function()

results = ""
  for i = 1,12 do  
      results = results .. "&& "
      results = results .. "result[" .. tostring(i-1) .. "] == "
      if (i == choice) then
        results = results .. "1 "
      else
        results = results .. "0 "
      end
  end


  lib.start_canvas(300, 300, "center", results)

  w = 70
  ow = 50
  for i = 1,4 do
    lib.add_line(ow, ow+(i-1)*w, 3*w, 0, style, false, false)
    lib.add_line(ow+(i-1)*w, ow, 0, 3*w, style, false, false)
  end

  lib.add_triangle (85, 80, 40, 40, diff_style, false, true)
  lib.add_circle (225, 80, 20, diff_style, false, true )
  lib.add_rectangle (65, 205, 40, 40, diff_style, false, true)
  lib.add_rectangle (200, 205, 50, 30, diff_style, false, true)  
  
  lib.add_curved_path(160, 100, {{40, -50, 0, -30}}, diff_style, false, true)
  lib.add_curved_path(160, 100, {{-40, -50, 0, -30}}, diff_style, false, true)
  
  lib.add_straight_path(65, 150, {{15, 0}, {0,-15}, {10,0}, {0,15}, {15,0}, {0,10}, {-15,0}, {0,15}, {-10,0}, {0,-15}, {-15,0}, {0,-10} }, diff_style, false, true)

lib.add_ellipse(155, 155, 25, 10, diff_style, false, true)

  lib.add_triangle (225, 170, 5, 20, diff_style, false, true)
  lib.add_curved_path(225, 130, {{30, 50, 0, 40}}, diff_style, false, true)
  lib.add_curved_path(225, 130, {{-30, 50, 0, 40}}, diff_style, false, true)

  lib.add_straight_path(140, 220, {{15, -5}, {5,-15}, {5,15}, {15,5}, {-15,5}, {-5,15}, {-5,-15}, {-15, -5} }, diff_style, false, true)
  
  lib.end_canvas()
end
                  
                      
                  