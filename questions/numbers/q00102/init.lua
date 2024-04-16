
addition_table = function()
  
  ind = math.random(2)
  if (ind == 1) then
      sign1 = "+"
	  sign2 = "-"
  else
      sign1 = "-"
	  sign2 = "+"	
  end 		
	
  columns = 5

  min = 2;
  max = 6;
  devide = min + math.random(max-min)
  multiple = min + math.random(4) 
  
  q = {}
  for i=0,columns-1 do
    q[i] = {}
    term1 = min + math.random(3)
    term2 = math.random(term1 - 1)
    q[i][1] = devide * term1 * 5
    q[i][2] = devide * term2 * 5
	if (ind == 1) then
        q[i][3] = multiple * (q[i][1] + q[i][2])
	    q[i][4] = multiple * q[i][1] + q[i][2]
        q[i][5] = q[i][1] - term2 * 5
        q[i][6] = (term1 - term2) * 5		
	else
        q[i][3] = multiple * (q[i][1] - q[i][2])
	    q[i][4] = multiple * q[i][1] - q[i][2]	
        q[i][5] = q[i][1] + term2 * 5
        q[i][6] = (term1 + term2) * 5
    end
    q[i][7] = math.random(2)
    q[i][8] = q[i][7] + math.random(6-q[i][7] )	
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "50px"

  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("a", style)
  text = text .. lib.add_cell("b", style)
  text = text .. lib.add_cell(tostring(multiple) .. "· (a" .. sign1 .. "b)", style)
  text = text .. lib.add_cell(tostring(multiple) .. "·a" .. sign1 .. "b", style)
  text = text .. lib.add_cell("a" .. sign2 .. "b:" .. tostring(devide), style)
  text = text .. lib.add_cell("(a" .. sign2 .. "b) :" .. tostring(devide) , style)
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
   
                
                  
         
    
   
    
    