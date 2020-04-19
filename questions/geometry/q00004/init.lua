green_style = {["off_color"] = "fff",
         ["on_color"] = "6f6",
         ["line_color"] = "000",
         ["line_width"] = "2"};

yelow_style = {["off_color"] = "fff",
               ["on_color"] = "ff0",
               ["line_color"] = "000",
               ["line_width"] = "2"};

blue_style = {["off_color"] = "fff",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "2"};
			   
red_style = {["off_color"] = "fff",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "2"};			   


figure = {"krugove", "pravougaonike", "kvadrate", "trouglove"}

ind = math.random(4)


mycanvas = function()
 
  results = ""
  
  for i = 1,11 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if ( i >= 3*ind-2 and i<=3*ind) then
          results = results .. "1 "
	  else
          results = results .. "0 " 
      end		  
  end		  
		 		  
  lib.start_canvas( 310, 220, "center", results)

  lib.add_circle(95, 175, 15, red_style, false, true)
  lib.add_circle(170, 175, 15, red_style, false, true)
  lib.add_circle(205, 175, 15, red_style, false, true)
  
  lib.add_rectangle(70, 100, 150, 60, blue_style, false, true)
  lib.add_rectangle(240, 110, 20, 50, blue_style, false, true)
  lib.add_rectangle(150, 25, 75, 15, blue_style, false, true)
  
  lib.add_rectangle(90, 70, 30, 30, green_style, false, true)
  lib.add_rectangle(220, 130, 20, 20, green_style, false, true) 
  lib.add_rectangle(160, 40, 60, 60, green_style, false, true)

  lib.add_triangle(105, 55, 40, 30, yelow_style, false, true) 
  lib.add_straight_path (70, 100, {{-20, 30}, {20, 30}, {0, -60} }, yelow_style, false, true)

  lib.end_canvas()
end
  
          
 