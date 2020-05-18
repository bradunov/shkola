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


mycanvas = function(result)
  lib.start_canvas(360, 350, "center", result)

  offset = 38
  offset2 = 45

--[[ figure  ]]--  
  lib.add_rectangle(50-offset, 190, 30, 80, style, false, false)
  lib.add_ellipse(150-offset, 150, 20, 30, style, false, false)
  lib.add_triangle(345-offset2, 150, 70, 30, style, false, false)

--[[ kocka  ]]--  
  lib.add_straight_path(40-offset, 70, {{20, -10}, {40, 0}, {0, 40}, {-20, 10}}, style, "", false)
  lib.add_straight_path(80-offset, 70, {{20, -10}}, style, "", false)
  lib.add_rectangle(40-offset, 70, 40, 40, style, false, false)

--[[  lopta  ]]--
  lib.add_circle(270-offset2, 70, 30, transparent_style, false, false) 
  lib.add_curved_path (270-offset2, 40, {{30, 30, 0, 60}}, transparent_style, false, false)
  lib.add_curved_path (240-offset2, 70, {{30, 30, 60, 0}}, transparent_style, false, false) 
  lib.add_curved_path (245-offset2, 55, {{30, 30, 50, 0}}, transparent_style, false, false)

--[[ kvadar  ]]--  
  lib.add_straight_path(210-offset2, 190, {{40, -50}, {20, 0}, {0, 50}, {-40, 50}}, style,  false, false)
  lib.add_straight_path(230-offset2, 190, {{40, -50}}, style,  false, false)
  lib.add_rectangle(210-offset2, 190, 20, 50, style,  false, false)

--[[  piramida  ]]--
  lib.add_straight_path(160-offset, 315, {{-20, 15}, {-40, 0}, {40, -90}}, style,  false, false)
  lib.add_straight_path(120-offset, 315, {{-20, 15}}, style, false, false)
  lib.add_triangle(140-offset, 280, 40, 70, style, false, false)

--[[  kupa  ]]--
  lib.add_straight_path(310-offset2, 250, {{30, 80}, {30, -80}}, style, "", false)
  lib.add_ellipse(340-offset2, 250, 30, 10, style,  false, false )

--[[  markeri  ]]--
  lib.add_circle(185-offset, 140, 7, marker_style, false, true) 
  lib.add_circle(375-offset2, 140, 7, marker_style, false, true) 
  lib.add_circle(95-offset, 230, 7, marker_style, false, true) 
  lib.add_circle(115-offset, 80, 7, marker_style, false, true) 
  lib.add_circle(320-offset2, 80, 7, marker_style, false, true) 
  lib.add_circle(255-offset2, 230, 7, marker_style, false, true) 
  lib.add_circle(170-offset, 300, 7, marker_style, false, true) 
  lib.add_circle(370-offset2, 300, 7, marker_style, false, true)
  
  lib.end_canvas()
end
         

izbor = math.random(2)


if (izbor == 1) then
   name = shapes_3d
   result = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 1 && result[5] == 1 && result[6] == 1 && result[7] == 1"
else
   name = shapes_2d
   result = "result[0] == 1 && result[1] == 1 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0"
end   
       
                  
            
                  
              
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  