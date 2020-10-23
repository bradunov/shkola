
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


ind = math.random(6)
v = 5
w = 10
ow = 20
ov = 50

mycanvas = function()

 results = ""   
  
 for i = 1,5 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if ( i == ind ) then
          results = results .. "1 "
	  else
	      if (i == 5 and ind == 6) then
		     results = results .. "1 "
		  else
             results = results .. "0 " 
		  end	 
      end		  
  end		  
		 		  
  lib.start_canvas( 350, 350, "center", results)
  
  lib.add_rectangle(2*w, 5*w, 2*ow, 8*ow+w, brown_style, true, false)
  lib.add_triangle(4*w, 3*w, ov, 2*ow, style, false, true)

  lib.add_rectangle(4*w, 27*w, 9*ow, 3*ow, green_style, true, false)
  lib.add_triangle(13*w, 5*ov+v, 4*ov-w, ow+w, style, false, true)

  lib.add_rectangle(27*w, 25*w, ow, 4*ow, pink_style, true, false)
  lib.add_triangle(28*w, 24*w, ow+w, ow+w, style, false, true)
  
  lib.add_rectangle(18*w, 6*w, 7*ow, 7*ow, yelow_style, true, false)
  lib.add_triangle(25*w, 4*w, 3*ov, 2*ow, style, false, true)

  lib.add_rectangle(11*w, 13*w, ow+w, ow+w, blue_style, true, false)
  lib.add_triangle(6*ow+v, 6*ow+v, 2*ow, ow, style, false, true)

  lib.end_canvas()
end


