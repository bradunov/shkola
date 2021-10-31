
include("terms")

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
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

text_style = {["font_size"] = "12"}


row = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"}

numb_r = {}
numb_s = {}
side = {}
seat = {}

for i = 1,2 do 
    side[i] = math.random(2)
    numb_r[i] = math.random(9)
    numb_s[i] = math.random(7)
end

if (side[1] == side[2] and numb_r[1] == numb_r[2] and numb_s[1] == numb_s[2]) then
    side[1] = 2 
	side[2] = 1
end	

numb_seat = 2 * 9 * 7
for k = 1,2 do
    if (side[k] == 1) then 
        seat[k] = (numb_r[k] - 1) * 7 + 8 - numb_s[k]
	else
        seat[k] = 63 + (numb_r[k] - 1) * 7 + numb_s[k]
    end	
end	



  results = "" 
  for i = 1,numb_seat do 
      ind = i - 1
      if (ind > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(ind) .. "] == "
      if (i == seat[1]  or i == seat[2]) then		      		  
          results = results .. "1 "
      else
          results = results .. "0 "
      end
  end

  mycanvas = function()

  lib.start_canvas(350, 300, "center", results)

  w = 20
  ow = 90
  v = 190
  ov = 5

  for j = 1,9 do
      y = ow + j*w
      for i = 1,7 do
          x = ov + i*w
         lib.add_rectangle(x, y, w, w, check_style, false, true)
      end
  end

  for j = 1,9 do
      y = ow + j*w
      for i = 1,7 do
          x = v + (i-1)*w
         lib.add_rectangle(x, y, w, w, check_style, false, true)
      end
  end  

  for i = 1,10 do
    lib.add_line(w+ov, ow+i*w, 7*w, 0, style, false, false)
  end
  for i = 1,8 do
    lib.add_line(ov+i*w, ow+w, 0, 9*w, style, false, false)
  end
  
  for i = 1,10 do
    lib.add_line(v, ow+i*w, 7*w, 0, style, false, false)
  end
  for i = 1,8 do
    lib.add_line(v+(i-1)*w, ow+w, 0, 9*w, style, false, false)
  end
    
  for j = 1,9 do
      lib.add_text(2*ov, ow+j*w+10, row[j], text_style)
      for i = 1,7 do
    	      temp = 8 - i
              text = tostring(temp)
              lib.add_text(ov+i*w+11, ow+j*w+10, text, text_style)
	  end	  
  end 
  
  for j = 1,9 do
      for i = 1,7 do
    	      temp = i
              text = tostring(temp)
              lib.add_text(v+(i-1)*w+11, ow+j*w+10, text, text_style)
	  end	  
  end 

  lib.add_rectangle (w+2*ov, w, ow+w+ov, 2*w+ov, style, false, false)
  lib.add_text(2*(w+ov), w+2*ov, position[1], text_style)
  lib.add_text(5*w, w+2*ov, position[1+side[1]], text_style)  
  lib.add_text(2*w+ov, 2*(w+ov), position[6], text_style)
  lib.add_text(3*w+3, 2*(w+ov), numb_r[1], text_style) 
  lib.add_text(5*w+ov, 2*(w+ov), position[7], text_style)  
  lib.add_text(7*w-ov+2, 2*(w+ov), numb_s[1], text_style) 
				
  lib.add_rectangle (v+2*ov, w, ow+w+ov, 2*w+ov, style, false, false)
  lib.add_text(v+2*(w-ov), w+2*ov, position[1], text_style)
  lib.add_text(v+4*w, w+2*ov, position[1+side[2]], text_style)  
  lib.add_text(v+w+ov, 2*(w+ov), position[6], text_style)
  lib.add_text(v+ov+2*w, 2*(w+ov), numb_r[2], text_style) 
  lib.add_text(v+ov+4*w, 2*(w+ov), position[7], text_style)  
  lib.add_text(v+6*w-3, 2*(w+ov), numb_s[2], text_style)

  lib.add_text(3*w, 5*w-ov, position[4], text_style)  
  lib.add_text(v+5*w, 5*w-ov, position[5], text_style)

  lib.end_canvas()
end