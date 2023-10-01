
addition_table = function()
    columns = 5
    min = 3
    max = 6
	
    q = {}
    denom = {}
    ind = {}

    for i=0,columns-1 do
        q[i] = {}
        ind[i] = math.random(2)
        fact = 10
        if (ind[i] == 1) then
            min_range = min*fact
            max_range = max*fact
            q[i][1] = min_range - math.random(max_range)
	        denom[i] = fact
        else
            q[i][1] = min - math.random(max)	
            denom[i] = min + math.random(max)	   
        end	   
        if (q[i][1] == 0) then
	        q[i][1] = fact
			ind[i] = 1
        end	
        if (ind[i] == 2) then
		    tmp = math.floor(q[i][1]*10/denom[i])
		    rest = q[i][1]*10 - tmp*denom[i]
		    if (rest == 0) then
                ind[i] = 1
            else	   
                com = lib.math.gcd(q[i][1], denom[i])
                q[i][1] =  q[i][1]/com				
                denom[i] = denom[i]/com
			end		
        end		
        q[i][2] = q[i][1] * q[i][1] 
	    den2 = denom[i] * denom[i]	
        if (ind[i] == 1) then	
           q[i][1] = lib.math.round_dec(q[i][1] /denom[i],1)
           q[i][2] = lib.math.round_dec(q[i][2] /den2,2)			   
		end		
	    q[i][3] = - q[i][1]
        q[i][4] = q[i][2]  
	    q[i][5] = - q[i][2]	
    end

    style = {}
    style["text-align"] = "center"
    style["width"] = "50px"
    text = lib.start_table()
    text = text .. lib.start_row()
    text = text .. lib.add_cell("a", style)
    text = text .. lib.add_cell("a²", style)
    text = text .. lib.add_cell("-a", style)
    text = text .. lib.add_cell("(-a)²", style)
    text = text .. lib.add_cell("-a²", style)
    text = text .. lib.end_row()
    for c = 0,columns-1 do
        text = text .. lib.start_row()
	    if (ind[c] == 1) then
            text = text .. lib.add_cell(lib.dec_to_str(q[c][1]), style)	
        else
            text = text .. lib.add_cell("\(\frac{" .. tostring(math.floor(q[c][1])) .. "}{" .. tostring(math.floor(denom[c])) .. "}\)", style)	
        end	 
        for r = 2,5 do
	        if (ind[c] == 1) then	  
                text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
            else
			    if (r == 3) then
			        den = denom[c]
				else
			        den = denom[c] * denom[c]
                end					
		        value = q[c][r]/ den
                condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
                sln = "numerator="..tostring(q[c][r])..";denominator="..tostring(den)..";"	   
                text = text .. lib.add_cell(lib.check_fraction_condition(condition, nil, nil, sln), style)
            end			   
        end
        text = text .. lib.end_row()
    end
    text = text .. lib.end_table()

    return text
end          
            