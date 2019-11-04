
style = {["off_color"] = "fff",
         ["on_color"] = "6f6",
         ["line_color"] = "000",
         ["line_width"] = "2"};

mycanvas = function(no)
  lib.start_canvas( 260, 220, "center", "result[0] == 1 && result[1] == 0 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 1 && result[6] == 0 && result[7] == 0")


  lib.add_rectangle(170, 130, 20, 20, style, false, true) 
  lib.add_rectangle(190, 110, 20, 50, style, false, true)

  lib.add_rectangle(110, 40, 60, 60, style, false, true)
  lib.add_rectangle(100, 30, 75, 15, style, false, true)
  
  lib.add_triangle(55, 55, 40, 30, style, false, true)
  lib.add_rectangle(40, 70, 30, 30, style, false, true)

  lib.add_circle(45, 170, 15, style, false, true)
  lib.add_circle(120, 170, 15, style, false, true)
  lib.add_circle(155, 170, 15, style, false, true)

  lib.add_rectangle(20, 100, 150, 60, style, false, true)

  lib.end_canvas()
end

      
                  
                  
                  
                  
                  
                  
                  
                  
                  
       

