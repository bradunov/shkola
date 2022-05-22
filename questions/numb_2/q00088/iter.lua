
answ = {"=", "<", ">"}
quest = {"(" , "(" }
grdout = {}
value = {}

max_range = 9

for ind = 1,2 do
	ch = math.random(3)
	sg = 1
	sgrd = 1
	enum = math.random(max_range)
	sg = math.random(2)
	if (sg == 1) then
		enum = -enum
	end    
	grd = 1 + math.random(5)
    grdout[ind] = grd
	if (ch < 3) then
		denom = 1
		if (ch == 2) then
			enum = 10
			sgrd = math.random(2)
		end	
		quest[ind] = quest[ind] .. enum .. ") "
		if (sgrd == 2) then
			grd = grd - 1
            grdout[ind] = - grd
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
	end	
	enval = 1
	deval = 1
	for i = 1, grd do
		enval = enval * enum
		deval = deval * denom	
	end	
	if (ch == 2 and sgrd == 2) then
	    value[ind] = deval / enval
    else	
	    value[ind] = enval / deval
	end	
end

sign = "="   
if (value[1] > value[2]) then sign = ">"	
end
if (value[1] < value[2]) then sign = "<"
end