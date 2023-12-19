
edge = {"r", "H", "s", "Q", "P", "V"}

addition_table = function()
  columns = 5
  
  min_range = 2
  max_range = 8
  q = {} 
  for i=0,columns-1 do  
    q[i] = {}

	q[i][1] = min_range + math.random(max_range)
	q[i][2] = min_range + math.random(max_range)
	q[i][3] = math.sqrt(q[i][1]^2 + q[i][2]^2)	
	q[i][4] = q[i][1] * q[i][2]	 
	q[i][5] = q[i][1] * (q[i][1] + q[i][3]) * 22/7	
	q[i][6] = q[i][1]^2 * q[i][2] * 22/21

	ind = math.random(11)
	if (ind == 8) then
	    ind = ind - math.random(5)
    end	
	if (ind == 10) then
	    ind = ind - 2 - math.random(5)
    end	
	
    if (ind < 6) then
   	    q[i][7] = 1
		q[i][8] = ind + 1
		if (ind == 2) then
			q[i][3] = math.ceil(q[i][3])		
			q[i][2] = math.sqrt(q[i][3]^2 - q[i][1]^2)	
			q[i][4] = q[i][1] * q[i][2]	
			q[i][5] = q[i][1] * (q[i][1] + q[i][3]) * 22/7	
			q[i][6] = q[i][1]^2 * q[i][2] * 22/21			
        end		
		if (ind == 4) then
			q[i][5] = math.ceil(q[i][5])	
       	    q[i][3] = 7*q[i][5]/(22*q[i][1]) - q[i][1]	
			q[i][2] = math.sqrt(q[i][3]^2 - q[i][1]^2)	
			q[i][4] = q[i][1] * q[i][2]	
			q[i][6] = q[i][1]^2 * q[i][2] * 22/21			
        end	
		if (ind == 5) then
			q[i][6] = math.ceil(q[i][6])	
       	    q[i][2] = 21*q[i][6]/(22*q[i][1]^2)	
			q[i][3] = math.sqrt(q[i][1]^2 + q[i][2]^2)	
			q[i][4] = q[i][1] * q[i][2]	
			q[i][5] = q[i][1] * (q[i][1] + q[i][3]) * 22/7			
        end			
    else
		if (ind < 10) then
			q[i][7] = 2
			q[i][8] = ind - 3
			if (ind == 6) then
				q[i][3] = math.ceil(q[i][3])	
				q[i][1] = math.sqrt(q[i][3]^2 - q[i][2]^2)	
				q[i][4] = q[i][1]*q[i][2]					
				q[i][5] = q[i][1] * (q[i][1] + q[i][3]) * 22/7	
				q[i][6] = q[i][1]^2 * q[i][2] * 22/21					
			end				
			if (ind == 7) then
				q[i][4] = math.ceil(q[i][4])	
				q[i][1] = q[i][4] / q[i][2]		
				q[i][3] = math.sqrt(q[i][1]^2 + q[i][2]^2)				
				q[i][5] = q[i][1] * (q[i][1] + q[i][3]) * 22/7	
				q[i][6] = q[i][1]^2 * q[i][2] * 22/21				
			end			
			if (ind == 9) then
				q[i][6] = math.ceil(q[i][5])	
				q[i][1] = math.sqrt(21*q[i][6] / (22*q[i][2]))	
				q[i][3] = math.sqrt(q[i][1]^2 + q[i][2]^2)				
				q[i][4] = q[i][1] * q[i][2]	
				q[i][5] = q[i][1] * (q[i][1] + q[i][3]) * 22/7					
			end			
        else
		    if (ind == 10) then		 
				q[i][7] = 3
				q[i][8] = 4
				q[i][3] = math.ceil(q[i][3])				
				q[i][4] = math.ceil(q[i][4])
				tmp1 = math.sqrt(q[i][3]^2 + 2*q[i][4])	
				tmp2 = math.sqrt(q[i][3]^2 - 2*q[i][4])					
				q[i][1] = 0.5 * (tmp1 - tmp2)	
				q[i][2] = 0.5 * (tmp1 + tmp2)				
				q[i][5] = q[i][1] * (q[i][1] + q[i][3]) * 22/7
				q[i][6] = q[i][1]^2 * q[i][2] * 22/21	
			else			
				q[i][7] = 4
				q[i][8] = 6
				q[i][4] = math.ceil(q[i][4])				
				q[i][6] = math.ceil(q[i][6])			
				q[i][1] = 21*q[i][6] / (22*q[i][4])	
				q[i][2] = q[i][4] / q[i][1]	
				q[i][3] = math.sqrt(q[i][1]^2 + q[i][2]^2)					
				q[i][5] = q[i][1] * (q[i][1] + q[i][3]) * 22/7	
			end						
		end
	end

	for j = 1,6 do
        	q[i][j] = lib.math.round_dec(q[i][j],1)
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
    for r=1,6 do
      if (q[c][7] == r or q[c][8] == r) then
        text = text .. lib.add_cell(tostring(math.floor(q[c][r])), style)
      else
        if (r < 4) then	  
			text = text .. lib.add_cell(lib.check_number(q[c][r],25), style)
		else
			if (r > 4) then
				text = text .. lib.add_cell(lib.check_number(q[c][r],35), style)
			else
				text = text .. lib.add_cell(lib.check_number(q[c][r],30), style)		
			end
		end
	  end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end    
          
       
             
       
               
                   
     