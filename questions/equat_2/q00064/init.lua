
addition_table = function()
  columns = 4
  rows = 3

  fun = {""}
  fun_en = {}
  fun_den = {}
  sqw = {}             --[[ sqw[i] = 0  linearna jedn. / = 1 kvadratna jednacina ]]--

  enum = {}
  denom = {}
  q = {}

  max_range = 5 
 
 
  for i = 1,rows do
    sqw[i] = 0
	fun_en[i] = {}
	fun_den[i] = {}
	fun[i] = ""
	for j = 1,2 do	   
		ch = math.random(3) - 1
		fun_en[i][j] = max_range - math.random(2*max_range)
		if (j == 1 and fun_en[i][j] == 0) then
			fun_en[i][j] = math.random(2*max_range)
		end		
		if (ch == 0) then
			fun_den[i][j] = 1 
		else
			fun_den[i][j] = 1 + math.random(max_range)
			qq = lib.math.gcd(fun_en[i][j], fun_den[i][j])
			fun_en[i][j] = math.floor(fun_en[i][j]/qq)
			fun_den[i][j] = math.floor(fun_den[i][j]/qq)
			if (fun_den[i][j] == 1) then
			    ch = 0
			else
				tmp = fun_en[i][j]/fun_den[i][j]
				rest = 10*tmp - math.floor(10*tmp)				
				if (rest == 0) then
					fun_en[i][j] = 10 * tmp
					fun_den[i][j] = 10
					ch = 1
				else
					ch = 2			
				end	
            end				
		end
        if (j == 1) then
		    if (ch < 2) then
				fun[i] = fun[i] .. "x"				
			    if (math.abs(fun_en[i][j]) == 1) then
				    if (fun_en[i][j] == -1) then
						fun[i] =  "-" .. fun[i] 
                    end	
				else
					fun[i] = lib.dec_to_str(lib.math.round_dec(fun_en[i][j]/fun_den[i][j],1)) .. fun[i] 
				end
			else			
			    if (math.abs(fun_en[i][j]) == 1) then
				    stmp = "x"
				    if (fun_en[i][j] == -1) then
						stmp = "-x"
                    end	
					fun[i] = fun[i] .. "\(\frac{" .. stmp .. "}{" .. tostring(fun_den[i][j]) .. "}\)"								
				else
					fun[i] = fun[i] .. "\(\frac{" .. tostring(fun_en[i][j]) .. "}{" .. tostring(fun_den[i][j]) .. "}\)" .. "x" 	
                end					
            end
		else
            if (fun_en[i][j] ~= 0) then			
				if (fun_en[i][j] < 0) then
					fun[i] = fun[i] .. "-" 
					tmp =  math.abs(fun_en[i][j])					
					if (ch < 2) then
						fun[i] = fun[i] .. lib.dec_to_str(lib.math.round_dec(tmp/fun_den[i][j],1))
					else
						fun[i] = fun[i] .. "\(\frac{" .. tostring(tmp) .. "}{" .. tostring(fun_den[i][j]) .. "}\)"			
					end					
				else
					fun[i] = fun[i] .. "+" 				
					if (ch < 2) then
						fun[i] = fun[i] .. lib.dec_to_str(lib.math.round_dec(fun_en[i][j]/fun_den[i][j],1))
					else
						fun[i] = fun[i] .. "\(\frac{" .. tostring(fun_en[i][j]) .. "}{" .. tostring(fun_den[i][j]) .. "}\)"			
					end		
                end					
            end			
		end
	end
	if (math.abs(fun_en[i][1]) == 1 and fun_den[i][1] == 1 and fun_en[i][2] == 0) then 
	    sqw[i] = 1
		fun_den[i][2] = 1
		fun[i] = "x²"
		for j = 1,2 do
			fun_en[i][j] = math.random(max_range)
			tmp = fun_en[i][j]
			sg = math.random(2)
			if (sg == 1) then 
				fun_en[i][j] = - fun_en[i][j] 
            end				
			if (j == 1) then	
			    if (tmp ~= 1) then			
					fun[i] = tostring(fun_en[i][j]) .. fun[i]
				else
				    if (sg == 1) then
						fun[i] = "-" .. fun[i]	
					end					
                end						
			else	
			    if (sg == 1) then
					fun[i] = fun[i] .. "-"
				else
					fun[i] = fun[i] .. "+"				
				end								
				fun[i] = fun[i] .. tostring(tmp)	
            end				
		end
	end    
 end	   
	
 for i=0,columns-1 do
    q[i] = {}
	enum[i] = {}
    denom[i] = {}
	enum[i][0] = max_range - math.random(2*max_range)
	denom[i][0] = math.random(max_range)
	qq = lib.math.gcd(enum[i][0], denom[i][0])
	enum[i][0] = math.floor(enum[i][0]/qq)
	denom[i][0] = math.floor(denom[i][0]/qq)
	sqw[0] = 0
	if (denom[i][0] == 1) then
		q[i][0] = 0
	else
		tmp = enum[i][0]/denom[i][0]
		rest = 10*tmp - math.floor(10*tmp)				
		if (rest == 0) then
			enum[i][0] = 10 * tmp
			denom[i][0] = 10
			q[i][0] = 1
		else
			q[i][0] = 2
		end			
	end		
	for j = 1,rows do	   
        if (sqw[j] == 0) then
			enum[i][j] = fun_en[j][1]*fun_den[j][2]*enum[i][0] + fun_en[j][2]*fun_den[j][1]*denom[i][0]	
			denom[i][j] = fun_den[j][1]*fun_den[j][2]*denom[i][0]
		else
			enum[i][j] = fun_en[j][1]*fun_den[j][2]*(enum[i][0])^2 + fun_en[j][2]*fun_den[j][1]*(denom[i][0])^2	
			denom[i][j] = fun_den[j][1]*fun_den[j][2]*(denom[i][0])^2
        end		
		qq = lib.math.gcd(enum[i][j], denom[i][j])
		enum[i][j] = math.floor(enum[i][j]/qq)
		denom[i][j] = math.floor(denom[i][j]/qq)		
		if (denom[i][j] == 1) then
			q[i][j] = 0
		else
			tmp = enum[i][j]/denom[i][j]
			rest = 10*tmp - math.floor(10*tmp)				
			if (rest == 0) then
				enum[i][j] = 10 * tmp
				denom[i][j] = 10
				q[i][j] = 1
            else
				q[i][j] = 2
            end			
		end	
	end	
	q[i][rows+1] = math.random(rows+1) - 1		
	if (sqw[q[i][rows+1]] == 1) then
		q[i][rows+1] = 0
	end					
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "70px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("x", style)  
  for j = 1, rows do    
	text = text .. lib.add_cell(fun[j], style)
  end
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=0,rows do	
		if (q[c][rows+1] == r) then
	        if (q[c][r] < 2) then
				text = text .. lib.add_cell(lib.dec_to_str(lib.math.round_dec(enum[c][r]/denom[c][r],1)), style)	
            else
				text = text .. lib.add_cell("\(\frac{" .. tostring(enum[c][r]) .. "}{" .. tostring(denom[c][r]) .. "}\)", style)
            end				
        else
	        if (q[c][r] < 2) then
				text = text .. lib.add_cell(lib.check_number(lib.math.round_dec(enum[c][r]/denom[c][r],1)), style)	
            else
				text = text .. lib.add_cell(lib.check_fraction_simple(enum[c][r], denom[c][r]), style)
            end		  
        end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end     
             
        
    
    