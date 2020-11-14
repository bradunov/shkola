
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
			
check_style = 
	{["off_color"] = "fff",
        ["on_color"] = "ff00ff",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

text_style = {["font_size"] = "14"}

prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 51, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
dim = 26


mycanvas = function()

  results = "result[0] == 0 "
  kmin = 2
  for j = 1,10 do  
      if (j == 1) then
          imin = 3
	  else
          imin = 1	  
      end	  
      for i = imin,10 do
	      index = (j-1)*10 + i
		  ind = index - 2 
		  temp = 1
          for k = kmin,dim do
              if (index == prime[k]) then
                  temp = 0
			      kmin = k + 1
			      if (kmin > dim) then
			          kmin = 1
			      end	  
			  end
          end
		  if (temp == 0) then
		      results = results .. "&& " .. "result[" .. tostring(ind) .. "] == 0 "		
          else
		      results = results .. "&& " .. "result[" .. tostring(ind) .. "] == 1 "		
          end			  
	   end	  
  end


  lib.start_canvas(340, 310, "center", results)

  w = 30
  ow = 10

  lib.add_rectangle(ow, ow, w, w, check_style, true, false)
  kmin = 2
  for j = 1,10 do
      if (j == 1) then
          imin = 2
	  else
          imin = 1	  
      end	   
      for i = imin,10 do
          index = (j-1)*10 + i
          x = ow+(i-1)*w
          y = ow+(j-1)*w
          lib.add_rectangle(x, y, w, w, check_style, false, true)		  
		  	  
	  end	  
  end

  for i = 1,11 do
    lib.add_line(ow, ow+(i-1)*w, 10*w, 0, style, false, false)
    lib.add_line(ow+(i-1)*w, ow, 0, 10*w, style, false, false)
  end

  for j = 1,10 do
      for i = 1,10 do
    	      temp = (j-1)*10 + i
              text = tostring(temp)
			  if (j*i ~= 1) then
              lib.add_text(ow+(i-1)*w+15, ow+(j-1)*w+15, text, text_style)
			  end
	  end	  
  end 

  lib.end_canvas()
end
        
         