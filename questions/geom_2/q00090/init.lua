
addition_table = function()

  ha = "h\(\small_a\)"
  hb = "h\(\small_b\)"
  measure = {"a  \( \ \) cm", "b  \( \ \) cm", "h\(\small_a\)  \( \ \)cm",  "h\(\small_b\)  \( \ \)cm", "O  \( \ \)cm", "P \( \ \ \) cm²"} 

  columns = 5
  min_range = 5
  max_range = 29

  q = {}
  for i=0,columns-1 do
    fct = 1 + math.random(4)
    edge2 = min_range + math.random(max_range - min_range) 
	edge1 = fct * edge2
    heig1 = min_range - 2 + math.random(edge1 - min_range) 
    heig2 = fct * heig1
    if (edge1 < heig1) then
        tmp = edge1
        edge1 = heig1
        heig1 = tmp
    end		
    if (edge2 < heig2) then
        tmp = edge2
        edge2 = heig2
        heig2 = tmp
    end	
    circ = 2 * (edge1 + edge2)
	area = edge1 * heig1
    q[i] = {}
    q[i][1] = edge1
	q[i][2] = edge2
    q[i][3] = heig1
    q[i][4] = heig2
    q[i][5] = circ
    q[i][6] = area	
    q[i][7] = 2 + math.random(4)
    q[i][8] = 1 + math.random(q[i][7]-2)
    q[i][9] = math.random(q[i][8]-1)
	
    if (q[i][9]	== 1 and q[i][8] == 2 and q[i][7] == 5) then
	    q[i][7] = 6
    end	
    if (q[i][9]	== 3 and q[i][8] == 4 and q[i][7] == 5) then
	    q[i][7] = 6
    end		
    if (q[i][9]	== 1 and q[i][8] == 3 and q[i][7] == 6) then
	    q[i][7] = 5
    end	
    if (q[i][9]	== 2 and q[i][8] == 4 and q[i][7] == 6) then
	    q[i][7] = 5
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
      if (q[c][7] == r or q[c][8] == r or q[c][9] == r) then
          text = text .. lib.add_cell(tostring(q[c][r]), style)
      else 
          text = text .. lib.add_cell(lib.check_number(q[c][r],30), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end  
 