
style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

point_style = {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"};

marker_style = {["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};			 

mycanvas = function()

  index = {1,2,3,4}
  indup = lib.math.random_shuffle(index)
  inddown = lib.math.random_shuffle(index)

  ind = {1,2,3,4,5,6}
  out = {}
  sign = 0

  results = ""
  for i = 1,3 do
      temp = i - 1
      if (temp > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(temp) .. "] == "		  
      out[i] = {}
      out[i] = lib.math.random_shuffle(ind)
      if (out[i][3] == 7 - out[i][1]) then 
          if (out[i][4] == 7 - out[i][2]) then
  	          if (out[i][6] == 7 - out[i][5]) then
			     results = results .. "1 "
				 sign = 1
			  else
                 results = results .. "0 " 			  
		      end
		   else
                 results = results .. "0 " 		   
           end
	   else	
           results = results .. "0 "	   
       end
  end	

  if (sign == 0) then
      cor = math.random(3)
      out[cor][1] = 4
      out[cor][2] = 5
      out[cor][3] = 3
      out[cor][4] = 2	  
      out[cor][5] = 1
      out[cor][6] = 6	
      results = ""
      for i = 1,3 do
      temp = i - 1
      if (temp > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(temp) .. "] == "		  
      if (i == cor) then 
	      results = results .. "1 "
	  else
          results = results .. "0 " 			  
	  end   
  end	
  
  end 
  
  lib.start_canvas(340, 280, "center", results)

  w = 35
  ow = 10
  v = 5

  for i = 1, 4 do
      lib.add_rectangle (ow+(i-1)*w,  ow+w, w, w, style, false, false) 
  end   
  lib.add_rectangle (ow+(indup[1]-1)*w, ow, w, w, style, false, false)
  lib.add_rectangle (ow+(inddown[1]-1)*w, ow+2*w, w, w, style, false, false)

  for i = 1, 4 do
      lib.add_rectangle (3*ow+4*w+(i-1)*w, 2*ow+3*w, w, w, style, false, false)
  end
  lib.add_rectangle (3*ow+4*w+(indup[2]-1)*w, 2*ow+2*w, w, w, style, false, false)
  lib.add_rectangle (3*ow+4*w+(inddown[2]-1)*w, 2*ow+4*w, w, w, style, false, false)
   
 for i = 1, 4 do
      lib.add_rectangle (ow+(i-1)*w, 3*ow+5*w, w, w, style, false, false)
  end
  lib.add_rectangle (ow+(indup[3]-1)*w, 3*ow+4*w, w, w, style, false, false)	  
  lib.add_rectangle (ow+(inddown[3]-1)*w, 3*ow+6*w, w, w, style, false, false)   


  for j = 1,3 do
      if (j == 1) then
	      a = ow
	      b = ow+w 
      end
	  if (j == 2) then
	      a = 3*ow+4*w
	      b = 2*ow+3*w
      end
	  if (j == 3) then
	      a = ow
	      b = 3*ow+5*w
      end
	  
      for i = 1, 6 do
	      x = a + (i-1)*w
		  y = b
          if (i == 5) then
		      x = a+(indup[j]-1)*w
	          y = b - w
	      end
          if (i == 6) then
		      x = a +(inddown[j]-1)*w
	          y = b + w
	      end
		  
	      if (out[j][i] == 1 or out[j][i] == 3 or out[j][i] == 5) then
              lib.add_circle(x+w/2, y+w/2, 2, point_style, true, false)
	      end
	      if (out[j][i] >= 2) then
             lib.add_circle(x+ow, y+ow-2, 2, point_style, true, false)
             lib.add_circle(x+w-ow, y+w-ow+2, 2, point_style, true, false)		 
	      end	
	      if (out[j][i] > 3) then
             lib.add_circle(x+w-ow, y+ow-2, 2, point_style, true, false)
             lib.add_circle(x+ow, y+w-ow+2, 2, point_style, true, false)		 
	      end	
	      if (out[j][i] == 6 ) then
             lib.add_circle(x+ow, y+w/2, 2, point_style, true, false)
		     lib.add_circle(x+w-ow, y+w/2, 2, point_style, true, false)
	      end		  
      end	  
  end


--[[  markeri  ]]--
  lib.add_circle(2*ow+4*w, 2*ow+w+v, 7, marker_style, false, true) 
  lib.add_circle(v+9*w, 4*w+v, 7, marker_style, false, true)
  lib.add_circle(2*ow+4*w, ow+6*w, 7, marker_style, false, true) 

--[[ crtanje tacaka u kvadratu
x = ow+6*w
y = 2*ow
 lib.add_rectangle (x, y, w, w, style, false, false)

 lib.add_circle(x+ow, y+ow-2, 2, point_style, true, false)
 lib.add_circle(x+w-ow, y+ow-2, 2, point_style, true, false)
 lib.add_circle(x+ow, y+w/2, 2, point_style, true, false)
 lib.add_circle(x+w/2, y+w/2, 2, point_style, true, false)
 lib.add_circle(x+w-ow, y+w/2, 2, point_style, true, false)
 lib.add_circle(x+ow, y+w-ow+2, 2, point_style, true, false)
 lib.add_circle(x+w-ow, y+w-ow+2, 2, point_style, true, false)
]]--

  lib.end_canvas()
end           
       