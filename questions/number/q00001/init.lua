

mycanvas = function(no)
  lib.start_canvas(500, 300, "center", "result[0] == 0 && result[1] == 1 && result[2] == 0")
  lib.add_ellipse(250, 150, 230, 140, "fff", "aff", "", false)
  lib.add_rectangle(200, 50, 20, 50)
  lib.add_triangle(150, 150, 20, 50, "fff", "faf")
  lib.add_circle(250, 250, 20)
  lib.end_canvas()
end

