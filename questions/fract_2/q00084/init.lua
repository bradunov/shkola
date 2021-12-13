
addition_table = function()
    columns = 5

    max = 5

	
    q = {}
    denom = {}
    ind = {}

    for i=0,columns-1 do
        q[i] = {}
        denom[i] = {}		
        ind[i] = math.random(2)
        if (ind[i] == 1) then
		    dg = math.random(2)
			if (dg == 1) then
			    fact = 1
			else
                fact = 10
			end	
            max_range = max*fact
            q[i][2] = math.random(max_range)
	        denom[i][2] = fact
        else
            q[i][2] = math.random(max)	
            denom[i][2] = 3 + math.random(max)	   
        end	   
        if (q[i][2] == 0) then
	        q[i][2] = fact
			ind[i] = 1
        end	
        if (ind[i] == 2) then
		    tmp = math.floor(q[i][2]*10/denom[i][2])
		    rest = q[i][2]*10 - tmp*denom[i][2]
		    if (rest == 0) then
                ind[i] = 1
            else	   
                com = lib.math.gcd(q[i][2], denom[i][2])
                q[i][2] =  q[i][2]/com				
                denom[i][2] = denom[i][2]/com
			end		
        end		
        q[i][1] = q[i][2] * q[i][2] 
	    denom[i][1] = denom[i][2] * denom[i][2]	
        if (ind[i] == 1) then	
           q[i][2] = lib.math.round_dec(q[i][2] /denom[i][2],1)
           q[i][1] = lib.math.round_dec(q[i][1] /denom[i][1],2)			   
		end		
	    q[i][3] = math.random(2)		
    end

    style = {}
    style["text-align"] = "center"
    style["width"] = "80px"
    text = lib.start_table()
    text = text .. lib.start_row()
    text = text .. lib.add_cell("a", style)
    text = text .. lib.add_cell("√a", style)
    text = text .. lib.end_row()
    for c = 0,columns-1 do
        text = text .. lib.start_row()
		for r = 1,2 do
            if (q[c][3] == r) then		
	            if (ind[c] == 1) then	  
                    text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
                else
		            value = q[c][r]/ denom[c][r]
                    condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
                    sln = "numerator="..tostring(q[c][r])..";denominator="..tostring(denom[c][r])..";"	   
                    text = text .. lib.add_cell(lib.check_fraction_condition(condition, nil, nil, sln), style)
                end
            else
	            if (ind[c] == 1) then
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
              
        