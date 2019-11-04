
style = {["off_color"] = "fff",
         ["on_color"] = "f30",
         ["line_color"] = "000",
         ["line_width"] = "2"};

mycanvas = function(no)
  lib.start_canvas(260, 130, "center", "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 0 && result[5] == 1 && result[6] == 0 && result[7] == 0")

  lib.add_rectangle(20, 50, 30, 40, style, false, true)
  lib.add_triangle(35, 40, 40, 20, style, false, true)

  lib.add_rectangle(85, 50, 30, 40, style, false, true)
  lib.add_triangle(100, 40, 40, 20, style, false, true)

  lib.add_rectangle(150, 50, 30, 40, style, false, true)
  lib.add_triangle(165, 40, 40, 20, style, false, true)

  lib.add_rectangle(215, 50, 30, 40, style, false, true)
  lib.add_triangle(230, 40, 40, 20, style, false, true)

  lib.end_canvas()
end

                  
                  
                  
                  
                  
                  
                  
                  
                  
       

