
addition_table = function()

  measure = {"a  \( \ \ \ \) cm", "c  \( \ \ \ \) cm", "h\(\small_c \ \ \ \)cm",  "r  \( \ \ \ \)cm", "O  \( \ \ \ \)cm", "P \( \ \ \ \) cm\(^2\)"} 
 
  r2 = lib.math.round_dec(math.sqrt(2),3)
 
  columns = 5

  q = {}
  for i=0,columns-1 do
	q[i] = {}
	q[i][1] = 2 + math.random(17)
	q[i][2] = q[i][1] * r2
	q[i][3] = q[i][1] / r2	
	tmp = 2 + r2	
	q[i][4]	= q[i][1] / tmp	
    q[i][5] = q[i][1] * tmp
    q[i][6] = 0.5 * q[i][1] * q[i][1]	
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