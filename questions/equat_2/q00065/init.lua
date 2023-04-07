
include("terms")

addition_table = function()

  columns = 5

  fun = {""}
  fun_en = {}
  fun_den = {}
 
  qr = {""}
  enum = {}
  denom = {}
  q = {}

  max_range = 5 
 
 
  for i = 1,columns do
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
 end	   
	
 for i=1,columns do
    q[i] = {}
	enum[i] = {}
    denom[i] = {}
	if (fun_en[i][1]/fun_den[i][1] > 0 ) then
	    qr[i] = sign[1]
	else
	    qr[i] = sign[2]	
	end	   
	enum[i][1] = -fun_en[i][2]*fun_den[i][1]	
	denom[i][1] = fun_den[i][2]*fun_en[i][1]
	if (denom[i][1] < 0) then
	    enum[i][1] = - enum[i][1]
	    denom[i][1] = - denom[i][1]		
    end		
	enum[i][2] = fun_en[i][2]	
	denom[i][2] = fun_den[i][2]		
	for j = 1,2 do		
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
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "70px"
  
  text = lib.start_table()
  text = text .. lib.start_row() 
  for j = 1, 4 do    
	text = text .. lib.add_cell(msg[j], style)
  end
  text = text .. lib.end_row()
  for c=1,columns do
    text = text .. lib.start_row()
	text = text .. lib.add_cell(fun[c], style)
	text = text .. lib.add_cell(lib.check_string(qr[c], 10),style)
    for r=1,2 do		
		if (q[c][r] < 2) then
			text = text .. lib.add_cell(lib.check_number(lib.math.round_dec(enum[c][r]/denom[c][r],1)), style)	
		else
			text = text .. lib.add_cell(lib.check_fraction_simple(enum[c][r], denom[c][r]), style)
		end		  
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end     
 
        
    
    