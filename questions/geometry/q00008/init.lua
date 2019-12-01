

sstyle = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = {["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};

mycanvas = function(no)
  lib.start_canvas(400, 300, "center")

  lib.add_triangle(20, 150, 30, 20, style, true, false)
  lib.add_rectangle(40, 110, 20, 50, style, true)
  lib.add_triangle(80, 150, 30, 20, different_style, true, false)
  lib.add_triangle(120, 150, 30, 20, style, true, false)
  lib.add_rectangle(140, 110, 20, 50, style, true)
  lib.add_triangle(180, 150, 30, 20, different_style, true, false) 

  lib.add_rectangle(260, 10, 20, 50, style, true)
  lib.add_triangle(300, 50, 30, 20, different_style, true, false) 
  lib.add_triangle(335, 50, 30, 20, style, true, false) 
  lib.add_text(303, 75, "1")

  lib.add_triangle(275, 150, 30, 20, different_style, true, false)
  lib.add_triangle(310, 150, 30, 20, style, true, false)
  lib.add_rectangle(330, 110, 20, 50, style, true)
  lib.add_text(303, 175, "2")

  lib.add_triangle(275, 250, 30, 20, style, true, false)
  lib.add_rectangle(295, 210, 20, 50, style, true)
  lib.add_triangle(335, 250, 30, 20, different_style, true, false)
  lib.add_text(303, 275, "3")

  lib.end_canvas()
end

izbor = 3
                  
                  