
addition_table = function()
  columns = 5
  min_range = 29
  max_range = 50

  number = {}
  q = {}
  for i=0,columns-1 do
      for j = 1,2 do
          number[j] = min_range - math.random(max_range);
      end
	  if (number[2] == 0) then
          number[2] = - math.random(min_range)
      end		  
      if (number[1] >= 0 and number[2] > 0) then
          ch = math.random(2)
	      number[ch] = -number[ch]
      end
      q[i] = {}
      q[i][1] = number[1] * number[2]
      q[i][2] = number[2]
      q[i][3] = number[1]
      if (q[i][3] == 0) then
		  q[i][4] = 3
      else 			  
         q[i][4] = math.random(3)
      end		  
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "70px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("A", style)
  text = text .. lib.add_cell("B", style)
  text = text .. lib.add_cell("A : B", style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,3 do
      if q[c][4] == r then
        text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
      else
        text = text .. lib.add_cell(tostring(q[c][r]), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
