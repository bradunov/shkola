
include("terms") 

oper = {"+", "-"}
letter = {"a", "b", "m", "n", "x", "y"}

degr = {}
enum = {}
denom = {}
ch = {}

term = {""}
result = ""

op = math.random(2)
arg = letter[math.random(6)]
max_range = 5
for j = 1,2 do
    degr[j] = 1 + math.random(max_range)
end
dgrmax = math.max(degr[1], degr[2]) 

for j = 1, dgrmax + 1 do
    step = j-1
    for i = 1,2 do	
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
	if (op == 1) then
	    broj = enum[1] * denom[2] + enum[2] * denom[1]
    else
	    broj = enum[1] * denom[2] - enum[2] * denom[1]	
	end	
	imen = denom[1] * denom[2]
	qq = lib.math.gcd(broj, imen)
	broj = math.floor(broj/qq)
	imen = math.floor(imen/qq)	
    value = broj/imen
    valabs = math.abs (value)	
	rest = 10*valabs - math.floor(10*valabs)  
	if (j == 1) then
	    if (rest == 0) then
	        result = lib.check_number(lib.math.round_dec(value,1),25)
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
				result = result .. lib.check_string(sign,10) .. lib.check_number(lib.math.round_dec(abr/imen,1),25) .. arg  
			else	
				result = result .. lib.check_string(sign,10) .. lib.frac_start() .. lib.check_number(abr, 20) .. lib.frac_mid() .. lib.check_number(imen,20) .. lib.frac_end()  .. arg  
			end	
			if (j ~= 2) then
				result = result .. lib.sup_start() .. lib.check_number(step, 10).. lib.sup_end() 
			end				
		end	
	end			
end	