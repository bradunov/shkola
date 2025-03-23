
measure = {"d₁ cm", "d₂ cm", "a cm", "h cm", "O cm", "P \( \ \) cm²"} 
                                                                                                                                                                                                                                                                                                                                                                                                
addition_table = function()

  columns = 5
  max_range = 7  

  q = {}
  for i=0,columns-1 do
	q[i] = {}
	q[i][1] =  2 + math.random(max_range)                     --[[d1]]--
	q[i][2] =  q[i][1] + math.random(max_range)               --[[d2]]--
	q[i][3] = 0.5 * math.sqrt(q[i][1]^2 + q[i][2]^2)          --[[a]]--	
    q[i][5] = 4 * q[i][3]                                     --[[O]]--	
    q[i][6] = 0.5 * q[i][1] * q[i][2]                         --[[P]]--
    q[i][4]	= q[i][6] / q[i][3]
	q[i][4]	= lib.math.round_dec(q[i][4],1)         --[[h]]--
    q[i][7] = math.random(2)		
    q[i][8] = 2 + math.random(4)
	if (q[i][8] == 4) then
	    q[i][8] = 3 - q[i][7]
	end	
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
      if (q[c][7] == r or q[c][8] == r) then
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
       
        