
addition_table = function()

  measure = {"a  \( \ \) cm", "b  \( \ \) cm", "c  \( \ \) cm",  "h  \( \ \) cm", "O  \( \ \) cm", "P \( \ \ \) cm²"} 

  ea = {3, 5, 8, 7}
  eh = {4, 12, 15, 24}
  ec = {5, 13, 17, 25}

  columns = 5
  min_range = 2
  max_range = 14
  
  q = {}
  for i=0,columns-1 do
	ch = math.random(4)
    fct = math.random(9 - ch)	
	tmp = fct * ea[ch]
	heig = fct * eh[ch]
	edge3 = fct * ec[ch]
    edge2 = fct * (min_range + math.random(max_range - min_range))	
    edge1 = edge2 + 2*tmp
    circ = edge1 + edge2 + 2 * edge3
	area = (edge2 + tmp) *	heig
    q[i] = {}
    q[i][1] = edge1
	q[i][2] = edge2
    q[i][3] = edge3
    q[i][4] = heig
    q[i][5] = circ	
    q[i][6] = area		
    q[i][7] = 2 + math.random(4)
    q[i][8] = math.random(q[i][7]-2)
	
    if (q[i][8] == 4 and q[i][7] == 6) then
	    q[i][8] = 3
    end	
    if (q[i][8] == 3 and q[i][7] == 5) then
	    q[i][8] = 2
    end	
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "45px"
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
      if (q[c][7] ~= r and q[c][8] ~= r) then
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
    