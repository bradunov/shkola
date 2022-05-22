
max_range = 8
enum = 1 + math.random(max_range)
sg = math.random(2)
if (sg == 1) then
    enum = -enum
end    

grd = 1 + math.random(5)
grdout = grd
quest = "(" 
ch = math.random(3)
sg = 1

if (ch < 3) then
    denom = 1
    if (ch == 2) then
		enum = 10
		sg = math.random(2)
    end	
    quest = quest .. enum .. ") "
	if (sg == 2) then
	    grd = grd - 1
        grdout = - grd	
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
	    quest = quest .. whole
	end	
    quest = quest .. "\(\frac{" .. tostring(enump) .."}{" .. tostring(denom) .. "}\)) "   
end	

enval = 1
deval = 1
for i = 1, grd do
	enval = enval * enum
	deval = deval * denom	
end	

answ = ""
if (ch < 3) then
	if (sg == 2) then
		enval = lib.math.round_dec(1/enval, grd)
	end			
    answ = lib.check_number(enval,50)
else
    answ = lib.check_fraction_simple(enval, deval)
end	    