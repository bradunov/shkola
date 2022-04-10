
ind = math.random(dim)

angc = lib.math.round_dec(360 / part[ind], 2)
angp = lib.math.round_dec(360 / (2*part[ind]), 2)

ch = math.random(4)

quest = ""
answ = ""
answ2 = ""

if (ch < 3) then
    quest = task[6] .. task[5] .. task[7] 
	answ =  lib.check_fraction_denominator(1, part[ind]) .. task[5] 
    if (ch == 1) then
        quest = quest .. task[2] .. spc .. phi .. " = " .. lib.dec_to_str(angc) .. meas .. "?"
    else
        quest = quest .. task[4] .. spc .. alpha .. " = " .. lib.dec_to_str(angp) .. meas .. "?"	
    end	
else
    if (ch == 3) then
        quest = task[1] 
		answ = phi .. " = " .. lib.check_number(angc,30) .. meas 
    else
        quest = task[3] 
		answ = alpha .. " = " .. lib.check_number(angp,30) .. meas 
    end 
	quest = quest .. task[7] .. spc .. "\(\frac{1}{" .. tostring(part[ind]) .. "}\)" .. spc .. task[5] .. "?"	
end	
	      
	