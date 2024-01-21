
include("terms")

style = {["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = {["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "00f",
        ["line_width"] = "2"};

ind = math.random(4)

mycanvas = function()

 results = ""
  
  for i = 1,5 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if (i < 4) then
	      if ( ind == i ) then
             results = results .. "1 "
	      else
             results = results .. "0 " 
          end
      else		  
	      if (i == 4) then 	
              results = results .. "0 " 	
          else			  
	          if (ind == i-1) then
		          results = results .. "1 "
		      else	  
                  results = results .. "0 " 
		      end
          end			  
      end		  
  end		  


lib.start_canvas(400, 100, "center", results)

  ow = 15
  w = ow/2
  ov = 20
  v = 10
  dm = 15
  dm4 = dm/4
  
  q = 1  
  for i = 1,6 do  
      if (i == 3) then
          lib.add_rectangle(q*ow-v, 2*ov+v, 3*dm, dm, different_style, false, false)
      else
          lib.add_rectangle(q*ow-v, 2*ov+v, 3*dm, dm, style, false, true)
      end 	    	  
      lib.add_circle(q*ow+w-v, 4*ov-v, dm4, style, false, false)
      lib.add_circle((q+2)*ow+w-v, 4*ov-v, dm4, style, false, false)
      lib.add_curved_path((q+1)*ow-v, 2*ov+v, {{2*dm, -2*(dm-dm4), 2*dm, 0}}, style, false, false)
      lib.add_straight_path((q+2)*ow-v+5, 2*ov+v, {{0, -3*dm4}}, red_line, "", false)
      q = q + 4
  end

  lib.end_canvas()
end
      
 
 
                  