
edge = {"a", "b", "H", "ha", "hb", "P"}

addition_table = function()
  columns = 5
   
  min_range = 2
  max_range = 8
  numb = {} 
  q = {}
  
  for i=0,columns-1 do  
    q[i] = {}
	numb[1] = min_range + math.random(max_range)
	numb[2] = min_range + math.random(max_range)
	nr = 1
	if (numb[2] > numb[1]) then
		nr = 2
	end
	numb[3] = numb[nr] + min_range + math.random(max_range)	
	ind = math.random(6)	
	
	if (ind < 4) then
	    for j = 1,2 do
		    q[i][j] = numb[j]
		end	
	    if (ind == 3) then
		    q[i][5] = numb[3]
			q[i][7] = 3
		else
		    if (ind == 2) then
				q[i][4] = numb[3]
            else
				q[i][3] = numb[3]
            end 			
			q[i][7] = 5	
        end	
		if (ind == 2) then
			q[i][8] = 3
		else
			q[i][8] = 4	
        end					
	else
		q[i][3] = numb[2]	
	    if (ind == 4) then
			q[i][1] = numb[1]
		    q[i][4] = numb[3]			
			q[i][7] = 2
			q[i][8] = 5
		else		
			q[i][7] = 1		
			if (ind == 5) then
				q[i][2] = numb[1]
				q[i][5] = numb[3]					
				q[i][8] = 4
			else
				q[i][4] = numb[2] + min_range + math.random(max_range)
				q[i][5] = numb[2] + min_range + math.random(max_range)				
				q[i][8] = 2	
			end	
        end			
	end

	if (ind == 1) then
		q[i][4] = math.sqrt (q[i][2]*q[i][2]/4 + q[i][3]*q[i][3])	
		q[i][5] = math.sqrt (q[i][1]*q[i][1]/4 + q[i][3]*q[i][3])	
	end	
	if (ind == 2) then
		q[i][3] = math.sqrt (q[i][4]*q[i][4] - q[i][2]*q[i][2]/4)	
		q[i][5] = math.sqrt (q[i][1]*q[i][1]/4 + q[i][3]*q[i][3])	
	end	
	if (ind == 3) then
		q[i][3] = math.sqrt (q[i][5]*q[i][5] - q[i][1]*q[i][1]/4)	
		q[i][4] = math.sqrt (q[i][2]*q[i][2]/4 + q[i][3]*q[i][3])	
	end	
	if (ind == 4) then
		q[i][2] = 2 * math.sqrt (q[i][4]*q[i][4] - q[i][3]*q[i][3])	
		q[i][5] = math.sqrt (q[i][1]*q[i][1]/4 + q[i][3]*q[i][3])		
	end	
	if (ind == 5) then
		q[i][1] = 2 * math.sqrt (q[i][5]*q[i][5] - q[i][3]*q[i][3])	
		q[i][4] = math.sqrt (q[i][2]*q[i][2]/4 + q[i][3]*q[i][3])			
	end	
	if (ind == 6) then
		q[i][1] = 2 * math.sqrt (q[i][5]*q[i][5] - q[i][3]*q[i][3])	
		q[i][2] = 2 * math.sqrt (q[i][4]*q[i][4] - q[i][3]*q[i][3])			
	end	
	q[i][6] = q[i][1]*q[i][2] + q[i][1]*q[i][4] + q[i][2]*q[i][5]	
	
	for j = 1,6 do
	    if (q[i][j] - math.floor(q[i][j]) ~= 0) then
			q[i][j] = lib.math.round_dec(q[i][j],1)
		end
	end
	
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "50px"
  text = lib.start_table()
  text = text .. lib.start_row()
  for i = 1,6 do
	text = text .. lib.add_cell(edge[i], style)
  end
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,5 do
      if (q[c][7] == r or q[c][8] == r) then
        text = text .. lib.add_cell(lib.check_number(q[c][r],25), style)
      else
        text = text .. lib.add_cell(tostring(q[c][r]), style)
      end
    end
    text = text .. lib.add_cell(lib.check_number(q[c][6],40), style)	
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
       
               
                   
     