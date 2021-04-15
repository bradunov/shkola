
include("terms")

style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

check_style = {["off_color"] = "fff",
        ["on_color"] = "c90",
        ["line_color"] = "000",
        ["line_width"] = "2"};

pored_style = {["off_color"] = "ff0",
               ["on_color"] = "ff0",
               ["line_color"] = "000",
               ["line_width"] = "2"};

ispred_style = {["off_color"] = "6f6",
                ["on_color"] = "6f6",
                ["line_color"] = "000",
                ["line_width"] = "2"};

iznad_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "2"};

izmedju_style = {["off_color"] = "f90",
               ["on_color"] = "f90",
               ["line_color"] = "000",
               ["line_width"] = "2"};
			   
ispod_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "2"};			   
			   
iza_style = {["off_color"] = "f9c",
             ["on_color"] = "f9s",
             ["line_color"] = "000",
             ["line_width"] = "2"};			

ind = math.random(6)			 

mycanvas = function()

 results = ""
  
  for i = 1,6 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if ( i == ind) then
          results = results .. "1 "
	  else
          results = results .. "0 " 
      end		  
  end		  
		 		  
  lib.start_canvas( 320, 220, "center", results)

  lib.add_triangle(40, 60, 30, 50, iza_style, false, false)
  lib.add_circle(40, 30, 10, iza_style, false, false)   
  lib.add_straight_path(10, 70, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(40, 70, {{20, -10}}, style, "", false)
  lib.add_rectangle(10, 70, 30, 30, style, false, false)
  lib.add_circle(25, 85, 7,  check_style, false, true)

  lib.add_straight_path(120, 50, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(150, 50, {{20, -10}}, style, "", false)
  lib.add_rectangle(120, 50, 30, 30, style, false, false)
  lib.add_triangle(180, 50, 30, 50, pored_style, false, false)
  lib.add_circle(180, 30, 10, pored_style, false, false) 
  lib.add_circle(135, 65, 7, check_style, false, true)

  lib.add_straight_path(250, 40, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(280, 40, {{20, -10}}, style, "", false)
  lib.add_rectangle(250, 40, 30, 30, style, false, false)
  lib.add_triangle(265, 50, 30, 50, ispred_style, false, false)
  lib.add_circle(265, 30, 10, ispred_style, false, false) 
  lib.add_circle(290, 50, 7, check_style, false, true)

  lib.add_triangle(40, 170, 50, 30, ispod_style, false, false)
  lib.add_straight_path(10, 150, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(40, 150, {{20, -10}}, style, "", false)
  lib.add_rectangle(10, 150, 30, 30, style, false, false)
  lib.add_circle(25, 185, 10, ispod_style, false, false) 
  lib.add_circle(50, 160, 7, check_style, false, true)

  lib.add_straight_path(100, 170, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(130, 170, {{20, -10}}, style, "", false)
  lib.add_rectangle(100, 170, 30, 30, style, false, false)
  lib.add_triangle(130, 140, 30, 50, iznad_style, false, false)
  lib.add_circle(130, 120, 10, iznad_style, false, false) 
  lib.add_circle(115, 185, 7, check_style, false, true)

  lib.add_straight_path(180, 140, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(210, 140, {{20, -10}}, style, "", false)
  lib.add_rectangle(180, 140, 30, 30, style, false, false)
  lib.add_triangle(240, 140, 30, 50, izmedju_style, false, false)
  lib.add_circle(240, 120, 10, izmedju_style, false, false)
  lib.add_straight_path(250, 140, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(280, 140, {{20, -10}}, style, "", false)
  lib.add_rectangle(250, 140, 30, 30, style, false, false) 
  lib.add_circle(265, 155, 7, check_style, false, true)

  lib.end_canvas()
end                   
                  