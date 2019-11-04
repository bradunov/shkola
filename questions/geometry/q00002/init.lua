
style = {["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = {["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "00f",
        ["line_width"] = "2"};

mycanvas = function(no)
lib.start_canvas(500, 100, "center", "result[0] == 1 && result[1] == 1 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0")

  lib.add_rectangle(20, 50, 60, 20, style, false, true)
  lib.add_circle(30, 75, 5, style, false, false)
  lib.add_circle(70, 75, 5, style, false, false)
  lib.add_curved_path(40, 50, {{40, -30, 40, 0}}, style, false, false)
  lib.add_straight_path(65, 50, {{0, -15}}, red_line, "", false)
  
  lib.add_rectangle(100, 50, 60, 20, style, false, true)
  lib.add_circle(110, 75, 5, style, false, false)
  lib.add_circle(150, 75, 5, style, false, false)
  lib.add_curved_path(120, 50, {{40, -30, 40, 0}}, style, false, false)
  lib.add_straight_path(145, 50, {{0, -15}}, red_line, "", false)

  lib.add_rectangle(180, 50, 60, 20, different_style, true, true)
  lib.add_circle(190, 75, 5, style, false, false)
  lib.add_circle(230, 75, 5, style, false, false)
  lib.add_curved_path(200, 50, {{40, -30, 40, 0}}, style, false, false)
  lib.add_straight_path(225, 50, {{0, -15}}, red_line, "", false)

  lib.add_rectangle(260, 50, 60, 20, style, false, true)
  lib.add_circle(270, 75, 5, style, false, false)
  lib.add_circle(310, 75, 5, style, false, false)
  lib.add_curved_path(280, 50, {{40, -30, 40, 0}}, style, false, false)
  lib.add_straight_path(305, 50, {{0, -15}}, red_line, "", false)

  lib.add_rectangle(340, 50, 60, 20, style, false, true)
  lib.add_circle(350, 75, 5, style, false, false)
  lib.add_circle(390, 75, 5, style, false, false)
  lib.add_curved_path(360, 50, {{40, -30, 40, 0}}, style, false, false)
  lib.add_straight_path(385, 50, {{0, -15}}, red_line, "", false)

  lib.add_rectangle(420, 50, 60, 20, style, false, true)
  lib.add_circle(430, 75, 5, style, false, false)
  lib.add_circle(470, 75, 5, style, false, false)
  lib.add_curved_path(440, 50, {{40, -30, 40, 0}}, style, false, false)
  lib.add_straight_path(465, 50, {{0, -15}}, red_line, "", false)

  lib.end_canvas()
end
 
  