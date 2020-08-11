
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
  lib.start_canvas(320, 260, "center")

  lib.add_triangle(40, 60, 30, 50, iza_style, false, false)
  lib.add_circle(40, 30, 10, iza_style, false, false)   
  lib.add_straight_path(10, 70, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(40, 70, {{20, -10}}, style, "", false)
  lib.add_rectangle(10, 70, 30, 30, style, false, false)
  lib.add_text(25, 85, "1")

  lib.add_straight_path(120, 50, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(150, 50, {{20, -10}}, style, "", false)
  lib.add_rectangle(120, 50, 30, 30, style, false, false)
  lib.add_triangle(180, 50, 30, 50, pored_style, false, false)
  lib.add_circle(180, 30, 10, pored_style, false, false) 
  lib.add_text(132, 62, "2")

  lib.add_straight_path(250, 40, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(280, 40, {{20, -10}}, style, "", false)
  lib.add_rectangle(250, 40, 30, 30, style, false, false)
  lib.add_triangle(270, 50, 30, 50, ispred_style, false, false)
  lib.add_circle(270, 30, 10, ispred_style, false, false) 
  lib.add_text(290, 52, "3")

  lib.add_triangle(40, 190, 50, 30, ispod_style, false, false)
  lib.add_straight_path(10, 170, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(40, 170, {{20, -10}}, style, "", false)
  lib.add_rectangle(10, 170, 30, 30, style, false, false)
  lib.add_circle(25, 205, 10, ispod_style, false, false) 
  lib.add_text(28, 185, "4")

  lib.add_straight_path(100, 210, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(130, 210, {{20, -10}}, style, "", false)
  lib.add_rectangle(100, 210, 30, 30, style, false, false)
  lib.add_triangle(130, 180, 30, 50, iznad_style, false, false)
  lib.add_circle(130, 160, 10, iznad_style, false, false) 
  lib.add_text(118, 222, "5")

  lib.add_straight_path(180, 160, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(210, 160, {{20, -10}}, style, "", false)
  lib.add_rectangle(180, 160, 30, 30, style, false, false)
  lib.add_triangle(240, 160, 30, 50, izmedju_style, false, false)
  lib.add_circle(240, 140, 10, izmedju_style, false, false)
  lib.add_straight_path(250, 160, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(280, 160, {{20, -10}}, style, "", false)
  lib.add_rectangle(250, 160, 30, 30, style, false, false) 
  lib.add_text(265, 175, "6")

  lib.end_canvas()
end                   
                 