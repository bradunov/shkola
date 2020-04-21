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

position = {"drugi", "peti", "deseti", "treći", "četvrti", "šesti", "sedmi", "osmi", "deveti"}
numb_position = {2, 5, 10, 3, 4, 6, 7, 8, 9}

choice = math.random(9)
place = position[choice]

answ = {} 


mycanvas = function()

  results = ""
  for j = 1,10 do  
      for i = 1,10 do
	      index = (j-1)*10 + i
		  ind = index - 1
		  answ[index] = lib.math.gcd(index,numb_position[choice])
          if (ind > 0) then
              results = results .. "&& "
          end
          results = results .. "result[" .. tostring(ind) .. "] == "
          if (answ[index] == numb_position[choice]) then
              results = results .. "1 "
          else
              results = results .. "0 "
          end
	   end	  
  end


  lib.start_canvas(350, 350, "center", results)

  w = 30
  ow = 10


  example_set = false
  for j = 1,10 do
    for i = 1,10 do
      index = (j-1)*10 + i
      x = ow+(i-1)*w
      y = ow+(j-1)*w
      if (answ[index] == numb_position[choice] and not example_set) then
        example_set = true
        lib.add_rectangle(x, y, w, w, check_style, true, true)
      else
        lib.add_rectangle(x, y, w, w, check_style, false, true)
      end
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
              lib.add_text(ow+(i-1)*w+15, ow+(j-1)*w+15, text, text_style)
	  end	  
  end 

  lib.end_canvas()
end
         
                