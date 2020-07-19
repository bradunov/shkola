
model = {"kocka", "lopta", "valjak",  "kvadar", "piramida", "kupa"}  
surf = {"ravnim", "krivim"}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

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
  lib.start_canvas(340, 380, "center", result)

  offset = 38
  offset2 = 45



--[[ kocka  ]]--  
  lib.add_straight_path(70-offset, 40, {{20, -10}, {40, 0}, {0, 40}, {-20, 10}}, style, "", false)
  lib.add_straight_path(110-offset, 40, {{20, -10}}, style, "", false)
  lib.add_rectangle(70-offset, 40, 40, 40, style, false, false)
  lib.add_input(25, 90, 75, 30, lib.check_string(model[1], 55)) 

--[[  lopta  ]]--
  lib.add_circle(250-offset2, 50, 30, transparent_style, false, false) 
  lib.add_curved_path (250-offset2, 20, {{30, 30, 0, 60}}, transparent_style, false, false)
  lib.add_curved_path (220-offset2, 50, {{30, 30, 60, 0}}, transparent_style, false, false) 
  lib.add_curved_path (225-offset2, 35, {{30, 30, 50, 0}}, transparent_style, false, false)
  lib.add_input(170, 90, 75, 30, lib.check_string(model[2], 55)) 

--[[  valjak  ]]--
  lib.add_straight_path(130-offset, 140, {{0, 60}}, style,  false, false)
  lib.add_straight_path(190-offset, 140, {{0, 60}}, style,  false, false)
  lib.add_ellipse(160-offset, 140, 30, 10, style,  false, false )
  lib.add_ellipse(160-offset, 200, 30, 10, style,  false, false )
  lib.add_input(85, 220, 75, 30, lib.check_string(model[3], 55))

--[[ kvadar  ]]--  
  lib.add_straight_path(280-offset2, 160, {{40, -50}, {20, 0}, {0, 50}, {-40, 50}}, style,  false, false)
  lib.add_straight_path(300-offset2, 160, {{40, -50}}, style,  false, false)
  lib.add_rectangle(280-offset2, 160, 20, 50, style,  false, false)
  lib.add_input(230, 220, 75, 30, lib.check_string(model[4], 55))

--[[  piramida  ]]--
  lib.add_straight_path(120-offset, 340, {{-20, 15}, {-40, 0}, {40, -90}}, style,  false, false)
  lib.add_straight_path(80-offset, 340, {{-20, 15}}, style, false, false)
  lib.add_triangle(100-offset, 305, 40, 70, style, false, false)
  lib.add_input(15, 360, 75, 30, lib.check_string(model[5], 55)) 

--[[  kupa  ]]--
  lib.add_straight_path(210-offset2, 270, {{30, 80}, {30, -80}}, style, "", false)
  lib.add_ellipse(240-offset2, 270, 30, 10, style,  false, false )
  lib.add_input(160, 360, 75, 30, lib.check_string(model[6], 55)) 

--[[  markeri  ]]--
  lib.add_circle(90-offset, 60, 7, marker_style, false, true) 
  lib.add_circle(160-offset, 140, 7, marker_style, false, true)
  lib.add_circle(320-offset2, 155, 7, marker_style, false, true) 
  lib.add_circle(100-offset, 320, 7, marker_style, false, true) 
  lib.add_circle(240-offset2, 270, 7, marker_style, false, true)

  lib.add_circle(250-offset2, 40, 7, marker_style, false, true)
  lib.add_circle(160-offset, 170, 7, marker_style, false, true) 
  lib.add_circle(240-offset2, 310, 7, marker_style, false, true)
  
  lib.end_canvas()
end
         

izbor = math.random(2)


if (izbor == 1) then
   name = surf[1]
   result = "result[0] == 1 && result[1] == 1 && result[2] == 1 && result[3] == 1 && result[4] == 1 && result[5] == 0 && result[6] == 0 && result[7] == 0"
else
   name = surf[2]
   result = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 1 && result[6] == 1 && result[7] == 1"
end   
               
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  