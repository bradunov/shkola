
answ = {"=", "<", ">"}
quest = {"(" , "(" }
grdout = {}
value = {}

max_range = 11
grd = 3 + math.random(4)
fct = 100 + 50*math.random(6)

for ind = 1,2 do
	ch = math.random(2)
	enum = 1 + math.random(max_range)
	if (ch == 1) then
		denom = 1	
	else
		denom = 2 + math.random(max_range - 3) 
        if (denom == enum) then
            enum = enum + 2
        end			
		qq = lib.math.gcd(enum, denom)
		enum = math.floor(enum/qq)
		denom = math.floor(denom/qq)		
		if (denom == 1) then
			ch = 1
        else				
			tmp = enum/denom
			rest = 10 * tmp - math.floor(10 * tmp)
			if (rest == 0) then
				enum = lib.math.round_dec(tmp, 1)
				denom = 1
				ch = 3
			else
		        whole = math.floor(tmp)
		        enump = enum - whole*denom		
		    end	
		end	
    end
	if (ch == 1) then 
	    quest[ind] = quest[ind] .. enum .. ")"
    end
	if (ch == 2) then 	
		if (whole ~= 0) then
			quest[ind] = quest[ind] .. whole
		end	
		quest[ind] = quest[ind] .. "\(\frac{" .. tostring(enump) .."}{" .. tostring(denom) .. "}\))"   
	end	
	if (ch == 3) then 
	    quest[ind] = quest[ind] .. lib.dec_to_str(enum) .. ")"
    end	
    value[ind] = enum/denom
end	
	
if (value[1] > value[2]) then
	grdout[1] = 1 + math.random(grd-1)
	grdout[2] = grd + math.random(4)			
else
	grdout[1] = grd + math.random(4) 
	grdout[2] = 1 + math.random(grd-1)
end			
for ind = 1,2 do	
	val = value[ind] ^ grdout[ind]
    value[ind] = val
    grdout[ind] = grdout[ind] * fct	
end	

sign = "="  
if (value[1] > value[2]) then 
	sign = ">"	
end
if (value[1] < value[2]) then 
	sign = "<"
end      
       