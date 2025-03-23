
meas = {"n", "u", "t", "d", "s°"} 

addition_table = function()

  columns = 5

  q = {}
  for i=0,columns-1 do
    q[i] = {}
    q[i][1] = 2 + math.random(15)
	q[i][2] = q[i][1]
    q[i][3] = q[i][1]
    q[i][4] = math.floor(0.5 * q[i][1] * (q[i][1]  - 3))
    q[i][5] = (q[i][1] - 2) * 180	
    q[i][6] = math.random(5)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "50px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(meas[1], style)
  text = text .. lib.add_cell(meas[2], style)
  text = text .. lib.add_cell(meas[3], style)
  text = text .. lib.add_cell(meas[4], style)
  text = text .. lib.add_cell(meas[5], style)  
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,5 do
      if q[c][6] ~= r then
        text = text .. lib.add_cell(lib.check_number(q[c][r],35), style)
      else
        text = text .. lib.add_cell(tostring(q[c][r]), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end