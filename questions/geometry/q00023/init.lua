
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

  lib.start_canvas(335, 300, "center", result)

--[[  valjak  ]]--
  lib.add_straight_path(30, 50, {{0, 60}}, style,  false, false)
  lib.add_straight_path(90, 50, {{0, 60}}, style,  false, false)
  lib.add_ellipse(60, 50, 30, 10, style,  false, false )
  lib.add_ellipse(60, 110, 30, 10, style,  false, false )
  lib.add_input(40, 125, 30, 30, lib.check_number(2, 15))  
  
--[[ kocka  ]]--  
  lib.add_straight_path(140, 60, {{20, -10}, {40, 0}, {0, 40}, {-20, 10}}, style, "", false)
  lib.add_straight_path(180, 60, {{20, -10}}, style, "", false)
  lib.add_rectangle(140, 60, 40, 40, style, false, false)
  lib.add_input(160, 110, 30, 30, lib.check_number(1, 15))

--[[  lopta  ]]--
  lib.add_circle(270, 70, 30, transparent_style, false, false) 
  lib.add_curved_path (270, 40, {{30, 30, 0, 60}}, transparent_style, false, false)
  lib.add_curved_path (240, 70, {{30, 30, 60, 0}}, transparent_style, false, false) 
  lib.add_curved_path (245, 55, {{30, 30, 50, 0}}, transparent_style, false, false)
  lib.add_input(250, 105, 30, 30, lib.check_number(2, 15))

--[[ kvadar  ]]--  
  lib.add_straight_path(240, 220, {{40, -50}, {20, 0}, {0, 50}, {-40, 50}}, style,  false, false)
  lib.add_straight_path(260, 220, {{40, -50}}, style,  false, false)
  lib.add_rectangle(240, 220, 20, 50, style,  false, false)
  lib.add_input(235, 280, 30, 30, lib.check_number(1, 15))

--[[  piramida  ]]--
  lib.add_straight_path(100, 260, {{-20, 15}, {-40, 0}, {40, -90}}, style,  false, false)
  lib.add_straight_path(60, 260, {{-20, 15}}, style, false, false)
  lib.add_triangle(80, 225, 40, 70, style, false, false)
  lib.add_input(50, 280, 30, 30, lib.check_number(1, 15))

--[[  kupa  ]]--
  lib.add_straight_path(145, 190, {{30, 80}, {30, -80}}, style, "", false)
  lib.add_ellipse(175, 190, 30, 10, style,  false, false )
  lib.add_input(160, 280, 30, 30, lib.check_number(2, 15))

  lib.end_canvas()
end            
  