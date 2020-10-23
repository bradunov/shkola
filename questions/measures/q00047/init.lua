
red_style = {["off_color"] = "fff",
         ["on_color"] = "f30",
         ["line_color"] = "000",
         ["line_width"] = "2"};
		 
green_style = {["off_color"] = "6f6",
               ["on_color"] = "6f6",
               ["line_color"] = "000",
               ["line_width"] = "2"};

blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "2"};

brown_style = {["off_color"] = "c60",
               ["on_color"] = "c60",
               ["line_color"] = "000",
               ["line_width"] = "2"};
                                                                                                                                                                                                                                                                                                line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["off_line_color"] = "000",
        ["line_width"] = "2"}; 

dot_style = {["font_size"] = "30"}

name1 = { "laksa", "lakša"}
name2 = { "teza", "teža"}

reply1 = "answer == '" .. name1[1] .. "' "  ..
        "|| answer == '" .. name1[2] .. "'" ;
ans1 = "answer = '" .. name1[1] .. "' ";
reply2 = "answer == '" .. name2[1] .. "' "  ..
        "|| answer == '" .. name2[2] .. "'" ;
ans2 = "answer = '" .. name2[1] .. "' ";

	
mycanvas = function()
  
  lib.start_canvas(350, 250, "center")
  
  lib.add_straight_path(35, 95, {{120, -60}}, line_style, false, true)
  lib.add_triangle (100, 80, 30, 30, brown_style, false, true)
  lib.add_rectangle (20, 55, 20, 40, blue_style, false, false)
  lib.add_circle (30, 45, 10, blue_style, false, false)
  lib.add_rectangle (150, 15, 10, 20, green_style, true)
  lib.add_circle (155, 10, 5, green_style, false, false)

  lib.add_straight_path(200, 95, {{120, 60}}, line_style, false, true)
  lib.add_triangle (250, 137, 30, 30, brown_style, false, true) 
  lib.add_rectangle (318, 125, 15, 30, red_style, true)
  lib.add_circle (325, 118, 7, red_style, true, false)
  lib.add_rectangle (190, 75, 10, 20, green_style, true)
  lib.add_circle (195, 70, 5, green_style, false, false)

  lib.add_straight_path(35, 220, {{120, -60}}, line_style, false, true)
  lib.add_triangle (100, 205, 30, 30, brown_style, false, true)
  lib.add_rectangle (20, 180, 20, 40, blue_style, false, false)
  lib.add_circle (30, 170, 10, blue_style, false, false)
  lib.add_rectangle (150, 130, 15, 30, red_style, true)
  lib.add_circle (157, 122, 7, red_style, true, false)
 
  lib.end_canvas()
end  
 
                  
            
                      
            