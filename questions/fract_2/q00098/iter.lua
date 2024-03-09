
measure = {"g","kg", "cm", "m", "dl", "l"}
denom = { 2, 4, 5, 8, 10}

ch = math.random(3)
meas_l = 2*ch 
meas_r = 2*ch - 1
if (ch == 1) then
    fct = 1000
else
	if (ch == 2) then
		fct = 100
	else
		fct = 10
    end
end	

ind = math.random(5)
enum = math.random(denom[ind] - 1)
numb = lib.math.round_dec(enum * fct / denom[ind],2)
quest = "\(\frac{" .. enum .. "}{" .. denom[ind] .. "}\)"         
            
            