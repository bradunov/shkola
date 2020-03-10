addition_table = function()
  columns = 8


  factor = math.random(5) + 3;
  devide = math.random(7) + 6;

  if (devide == factor) then
      factor = factor - 1
  end

  q = {}
  for i=0,columns-1 do
    q[i] = {}
	term = math.random(9)
    q[i][1] = devide * term
    q[i][2] = q[i][1] * factor
    q[i][3] = factor * term
    q[i][4] = math.random(3)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "70px"

  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("A", style)
  text = text .. lib.add_cell("B = A &middot; " .. tostring(factor) , style)
  text = text .. lib.add_cell("C = B : " .. tostring(devide) , style)
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

      
    
   
    
    