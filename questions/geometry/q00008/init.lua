
sstyle = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = {["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};

mycanvas = function(no)
  lib.start_canvas(350, 200, "center")

  lib.add_triangle(90, 50, 30, 20, style, true, false)
  lib.add_rectangle(110, 10, 20, 50, style, true)
  lib.add_triangle(150, 50, 30, 20, different_style, true, false)
  lib.add_triangle(190, 50, 30, 20, style, true, false)
  lib.add_rectangle(210, 10, 20, 50, style, true)
  lib.add_triangle(250, 50, 30, 20, different_style, true, false) 

  lib.add_rectangle(10, 110, 20, 50, style, true)
  lib.add_triangle(50, 150, 30, 20, different_style, true, false) 
  lib.add_triangle(85, 150, 30, 20, style, true, false) 
  lib.add_text(53, 175, "1")

  lib.add_triangle(145, 150, 30, 20, different_style, true, false)
  lib.add_triangle(180, 150, 30, 20, style, true, false)
  lib.add_rectangle(200, 110, 20, 50, style, true)
  lib.add_text(173, 175, "2")

  lib.add_triangle(270, 150, 30, 20, style, true, false)
  lib.add_rectangle(290, 110, 20, 50, style, true)
  lib.add_triangle(330, 150, 30, 20, different_style, true, false)
  lib.add_text(298, 175, "3")

  lib.end_canvas()
end

izbor = 3
      
                  