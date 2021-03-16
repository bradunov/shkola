
include("terms")
                                                                                                                                                                                                                                                                                                               
style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};

diff_style = 
	{["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "1"};

dot_style = {["font_size"] = "35"}	
text_style = {["font_size"] = "16"}
  ind = math.random(2)
				
mycanvas = function()



  results = ""
  
  for i = 1,4 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if (i < 3) then
	      if ( ind == 1 ) then
             results = results .. "0 "
	      else
             results = results .. "1 " 
          end
      else		  			  
	      if (ind == 1) then
		      results = results .. "1 "
		  else	  
              results = results .. "0 " 
		  end	  
      end		  
  end		  

  lib.start_canvas(300, 300, "center", results)

  w = 80
  ow = 25
  v = 10

  lib.add_circle (2*ow+w, 2*w, w, diff_style, false, false )

  lib.add_line(3*ow-6, 4*ow-6, 2*w, -2*ow, style, false, true)
  lib.add_line(ow, ow, w/2, 3*w, style, false, true)
  lib.add_line(3*w-ow-7, 2*w-v-3, -w-v, w+v, style, false, true) 
  lib.add_line(2*ow+v, w+ow+v-2, 2*w-ow, 2*(w-ow-v)+2, style, false, true)  
  
     lib.add_text(4*ow+v, 3*ow-3, ".", dot_style, false, false)	
     lib.add_text(4*ow+v, 3*ow-7, "M", text_style)
	 
     lib.add_text(2*ow, 2*w, ".", dot_style, false, false)	
     lib.add_text(w/2-5, 2*w+5, "R", text_style)
 
     lib.add_line(3*w, 3*w/2-5, -ow-v+3, ow+v-3, style, false, false)
     lib.add_line(3*w/2-2, 3*w-3, -ow, ow, style, false, false)
     lib.add_text(5*w/2+8, 2*w-ow+3, ".", dot_style, false, false)	
     lib.add_text(3*w-ow+5, 2*w-5, "N", text_style) 
     lib.add_text(2*w-ow-2*v, 3*w-ow+v+4, ".", dot_style, false, false)	
     lib.add_text(3*w/2, 3*w+v, "Q", text_style)

     lib.add_line(ow, w+7, ow+v+3, ow+v-7, style, false, false)
     lib.add_line(2*w+ow+v, 3*w-ow-v, w-ow, w-2*ow+7, style, false, false)
     lib.add_text(2*ow+v+4, w+ow+2, ".", dot_style, false, false)	
     lib.add_text(3*ow+v-5, w+ow+v-2, "S", text_style) 
     lib.add_text(2*w+ow+v, 3*w-2*ow+5, ".", dot_style, false, false)	
     lib.add_text(2*(w+ow), 3*w-2*ow+v, "P", text_style)   	

     lib.add_text(2*ow+w, 2*w-9, ".", dot_style, false, false)	
     lib.add_text(2*ow+w+v, 2*w-6, "O", text_style)  	 

  lib.end_canvas()
  
end              
