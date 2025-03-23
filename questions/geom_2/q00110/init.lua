
addition_table = function()

    measure = {"a  \( \ \) cm", "b  \( \ \) cm", "d  \( \ \ \)cm",  "R  \( \ \ \)cm", "O  \( \ \)cm", "P \( \ \ \) cm²"} 

  columns = 5
  max_range = 5

  q = {}
  for i=0,columns-1 do
	q[i] = {}
    numb2 = 2 + math.random(max_range)
    numb1 = math.random(numb2 - 1)
	q[i][1] = numb2^2 - numb1^2
	q[i][2] = 2 * numb1 * numb2
	q[i][3] = numb2^2 + numb1^2	
	fct = math.random(4)	
	for j = 1,3 do
	    q[i][j] = q[i][j] * fct
	end	
	q[i][4]	= lib.math.round_dec(0.5 * q[i][3],1)
    q[i][5] = 2 * (q[i][1] + q[i][2])
    q[i][6] = q[i][1] * q[i][2]	
    q[i][7] = math.random(2)
    q[i][8] = 2 + math.random(2)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "50px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(measure[1], style)
  text = text .. lib.add_cell(measure[2], style)
  text = text .. lib.add_cell(measure[3], style)
  text = text .. lib.add_cell(measure[4], style)
  text = text .. lib.add_cell(measure[5], style)  
  text = text .. lib.add_cell(measure[6], style)  
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,6 do
      if (r < 3 and q[c][7] ~= r) then
          text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)
      else 
	      if (r > 2 and r < 5 and q[c][8] ~= r) then
              text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)
		  else	  
              text = text .. lib.add_cell(lib.check_number(q[c][r],30), style)
		  end	  
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end  
            
