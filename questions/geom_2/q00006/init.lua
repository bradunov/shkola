
addition_table = function()
  columns = 5

  q = {}
  for i=0,columns-1 do
    q[i] = {}
	term = 5 + math.random(14)
    q[i][1] = math.random(term - 2)
    q[i][2] = q[i][1] + 2 * term
    q[i][3] = q[i][1] + term
    q[i][4] = term
    q[i][5] = math.random(2)
    q[i][6] = 2 + math.random(2)	
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "50px"

  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("d(M,A)", style)
  text = text .. lib.add_cell("d(M,B)", style)
  text = text .. lib.add_cell("d(M,O)", style)
  text = text .. lib.add_cell("r", style)  
  text = text .. lib.end_row()
  for i = 0,columns-1 do
    text = text .. lib.start_row()	
    for j = 1,4 do
      if (q[i][5] == j or q[i][6] == j) then
        text = text .. lib.add_cell(lib.check_number(q[i][j]), style)
      else
        text = text .. lib.add_cell(tostring(q[i][j]), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
          
              
                  
                  
        
               

