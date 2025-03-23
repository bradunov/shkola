
addition_table = function()

  measure = {"a  \( \ \ \ \) cm", "h  \( \ \ \ \) cm", "R  \( \ \ \ \)cm",  "r  \( \ \ \ \)cm", "O  \( \ \ \ \)cm", "P \( \ \ \ \) cm²"} 
 
  r3 = lib.math.round_dec(math.sqrt(3),3)
 
  columns = 5

  q = {}
  for i=0,columns-1 do
	q[i] = {}
	q[i][1] = 2 + math.random(17)
	tmp = q[i][1] * r3
	q[i][2] = 0.5 * tmp
	q[i][3] = tmp / 3	
	q[i][4]	= tmp / 6	
    q[i][5] = 3 * q[i][1]
    q[i][6] = 0.25 * q[i][1] * tmp	
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
	      out = lib.math.round_dec(q[c][r],3)
          text = text .. lib.add_cell(lib.dec_to_str(out), style)
      else 
	      out = lib.math.round_dec(q[c][r],1)
          if (r == 6) then 
              nr = 35
          else
              nr = 30
          end			  
          text = text .. lib.add_cell(lib.check_number(out,nr), style)  
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end   
      