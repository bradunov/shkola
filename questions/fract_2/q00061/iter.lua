
answ = {"=", "<", ">"}

min = 3
max = 6

ind1 = math.random(3)

if (ind1 < 3) then
    fact = 10^ind1
    min_range = min*fact
    max_range = max*fact
    numb1 = (min_range - math.random(max_range))/fact
    if (numb1 == 0) then
	    numb1 = min - max
    end		
	quest1 = lib.dec_to_str(numb1)
else
    imen1 = min + math.random(max)
    broj1 = min - math.random(max)
    if (broj1 == 0) then
	    broj1 = min - max
    end		
    numb1 = broj1/imen1
	if (broj1 < 0) then
	    quest1 = "- \(\frac{" .. math.abs(broj1) .. "}{" .. imen1 .. "}\)"		
    else	
        quest1 = "\(\frac{" .. broj1 .. "}{" .. imen1 .. "}\)"	
	end	
end	

ind2 = math.random(3)

if (ind2 < 3) then
    fact = 10^ind2
    min_range = min*fact
    max_range = max*fact
    numb2 = (math.random(max_range) - min_range)/fact
    if (numb2 == 0) then
	    numb2 = max - min
    end		
	quest2 = lib.dec_to_str(numb2)	
else
    imen2 = min + math.random(max)
    broj2 = math.random(max) - min
    if (broj2 == 0) then
	    broj2 = max - min
    end		
    numb2 = broj2/imen2
	if (broj2 < 0) then
	    quest2 = "- \(\frac{" .. math.abs(broj2) .. "}{" .. imen2 .. "}\)"		
    else		
	    quest2 = "\(\frac{" .. broj2 .. "}{" .. imen2 .. "}\)"		
    end		
end	

if (numb1 < numb2) then 
    sign = "<"
else
    if (numb1 > numb2) then
        sign = ">"
	else
        sign = "="
    end
end	
	
                 
