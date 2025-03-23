
meas = {"r (cm)", "φ (°)", "α (°)", "l (cm)", "P (cm²)"} 

pi = 22 / 7

part = {4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 30, 36, 40, 45}
dim = 16
           

addition_table = function()

  columns = 5

  q = {}
  for i=0,columns-1 do 
      q[i] = {} 
      ind = math.random(dim)
	  q[i][1] = 10 + math.random(39) 
      q[i][3] = lib.math.round_dec(360 / part[ind], 2)
	  q[i][2] = 2 * q[i][3]	 	  
      q[i][4] = pi * q[i][1] * q[i][2] / 180
      q[i][5] = 0.5 * q[i][1] * q[i][4]
	  for j = 4,5 do
	      q[i][j] = lib.math.round_dec(q[i][j], 3)
      end	
      q[i][6] = 1 + math.random(2)	  
      q[i][7] = 2 + math.random(3)
	  if (q[i][7] == 3) then
	      q[i][7] = 1
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
  text = text .. lib.add_cell(meas[5], style) 
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,5 do
	  if (r == 2 or r == 3) then	  
		  if q[c][6] ~= r then
		  	q[c][r] = lib.math.round_dec(q[c][r], 1)
			text = text .. lib.add_cell(lib.check_number(q[c][r],30), style)
		  else
			text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)
		  end
      else
		  if q[c][7] ~= r then
		    q[c][r] = lib.math.round_dec(q[c][r], 1)
			text = text .. lib.add_cell(lib.check_number(q[c][r],35), style)
		  else
			text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)
		  end
      end		  
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
   