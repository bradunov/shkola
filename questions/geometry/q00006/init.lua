include("terms")

style = {["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};

        
ind = math.random(4)


mycanvas = function()

  results = ""
  
  for i = 1,4 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if ( i == ind ) then
          results = results .. "1 "
	  else
          results = results .. "0 " 
      end		  
  end

  lib.start_canvas(300, 250, "center", results)
 
  lib.add_straight_path (80, 120, {{50, 0}, {0, 20}, {-50,0}, {0, 10}, {-30, -20}, {30, -20}, {0, 10}}, style, false, true) 
  
  lib.add_straight_path (150, 50, {{0, 50}, {20, 0}, {0, -50}, {10, 0}, {-20, -30}, {-20, 30}, {10, 0}}, style, false, true)
  
  lib.add_straight_path (240, 140, {{-50, 0}, {0, -20}, {50,0}, {0, -10}, {30, 20}, {-30, 20}, {0, -10}}, style, false, true)

  lib.add_straight_path (150, 210, {{0, -50}, {20, 0}, {0, 50}, {10, 0}, {-20, 30}, {-20, -30}, {10, 0}}, style, false, true)  
  
  lib.end_canvas()
end

