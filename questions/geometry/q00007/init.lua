

style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

pored_style = {["off_color"] = "f90",
               ["on_color"] = "f90",
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

izmedju_style = {["off_color"] = "ff0",
               ["on_color"] = "ff0",
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

mycanvas = function(no)
  lib.start_canvas(450, 350, "center", "result[0] == 0 && result[1] == 0 && result[2] == 0")

  lib.add_rectangle(10, 40, 20, 20, style, false, false)
  lib.add_text(20, 52, "5")
  lib.add_rectangle(10, 90, 20, 20, style, false, false)
  lib.add_rectangle(10, 140, 20, 20, style, false, false)
  lib.add_rectangle(10, 190, 20, 20, style, false, false)
  lib.add_rectangle(10, 240, 20, 20, style, false, false)
  lib.add_rectangle(10, 290, 20, 20, style, false, false)

  lib.add_straight_path(180, 40, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(210, 40, {{20, -10}}, style, "", false)
  lib.add_rectangle(180, 40, 30, 30, style, false, false)
  lib.add_triangle(240, 40, 30, 50, pored_style, false, false)
  lib.add_circle(240, 20, 10, pored_style, false, false) 
  lib.add_text(192, 52, "1")

  lib.add_straight_path(350, 40, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(380, 40, {{20, -10}}, style, "", false)
  lib.add_rectangle(350, 40, 30, 30, style, false, false)
  lib.add_triangle(370, 50, 30, 50, ispred_style, false, false)
  lib.add_circle(370, 30, 10, ispred_style, false, false) 
  lib.add_text(390, 52, "2")

  lib.add_straight_path(190, 170, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(220, 170, {{20, -10}}, style, "", false)
  lib.add_rectangle(190, 170, 30, 30, style, false, false)
  lib.add_triangle(220, 140, 30, 50, iznad_style, false, false)
  lib.add_circle(220, 120, 10, iznad_style, false, false) 
  lib.add_text(208, 182, "3")

  lib.add_straight_path(290, 160, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(320, 160, {{20, -10}}, style, "", false)
  lib.add_rectangle(290, 160, 30, 30, style, false, false)
  lib.add_triangle(350, 160, 30, 50, izmedju_style, false, false)
  lib.add_circle(350, 140, 10, izmedju_style, false, false)
  lib.add_straight_path(360, 160, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(390, 160, {{20, -10}}, style, "", false)
  lib.add_rectangle(360, 160, 30, 30, style, false, false) 
  lib.add_text(380, 178, "4")

  lib.add_triangle(220, 290, 50, 30, ispod_style, false, false)
  lib.add_straight_path(190, 270, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(220, 270, {{20, -10}}, style, "", false)
  lib.add_rectangle(190, 270, 30, 30, style, false, false)
  lib.add_circle(205, 305, 10, ispod_style, false, false) 
  lib.add_text(208, 285, "5")

  lib.add_triangle(380, 270, 30, 50, iza_style, false, false)
  lib.add_circle(380, 250, 10, iza_style, false, false)   
  lib.add_straight_path(350, 280, {{20, -10}, {30, 0}, {0, 30}, {-20, 10}}, style, "", false)
  lib.add_straight_path(380, 280, {{20, -10}}, style, "", false)
  lib.add_rectangle(350, 280, 30, 30, style, false, false)
  lib.add_text(365, 295, "6")

  lib.end_canvas()
end                   
                  