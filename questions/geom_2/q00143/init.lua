
meas = {"r (cm)", "2r (cm)", "O (cm)", "P (cm\(\small^2\))"} 

addition_table = function()

  columns = 6

  q = {}
  for i=0,columns-1 do
    q[i] = {}
    q[i][1] = 22 + math.random(77)
	q[i][2] = 2 * q[i][1]
    q[i][3] = q[i][2] * 22 / 7	
    q[i][4] = q[i][1] * q[i][1] * 22 / 70
    q[i][5] = math.random(4)	
	for j = 1,4 do
	    if (j == q[i][5]) then
	        q[i][j] = lib.math.round_dec(q[i][j] / 10, 3)
		else
	        q[i][j] = lib.math.round_dec(q[i][j] / 10, 1)
        end			
    end	    

  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "60px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(meas[1], style)
  text = text .. lib.add_cell(meas[2], style)
  text = text .. lib.add_cell(meas[3], style)
  text = text .. lib.add_cell(meas[4], style)  
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,4 do
      if q[c][5] ~= r then
        text = text .. lib.add_cell(lib.check_number(q[c][r],40), style)
      else
        text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
              