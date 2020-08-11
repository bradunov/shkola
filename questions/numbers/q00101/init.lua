
addition_table = function()
  columns = 6

  min = 2;
  max = 8;
  devide = min + math.random(max-min)
  multiple = min + math.random(10 - devide) 

  q = {}
  for i=0,columns-1 do
    q[i] = {}
    term1 = math.random(6)
    term2 = min + math.random(7 - term1)
    q[i][1] = devide * term1 * 5
    q[i][2] = devide * term2 * 5
    q[i][3] = q[i][1] + q[i][2]
    if (q[i][1] < q[i][2]) then
        xx = q[i][1]
        q[i][1] = q[i][2]
        q[i][2] = xx
    end
	q[i][4] = q[i][1] - q[i][2]
    q[i][5] = term1 * 5 + term2 * 5
    q[i][6] = q[i][4] * multiple	
    q[i][7] = math.random(3)
    q[i][8] = q[i][7] + math.random(6-q[i][7] )	
    if (q[i][7] == 3 and q[i][8] == 5) then
       q[i][8] = 6
    end
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "50px"

  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("a", style)
  text = text .. lib.add_cell("b", style)
  text = text .. lib.add_cell("a+b", style)
  text = text .. lib.add_cell("a-b", style)
  text = text .. lib.add_cell("(a+b) :" .. tostring(devide) , style)
  text = text .. lib.add_cell("(a-b) ·" .. tostring(multiple) , style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,6 do
      if (q[c][7] == r or q[c][8] == r) then
        text = text .. lib.add_cell(tostring(q[c][r]), style)	  
      else
        text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
                   
                  
         
    
   
    
    