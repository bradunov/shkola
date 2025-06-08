
addition_table = function()
  columns = 5
  min = 3
  max = 6
	
  q = {}
  denom = {}
  ind = {}

  for i=0,columns-1 do
    q[i] = {}
    denom[i] = {}	
    ind[i] = {}	
	for j = 1,2 do
        ind[i][j] = math.random(3)
        if (ind[i][j] < 3) then
            fact = 10^ind[i][j]
            min_range = min*fact
            max_range = max*fact
            q[i][j] = min_range - math.random(max_range)
	        denom[i][j] = fact
        else
            q[i][j] = min - math.random(max)	
            denom[i][j] = min + math.random(max)	   
        end	   
        if (q[i][j] == 0) then
	        q[i][j] = j*min - (2-j)*max
        end	
    end	
    q[i][3] = q[i][1]*denom[i][2] + q[i][2]*denom[i][1] 
	denom[i][3] = denom[i][1]*denom[i][2]	
    for j = 1,2 do
        if (ind[i][j] < 3) then	
           q[i][j] = lib.math.round_dec(q[i][j] /denom[i][j],2)	
		end
    end		
 	if (ind[i][1] == 3 or ind[i][2] == 3) then
		tmp = math.floor(q[i][3]*100/denom[i][3])
		rest = q[i][3]*100 - tmp*denom[i][3]
		if (rest == 0) then
            q[i][3] = lib.math.round_dec(q[i][3]/denom[i][3],2)
        	denom[i][3] = 1		
            ind[i][3] = 1
        else
            com = lib.math.gcd(q[i][3], denom[i][3])
            q[i][3] =  q[i][3]/com				
            denom[i][3]	= denom[i][3]/com		
            ind[i][3] = 3	
        end
    else
        q[i][3] = lib.math.round_dec(q[i][3]/denom[i][3],2)
        denom[i][3] = 1		
        ind[i][3] = 1	
    end		
    q[i][4] = math.random(3)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "70px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("a", style)
  text = text .. lib.add_cell("b", style)
  text = text .. lib.add_cell("a+b", style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,3 do
        if (q[c][4] == r) then
	       if (ind[c][r] < 3) then	  
               text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
           else
		       value = q[c][r]/ denom[c][r]
               condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
               sln = "numerator="..tostring(q[c][r])..";denominator="..tostring(denom[c][r])..";"	   
               text = text .. lib.add_cell(lib.check_fraction_condition(condition, nil, nil, sln), style)
           end
        else
	       if (ind[c][r] < 3) then
               text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)	
           else
               text = text .. lib.add_cell("\(\frac{" .. tostring(math.floor(q[c][r])) .. "}{" .. tostring(math.floor(denom[c][r])) .. "}\)", style)	
           end				   
        end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end          
    