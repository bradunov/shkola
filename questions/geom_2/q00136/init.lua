
meas = {"r (cm)", "2r (cm)", "O (cm)"} 

addition_table = function()

  columns = 6

  q = {}
  for i=0,columns-1 do
    q[i] = {}
    q[i][1] = 22 + math.random(77)
	q[i][2] = 2 * q[i][1]
    q[i][3] = q[i][2] * 22 / 7	
	for j = 1,3 do
	    q[i][j] = lib.math.round_dec(q[i][j] / 10, 1)
    end	    
    q[i][4] = math.random(3)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "70px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(meas[1], style)
  text = text .. lib.add_cell(meas[2], style)
  text = text .. lib.add_cell(meas[3], style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,3 do
      if q[c][4] ~= r then
        text = text .. lib.add_cell(lib.check_number(q[c][r],35), style)
      else
        text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
            