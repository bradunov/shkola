
include("terms")

style = {["off_color"] = "fff",
         ["on_color"] = "f30",
         ["line_color"] = "000",
         ["line_width"] = "2"};

yelow_style = {["off_color"] = "ff0",
               ["on_color"] = "ff0",
               ["line_color"] = "000",
               ["line_width"] = "2"};

green_style = {["off_color"] = "6f6",
                ["on_color"] = "6f6",
                ["line_color"] = "000",
                ["line_width"] = "2"};

blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "2"};

brown_style = {["off_color"] = "c60",
               ["on_color"] = "c60",
               ["line_color"] = "000",
               ["line_width"] = "2"};			  		   
			   
pink_style = {["off_color"] = "f9c",
                ["on_color"] = "f9c",
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
  
  lib.add_rectangle(w, 5*w, ow, 2*ow, blue_style, true, false)
  lib.add_triangle(2*w, 4*w, 3*ow/2, ow, style, false, true)

  lib.add_rectangle(6*w, 5*w, ow, 2*ow, yelow_style, true, false)
  lib.add_triangle(7*w, 4*w, 3*ow/2, ow, style, false, true)

  lib.add_rectangle(11*w, 5*w, ow, 2*ow, pink_style, true, false)
  lib.add_triangle(12*w, 4*w, 3*ow/2, ow, style, false, true)

  lib.add_rectangle(16*w, 5*w, ow, 2*ow, green_style, true, false)
  lib.add_triangle(17*w, 4*w, 3*ow/2, ow, style, false, true)
  
  lib.add_rectangle(21*w, 5*w, ow, 2*ow, brown_style, true, false)
  lib.add_triangle(22*w, 4*w, 3*ow/2, ow, style, false, true)

  lib.end_canvas()
end


