
include("terms")

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


ind = math.random(4)
ch = math.random(4)

if (ch == 1) then
    max_range = 11
else	
    max_range = 12
end	

mycanvas = function()
 
  results = ""
  
  for i = 1,max_range do 
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
		 		  
  lib.start_canvas( 310, 230, "center", results)

if (ch == 1) then  
  lib.add_rectangle(70, 100, 150, 60, blue_style, false, true)
  lib.add_rectangle(240, 110, 20, 50, blue_style, false, true)
  lib.add_rectangle(150, 25, 75, 15, blue_style, false, true)  
  
  lib.add_rectangle(90, 70, 30, 30, green_style, false, true)
  lib.add_rectangle(220, 130, 20, 20, green_style, false, true) 
  lib.add_rectangle(160, 40, 60, 60, green_style, false, true)
 
  lib.add_circle(95, 175, 15, red_style, false, true)
  lib.add_circle(170, 175, 15, red_style, false, true)
  lib.add_circle(205, 175, 15, red_style, false, true)

  lib.add_triangle(105, 55, 40, 30, yelow_style, false, true) 
  lib.add_straight_path (70, 100, {{-20, 30}, {20, 30}, {0, -60} }, yelow_style, false, true)
end

if (ch == 2) then 
  lib.add_rectangle(50, 120, 190, 80, blue_style, false, true)
  lib.add_rectangle(130, 40, 30, 80, blue_style, false, true) 
  lib.add_rectangle(70, 80, 60, 40, blue_style, false, true)

  lib.add_rectangle(160, 80, 40, 40, green_style, false, true)
  lib.add_rectangle(135, 10, 15, 15, green_style, false, true)
  lib.add_rectangle(135, 25, 15, 15, green_style, false, true)

  lib.add_circle(90, 150, 15, red_style, false, true)
  lib.add_circle(150, 150, 15, red_style, false, true)
  lib.add_circle(210, 150, 15, red_style, false, true)
  
  lib.add_straight_path (135, 15, {{-20, 10}, {20, 10}, {0, -20} }, yelow_style, false, true)
  lib.add_straight_path (50, 120, {{-20, 0}, {20, 80}, {0, -80} }, yelow_style, false, true)
  lib.add_straight_path (240, 120, {{40, 0}, {-40, 80}, {0, -80} }, yelow_style, false, true)
end

if (ch == 3) then 
  lib.add_straight_path (140, 15, {{40, 0}, {0, 10}, {-40, 0}, {0, -10}}, blue_style, false, true)
  lib.add_straight_path (145, 110, {{0, -15}, {-50, 0}, {0, 15}, {50, 0}}, blue_style, false, true)
  lib.add_straight_path (175, 110, {{0, -15}, {50, 0}, {0, 15}, {-50, 0}},  blue_style, false, true)

  lib.add_rectangle(153, 65, 15, 15, green_style, false, true)
  lib.add_rectangle(130, 180, 20, 20, green_style, false, true)
  lib.add_rectangle(170, 180, 20, 20, green_style, false, true)

  lib.add_circle(160, 45, 20, red_style, false, true)
  lib.add_circle(140, 210, 10, red_style, false, true)
  lib.add_circle(180, 210, 10, red_style, false, true)

  lib.add_triangle(160, 130, 110, 100, yelow_style, false, true) 
  lib.add_straight_path (142, 25, {{-30, 30}, {20, 0}, {10, -30}}, yelow_style, false, true)
  lib.add_straight_path (178, 25, {{30, 30}, {-20, 0}, {-10, -30}}, yelow_style, false, true)
end  

if (ch == 4) then 
  lib.add_rectangle(120, 70, 80, 100, blue_style, false, true)
  lib.add_rectangle(50, 180, 70, 30, blue_style, false, true) 
  lib.add_rectangle(200, 180, 70, 30, blue_style, false, true) 

  lib.add_rectangle(140, 25, 45, 45, green_style, false, true)
  lib.add_rectangle(80, 140, 40, 40, green_style, false, true)
  lib.add_rectangle(200, 140, 40, 40, green_style, false, true)

  lib.add_circle(150, 40, 7, red_style, false, true)
  lib.add_circle(175, 40, 7, red_style, false, true)
  lib.add_circle(160, 7, 5, red_style, false, true)

  lib.add_triangle(160, 20, 30, 10, yelow_style, false, true) 
  lib.add_straight_path (120, 70, {{-40, -20}, {0, 60}, {40, -40}}, yelow_style, false, true)
  lib.add_straight_path (200, 70, {{40, -20}, {0,60}, {-40, -40}}, yelow_style, false, true)
end  

  lib.end_canvas()
end