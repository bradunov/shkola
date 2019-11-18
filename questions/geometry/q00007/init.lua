style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

text_style = {["font_size"] = "16"}

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

mycanvas = function()
  lib.start_canvas(400, 280, "center")

  lib.add_triangle(70, 60, 30, 50, iza_style, false, false)
  lib.add_circle(70, 30, 10, iza_style, false, false)   
  lib.add_straight_path(40, 70, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(70, 70, {{20, -10}}, style, "", false)
  lib.add_rectangle(40, 70, 30, 30, style, false, false)
  lib.add_text(55, 85, "1")

  lib.add_straight_path(160, 50, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(190, 50, {{20, -10}}, style, "", false)
  lib.add_rectangle(160, 50, 30, 30, style, false, false)
  lib.add_triangle(220, 50, 30, 50, pored_style, false, false)
  lib.add_circle(220, 30, 10, pored_style, false, false) 
  lib.add_text(172, 62, "2")

  lib.add_straight_path(300, 40, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(330, 40, {{20, -10}}, style, "", false)
  lib.add_rectangle(300, 40, 30, 30, style, false, false)
  lib.add_triangle(320, 50, 30, 50, ispred_style, false, false)
  lib.add_circle(320, 30, 10, ispred_style, false, false) 
  lib.add_text(340, 52, "3")

  lib.add_triangle(70, 190, 50, 30, ispod_style, false, false)
  lib.add_straight_path(40, 170, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(70, 170, {{20, -10}}, style, "", false)
  lib.add_rectangle(40, 170, 30, 30, style, false, false)
  lib.add_circle(55, 205, 10, ispod_style, false, false) 
  lib.add_text(58, 185, "4")

  lib.add_straight_path(150, 210, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(180, 210, {{20, -10}}, style, "", false)
  lib.add_rectangle(150, 210, 30, 30, style, false, false)
  lib.add_triangle(180, 180, 30, 50, iznad_style, false, false)
  lib.add_circle(180, 160, 10, iznad_style, false, false) 
  lib.add_text(168, 222, "5")

  lib.add_straight_path(240, 160, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(270, 160, {{20, -10}}, style, "", false)
  lib.add_rectangle(240, 160, 30, 30, style, false, false)
  lib.add_triangle(300, 160, 30, 50, izmedju_style, false, false)
  lib.add_circle(300, 140, 10, izmedju_style, false, false)
  lib.add_straight_path(310, 160, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(340, 160, {{20, -10}}, style, "", false)
  lib.add_rectangle(310, 160, 30, 30, style, false, false) 
  lib.add_text(325, 175, "6")

  lib.end_canvas()
end                   
                  