
sstyle = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = {["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};

mycanvas = function(no)
  lib.start_canvas(450, 280, "center")

  lib.add_triangle(20, 150, 30, 20, style, true, false)
  lib.add_rectangle(40, 110, 20, 50, style, true)
  lib.add_triangle(80, 150, 30, 20, different_style, true, false)
  lib.add_triangle(120, 150, 30, 20, style, true, false)
  lib.add_rectangle(140, 110, 20, 50, style, true)
  lib.add_triangle(180, 150, 30, 20, different_style, true, false) 

  lib.add_rectangle(305, 10, 20, 50, style, true)
  lib.add_triangle(345, 50, 30, 20, different_style, true, false) 
  lib.add_triangle(380, 50, 30, 20, style, true, false) 

  lib.add_triangle(320, 150, 30, 20, different_style, true, false)
  lib.add_triangle(355, 150, 30, 20, style, true, false)
  lib.add_rectangle(375, 110, 20, 50, style, true)

  lib.add_triangle(320, 250, 30, 20, style, true, false)
  lib.add_rectangle(340, 210, 20, 50, style, true)
  lib.add_triangle(380, 250, 30, 20, different_style, true, false)

  lib.end_canvas()
end

izbor = 3
                  
                  
                  