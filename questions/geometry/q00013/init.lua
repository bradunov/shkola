
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "3"};

transparent_style = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "3"};

marker_style = 
	{["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};


izbor = math.random(2)

if (izbor == 1) then
   name = shapes_3d
   result = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 1 && result[5] == 1 && result[6] == 1 && result[7] == 1"
else
   name = shapes_2d
   result = "result[0] == 1 && result[1] == 1 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0"
end   
       

mycanvas = function(result)
  lib.start_canvas(320, 320, "center", result)

  offset = 38
  offset2 = 45

--[[ figure  ]]--  
  lib.add_rectangle(50-offset, 150, 30, 80, style, false, false)
  lib.add_ellipse(140-offset, 130, 20, 30, style, false, false)
  lib.add_triangle(300-offset2, 100, 70, 30, style, false, false)

--[[ kocka  ]]--  
  lib.add_straight_path(40-offset, 40, {{20, -10}, {40, 0}, {0, 40}, {-20, 10}}, style, "", false)
  lib.add_straight_path(80-offset, 40, {{20, -10}}, style, "", false)
  lib.add_rectangle(40-offset, 40, 40, 40, style, false, false)

--[[  lopta  ]]--
  lib.add_circle(220-offset2, 50, 30, transparent_style, false, false) 
  lib.add_curved_path (220-offset2, 20, {{30, 30, 0, 60}}, transparent_style, false, false)
  lib.add_curved_path (190-offset2, 50, {{30, 30, 60, 0}}, transparent_style, false, false) 
  lib.add_curved_path (195-offset2, 35, {{30, 30, 50, 0}}, transparent_style, false, false)

--[[ kvadar  ]]--  
  lib.add_straight_path(190-offset2, 190, {{40, -50}, {20, 0}, {0, 50}, {-40, 50}}, style,  false, false)
  lib.add_straight_path(210-offset2, 190, {{40, -50}}, style,  false, false)
  lib.add_rectangle(190-offset2, 190, 20, 50, style,  false, false)

--[[  piramida  ]]--
  lib.add_straight_path(150-offset, 300, {{-20, 15}, {-40, 0}, {40, -90}}, style,  false, false)
  lib.add_straight_path(110-offset, 300, {{-20, 15}}, style, false, false)
  lib.add_triangle(130-offset, 265, 40, 70, style, false, false)

--[[  kupa  ]]--
  lib.add_straight_path(270-offset2, 230, {{30, 80}, {30, -80}}, style, "", false)
  lib.add_ellipse(300-offset2, 230, 30, 10, style,  false, false )

--[[  markeri  ]]--
  lib.add_circle(175-offset, 120, 7, marker_style, false, true) 
  lib.add_circle(330-offset2, 90, 7, marker_style, false, true) 
  lib.add_circle(95-offset, 190, 7, marker_style, false, true) 
  lib.add_circle(115-offset, 50, 7, marker_style, false, true) 
  lib.add_circle(270-offset2, 50, 7, marker_style, false, true) 
  lib.add_circle(245-offset2, 220, 7, marker_style, false, true) 
  lib.add_circle(155-offset, 270, 7, marker_style, false, true) 
  lib.add_circle(330-offset2, 280, 7, marker_style, false, true)
  
  lib.end_canvas()
end
         
                  
            
                  
              
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  