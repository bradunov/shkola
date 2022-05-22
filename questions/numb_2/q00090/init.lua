
include("terms")

value = {}
out = {};
quest = {""}
result = {}

max_range = 9
stampa = 5

for ind = 1,stampa do
	ch = math.random(2)
	sign = math.random(2)
	enum = math.random(max_range)
	sg = math.random(2)
	if (sg == 1) then
		enum = -enum
	end    
	grd = math.random(5)
	if (sign == 1) then
	    quest[ind] = "("
	else
	    quest[ind] = "- ("	
	end	
	if (ch == 1) then
		denom = 1
		quest[ind] = quest[ind] .. enum .. ")"
        if (grd > 1) then
			quest[ind] = quest[ind] .. " \(^" .. grd .. "\)" 
        end					
	else
		denom = 2 + math.random(max_range - 4)  
		tmp = math.abs(enum)	
		qq = lib.math.gcd(tmp, denom)
		if (qq == denom) then
			denom = denom + 1
			qq = lib.math.gcd(tmp, denom)
		end	
		denom = math.floor(denom/qq)
		enum = math.floor(enum/qq)
		tmp = math.floor(tmp/qq)
		whole = math.floor(tmp/denom)
		tmp = tmp - whole*denom
		if (enum < 0) then
			if (whole == 0) then
				enump = - tmp
			else
				enump = tmp
				whole = - whole
			end	
		else
			enump = tmp
		end
		if (whole ~= 0) then
			quest[ind] = quest[ind] .. whole
		end	
		quest[ind] = quest[ind] .. "\(\frac{" .. tostring(enump) .."}{" .. tostring(denom) .. "}\))"   
        if (grd > 1) then
			quest[ind] = quest[ind] .. " \(^" .. grd .. "\)"  
        end	
	end	
	enval = 1
	deval = 1
	for i = 1, grd do
		enval = enval * enum
		deval = deval * denom	
	end		
	value[ind] = enval / deval		
	if (sign == 2) then
	    value[ind] = - value[ind]
        end
end             
            
form = math.random(2)
request = task[form]
out = lib.math.argsort(value);
for i=1,stampa do
    if (form == 1) then
	    j = i
    else
	    j = stampa+1-i
    end		   
    result[j] = out[i]
end
           