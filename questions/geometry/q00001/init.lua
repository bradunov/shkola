include("terms")

style = {["off_color"] = "fff",
         ["on_color"] = "f30",
         ["line_color"] = "000",
         ["line_width"] = "2"};


ind = math.random(3)

w = 10
ow = 20

mycanvas = function()

 results = ""
  
  for i = 1,5 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if ( i == 2*ind - 1 ) then
          results = results .. "1 "
	  else
          results = results .. "0 " 
      end		  
  end		  
		 		  
  lib.start_canvas( 260, 130, "center", results)
  
  lib.add_rectangle(w, 5*w, ow, 2*ow, style, false, false)
  lib.add_triangle(2*w, 4*w, 3*ow/2, ow, style, false, true)

  lib.add_rectangle(6*w, 5*w, ow, 2*ow, style, false, false)
  lib.add_triangle(7*w, 4*w, 3*ow/2, ow, style, false, true)

  lib.add_rectangle(11*w, 5*w, ow, 2*ow, style, false, false)
  lib.add_triangle(12*w, 4*w, 3*ow/2, ow, style, false, true)

  lib.add_rectangle(16*w, 5*w, ow, 2*ow, style, false, false)
  lib.add_triangle(17*w, 4*w, 3*ow/2, ow, style, false, true)
  
  lib.add_rectangle(21*w, 5*w, ow, 2*ow, style, false, false)
  lib.add_triangle(22*w, 4*w, 3*ow/2, ow, style, false, true)

  lib.end_canvas()
end


