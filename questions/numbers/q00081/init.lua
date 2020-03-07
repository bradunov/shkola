addition_table = function()
  columns = 8
  min_range = 101
  max_range = 499

  adder = min_range + math.random(max_range - min_range);
  substr = min_range + math.random(adder - min_range);

  q = {}
  for i=0,columns-1 do
    q[i] = {}
    q[i][1] = min_range + math.random(899 - adder)
    q[i][2] = q[i][1] + adder
    q[i][3] = q[i][2] - substr
    q[i][4] = math.random(3)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "70px"

  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("A", style)
  text = text .. lib.add_cell("B=A+" .. tostring(adder), style)
  text = text .. lib.add_cell("C=B-" .. tostring(substr), style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,3 do
      if q[c][4] ~= r then
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

    
    
   
    
    