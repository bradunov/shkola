
addition_table = function()

  measure = {"a  \( \ \ \ \) cm", "d  \( \ \ \ \) cm", "R  \( \ \ \ \)cm",  "r  \( \ \ \ \)cm", "O  \( \ \ \ \)cm", "P \( \ \ \) cm²"} 
 
  r2 = math.sqrt (2)
 
  columns = 5
  max_range = 25

  q = {}
  for i=0,columns-1 do
	q[i] = {}
	q[i][1] = 6 + math.random(max_range)
	q[i][2] = q[i][1] * r2
	q[i][3] = 0.5 * q[i][2]	
	q[i][4]	= 0.5 * q[i][1]	
    q[i][5] = 4 * q[i][1]
    q[i][6] = q[i][1] * q[i][1]	
    q[i][2] = lib.math.round_dec(q[i][2],2)	
    q[i][3] = lib.math.round_dec(q[i][3],2)		
    q[i][7] = math.random(6)
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
      if (q[c][7] == r) then
          text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)
      else 
          text = text .. lib.add_cell(lib.check_number(q[c][r],35), style)  
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end 
           