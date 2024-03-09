
include("terms")

addition_table = function()

  measure = {name[1].." \( \ \) cm", name[1].." \( \ \) cm", name[2].." cm"} 

  columns = 5 
  max_range = 6
  
  q = {}
   
  for i = 0,columns-1 do
    numb2 = 3 + math.random(max_range)
    numb1 = math.random(numb2 - 1)
	q[i] = {}
	q[i][1] = numb2^2 - numb1^2
	q[i][2] = 2 * numb1 * numb2
	ch = math.random(2)
	if (ch == 2) then
	    tmp = q[i][2]
		q[i][2] = q[i][1]
		q[i][1] = tmp
	end	
	q[i][3] = numb2^2 + numb1^2
	fct = math.random(4)	
	for j = 1,3 do
	    q[i][j] = q[i][j] * fct
	end
	q[i][4] = math.random(3)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "70px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(measure[1], style)
  text = text .. lib.add_cell(measure[2], style)
  text = text .. lib.add_cell(measure[3], style)
  text = text .. lib.end_row()
  for c = 0,columns-1 do
    text = text .. lib.start_row()
    for r = 1,3 do
      if q[c][4] == r then
        text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
      else
        text = text .. lib.add_cell(tostring(math.floor(q[c][r])), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
        
           
       
            
  