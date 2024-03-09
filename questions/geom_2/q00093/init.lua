
addition_table = function()

  hc = "h\(\small_c\)"
  measure = {"a  \( \ \) cm", "b  \( \ \) cm", "c  \( \ \) cm",  "h\(\small_c\)  \( \ \)cm", "r  \( \ \) cm", "O  \( \ \)cm", "P \( \ \ \) cm\(^2\)"} 

ea = {3, 5, 8, 7}
eb = {4, 12, 15, 24}
ec = {5, 13, 17, 25}

  columns = 5
  min_range = 5
  max_range = 29

  q = {}
  for i=0,columns-1 do
    fct = math.random(9)
	ch = math.random(4)
	edge1 = fct * ea[ch]
	edge2 = fct * eb[ch]
	edge3 = fct * ec[ch]
        circ = edge1 + edge2 + edge3
	area = edge1 * edge2 / 2 	
    heig = lib.math.round_dec(2*area / edge3, 2)
    rads =  lib.math.round_dec(2 * area / circ, 2)	
    q[i] = {}
    q[i][1] = edge1
	q[i][2] = edge2
    q[i][3] = edge3
    q[i][4] = heig
    q[i][5] = rads
    q[i][6] = circ	
    q[i][7] = area		
    q[i][8] = 3 + math.random(4)
    q[i][9] = 2 + math.random(q[i][8]-3)
    q[i][10] = math.random(2)
	
    if (q[i][9] == 4 and q[i][8] == 6) then
	    q[i][9] = 3
    end	
    if (q[i][9] == 3 and q[i][8] == 5) then
	    q[i][8] = 6
    end		
    if (q[i][9] == 4 and q[i][8] == 5) then
	    q[i][9] = 3
	    q[i][8] = 6
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
  text = text .. lib.add_cell(measure[7], style)   
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,7 do
      if (q[c][8] == r or q[c][9] == r or q[c][10] == r) then
          text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)
      else 
          tmp = lib.math.round_dec(q[c][r], 1)
          text = text .. lib.add_cell(lib.check_number(tmp,30), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end  
    
    
    
    
                  
         