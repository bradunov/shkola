
oper = {"+", "-"}
letter = {"a", "b", "m", "n", "x", "y"}

degr = {}
enum = {}
denom = {}
ch = {}
op = {}
term = {""}
result = ""
quest = ""

numb = 3                --[[broj polinoma]]--
ind = math.random(2)    --[[kombinacija polinoma P, Q, R]]--
for i = 1,3 do
    op[i] = math.random(2)
end	
arg = letter[math.random(6)]
max_range = 5
for i = 1,numb do
    degr[i] = 1 + math.random(max_range-1)
end
dgrmax = 1
for i = 1,numb do
    if (degr[i] > dgrmax) then
		dgrmax = degr[i]
    end
end

for j = 1, dgrmax + 1 do
    step = j-1
    for i = 1,numb do	
		enum[i] = 0
		denom[i] = 1
		ch[i] = 2
		if (j <= degr[i]+1) then		
			ch[i] = 1 + math.random(2)
			enum[i] = math.random(2*max_range)		 
			if (ch[i] == 2) then
				denom[i] = 1
			else
				denom[i] = 1 + math.random(max_range)
				qq = lib.math.gcd(enum[i], denom[i])
				enum[i] = math.floor(enum[i]/qq)
				denom[i] = math.floor(denom[i]/qq)
				if (denom[i] == 1) then
					ch[i] = 2
				else
					tmp = enum[i]/denom[i]
					rest = 10*tmp - math.floor(10*tmp)				
					if (rest == 0) then
						enum[i] = 10 * tmp
						denom[i] = 10
						ch[i] = 1			
					end	
				end	
			end	
			sg = math.random(2)
			if (sg == 2) then
				enum[i] = - enum[i]
			end		   
			if (j == 1) then
				if (ch[i] < 3) then
					term[i] = lib.dec_to_str(lib.math.round_dec(enum[i]/denom[i],1)) 
				else	
					term[i] = "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
				end	
			else			
				if (enum[i] ~= 0) then
					if (enum[i] > 0) then
						sign = " + "
						aben = enum[i]
					else
						sign = " - "
						aben = -enum[i]	
					end					
					if (ch[i] < 3) then
					    val = aben/denom[i]
						if (val == 1) then
							term[i] = term[i] .. sign .. arg
						else	
							term[i] = term[i] .. sign .. lib.dec_to_str(lib.math.round_dec(aben/denom[i],1)) .. arg 
                        end							
					else	
						term[i] = term[i] .. sign .. "\(\frac{" .. tostring(aben) .."}{" .. tostring(denom[i]) .. "}\)" .. arg  
					end	
					if (j ~= 2) then
						term[i] = term[i] .. "\(^{" .. step  .. "}\)" 
					end				
				end	
			end	
		end	
	end	
	
	if (ind == 1) then
		if (op[1] == 1) then
			brojilac = enum[1] * denom[2] + enum[2] * denom[1]
		else
			brojilac = enum[1] * denom[2] - enum[2] * denom[1]	
		end		
	    imenilac = denom[1] * denom[2]
	    if (op[2] == 1) then
			broj = brojilac * denom[3] + enum[3] * imenilac
		else
			broj = brojilac * denom[3] - enum[3] * imenilac	
		end		
	    imen = imenilac * denom[3]	
	    quest = "P " .. oper[op[1]] .. " Q " .. oper[op[2]] .. " R"
	end	
	if (ind == 2) then
		if (op[1] == 1) then
			brojilac1 = enum[1] * denom[2] + enum[2] * denom[1]
		else
			brojilac1 = enum[1] * denom[2] - enum[2] * denom[1]	
		end		
	    imenilac1 = denom[1] * denom[2]
		if (op[2] == 1) then
			brojilac2 = enum[1] * denom[3] + enum[3] * denom[1]
		else
			brojilac2 = enum[1] * denom[3] - enum[3] * denom[1]	
		end		
	    imenilac2 = denom[1] * denom[3]		
	    if (op[3] == 1) then
			broj = brojilac1 * imenilac2 + brojilac2 * imenilac1
		else
			broj = brojilac1 * imenilac2 - brojilac2 * imenilac1	
		end		
	    imen = imenilac1 * imenilac2	
	    quest = "(P " .. oper[op[1]] .. " Q) " .. oper[op[3]] .. " (P " .. oper[op[2]] .. " R )" 
	end		
	qq = lib.math.gcd(broj, imen)
	broj = math.floor(broj/qq)
	imen = math.floor(imen/qq)	
    value = broj/imen
    valabs = math.abs (value)	
	rest = 10*valabs - math.floor(10*valabs)  
	if (j == 1) then
	    if (rest == 0) then
	        result = lib.check_number(lib.math.round_dec(value,1))
	    else	
			result = lib.frac_start() .. lib.check_number(broj, 20) .. lib.frac_mid() .. lib.check_number(imen,20) .. lib.frac_end()
	    end	
    else		
		if (broj ~= 0) then
			if (broj > 0) then
				sign = " + "
				abr = broj
			else
				sign = " - "
				abr = -broj	
			end					
			if (rest == 0) then
				result = result .. lib.check_string(sign,10) .. lib.check_number(lib.math.round_dec(abr/imen,1)) .. arg  
			else	
				result = result .. lib.check_string(sign,10) .. lib.frac_start() .. lib.check_number(abr, 20) .. lib.frac_mid() .. lib.check_number(imen,20) .. lib.frac_end()  .. arg  
			end	
			if (j ~= 2) then
				result = result .. lib.sup_start() .. lib.check_number(step, 10).. lib.sup_end() 
			end				
		end	
	end			
end	            
            