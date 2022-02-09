
addition_table = function()

  measure = {"a  \( \ \) cm", "b  \( \ \) cm", "t\(\small_c\)  \( \ \)cm",  "h\(\small_c\)  \( \ \)cm", "O  \( \ \)cm", "P \( \ \ \) cm\(^2\)"} 

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
	ch = math.random(2)
	if (ch == 2) then
	    tmp = q[i][2]
		q[i][2] = q[i][1]
		q[i][1] = tmp
	end	
	fct = math.random(4)
    circ = 0	
	for j = 1,3 do
	    q[i][j] = q[i][j] * fct
		circ = circ + q[i][j]
	end	
    q[i][6] = q[i][1] * q[i][2]
	q[i][4]	= lib.math.round_dec(q[i][6] / q[i][3],1)
    q[i][3] = lib.math.round_dec(0.5 * q[i][3],1)	
    q[i][5] = circ	
    q[i][6] = 0.5 * q[i][6]		
    q[i][7] = math.random(3)
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
      if (r < 4 and q[c][7] ~= r) then
          text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)
      else 
          text = text .. lib.add_cell(lib.check_number(q[c][r],30), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end  