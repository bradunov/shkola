include("terms")

style = {["off_color"] = "fff",
        ["on_color"] = "aff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f9c",
        ["line_color"] = "00f",
        ["line_width"] = "4"};
		
ind = math.random(2)	

mycanvas = function(no)

  results = ""
  
  for i = 1,4 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if (i >= 2*ind-1 and i<=2*ind) then
          results = results .. "1 "
	  else
          results = results .. "0 " 
      end		  
  end	
  
  lib.start_canvas(300, 200, "center", results)

  lib.add_triangle(65, 110, 40, 120, different_style, false, true)
  lib.add_circle(65, 40, 15,  different_style, false, true)

  lib.add_triangle(200, 120, 120, 100, different_style, false, true)
  lib.add_circle(200, 45, 25, different_style, false, true)

  lib.end_canvas()
end



