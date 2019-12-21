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


include("shapes")


mycanvas = function()

  results = ""
  for i = 1,12 do  
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


  lib.start_canvas(300, 300, "center", results)

  w = 70
  ow = 50
  for i = 1,4 do
    lib.add_line(ow, ow+(i-1)*w, 3*w, 0, style, false, false)
    lib.add_line(ow+(i-1)*w, ow, 0, 3*w, style, false, false)
  end

  scale = 1

  lib.add_triangle (85, 80, 40, 40, diff_style, false, true)
  lib.add_circle (225, 80, 20, diff_style, false, true )
  lib.add_rectangle (65, 205, 40, 40, diff_style, false, true)
  lib.add_rectangle (200, 205, 50, 30, diff_style, false, true)  
  
  heart(lib, 160, 100, scale, diff_style, false, true)

  cross(lib, 65, 150, scale, diff_style, false, true)

  lib.add_ellipse(155, 155, 25, 10, diff_style, false, true)

  leaf(lib, 225, 130, scale, diff_style, false, true)

  diamond(lib, 140, 220, scale, diff_style, false, true)

  lib.end_canvas()
end
                  
                      
                  