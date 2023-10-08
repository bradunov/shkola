
edge = {"a", "b", "H", "s", "V"}

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
	numb[3] = min_range + math.random(max_range)	
	numb[4] = math.ceil(0.5*math.sqrt(numb[1]^2 + numb[2]^2 + 4*numb[3]^2)) 	
	numb[5] = math.ceil(numb[1]*numb[2]*numb[3]/3)  

	ind = math.random(4)	

	if (ind < 3) then
	    for j = 1,2 do
		    q[i][j] = numb[j]
		end	
		tmp = q[i][1]^2 + q[i][2]^2		
	    if (ind == 1) then
		    ch = math.random(2)
			if (ch == 1) then
				q[i][3] = numb[3]
				q[i][4] = math.sqrt (q[i][3]^2 + 0.25*tmp)						
				q[i][6] = 4
			else
				q[i][4] = numb[4]	
				if (q[i][4]^2 <= 0.25*tmp ) then
					q[i][4] =  math.ceil(0.5*math.sqrt(tmp)) + math.random(max_range)
                end					
				q[i][3] = math.sqrt (q[i][4]^2 - 0.25*tmp)	
				q[i][6] = 3
            end	
			q[i][5] = q[i][1] * q[i][2] * q[i][3] / 3
			q[i][7] = 5			
		else
			q[i][5] = numb[5]
			q[i][3] = 3*q[i][5]	/ (q[i][1]*q[i][2])	
			q[i][4] = math.sqrt (q[i][3]^2 + 0.25*tmp)			
			q[i][6] = 3 			
			q[i][7] = 4	
        end			
	else	
		if (ind == 3) then
			q[i][3] = numb[3]	
			q[i][4] = numb[4]	
            tmp = q[i][4]^2-q[i][3]^2			
			ch = math.random(2)
			if (ch == 1) then
				q[i][1] = numb[1]
				if (q[i][1]^2 >= 4*tmp ) then
					q[i][4] =  math.ceil(math.sqrt(0.25*numb[1]^2 + numb[3]^2)) + math.random(max_range)
                end					
				q[i][2] = math.sqrt (4*(q[i][4]^2-q[i][3]^2) - q[i][1]^2)						
				q[i][6] = 2
			else
				q[i][2] = numb[2]
				if (q[i][2]^2 >= 4*tmp ) then
					q[i][4] =  math.ceil(math.sqrt(0.25*numb[2]^2 + numb[3]^2)) + math.random(max_range)
                end					
				q[i][1] = math.sqrt (4*(q[i][4]^2-q[i][3]^2) - q[i][2]^2)					
				q[i][6] = 1
			end	
			q[i][5] = q[i][1] * q[i][2] * q[i][3] / 3
			q[i][7] = 5		
		else		
			q[i][3] = numb[3]	
			q[i][5] = numb[5]					
			ch = math.random(2)
			if (ch == 1) then
				q[i][1] = numb[1]
				q[i][2] = 3*q[i][5] / (q[i][1] * q[i][3])										
				q[i][6] = 2
			else
				q[i][2] = numb[2]
				q[i][1] = 3*q[i][5] / (q[i][2] * q[i][3])						
				q[i][6] = 1
			end	
			q[i][4] = math.sqrt (q[i][3]^2 + 0.25*(q[i][1]^2 + q[i][2]^2))
			q[i][7] = 4				
		end
	end
	
	for j = 1,5 do
	    if (q[i][j] - math.floor(q[i][j]) ~= 0) then
			q[i][j] = lib.math.round_dec(q[i][j],1)
		end
	end
	
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "60px"
  text = lib.start_table()
  text = text .. lib.start_row()
  for i = 1,5 do
	text = text .. lib.add_cell(edge[i], style)
  end
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,5 do
		if (q[c][6] == r or q[c][7] == r) then
			if (r == 5) then
				text = text .. lib.add_cell(lib.check_number(q[c][r],40), style)
			else
				text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
			end
		else
            text = text .. lib.add_cell(tostring(q[c][r]), style)
		end
    end	
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
           