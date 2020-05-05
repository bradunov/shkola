
measure1 = {"m", "kg" , "h", "km", "t"}
measure2 = {"mm", "g", "min.", "m", "kg"}

denom = {2,4,5,10}
index = math.random(4)
imenilac = denom[index]
brojilac = math.random(imenilac-1)

if (ITEM == 3) then
    min_orig = (60 * brojilac) / imenilac
    min = min_orig + math.random(10) - 5
else
    min_orig = (1000 * brojilac) / imenilac
    min = min_orig + math.random(10) - 5
end

ind = math.random(2)
if (ind == 1) then
    if (min_orig == min) then
        znak = "="
	else	
	    if (min > min_orig) then
            znak = "<"
        else
            znak = ">"
		end	
    end
    answ = "\(\frac{" .. tostring(brojilac) .. "}{" .. tostring(imenilac) .. "}\) " .. measure1[ITEM] .. " " .. lib.check_string(znak,15) .. " " .. tostring(math.floor(min)) .. " " .. measure2[ITEM]
else
	if (min_orig == min) then
        znak = "="
	else   
	    if (min > min_orig) then
            znak = ">"
        else
            znak = "<"
		end   
    end
    answ = tostring(math.floor(min)) .. " " .. measure2[ITEM] .. " " .. lib.check_string(znak,15) .. " " .. "\(\frac{" .. tostring(brojilac) .. "}{" .. tostring(imenilac) .. "}\) " .. measure1[ITEM] 
end	                      
                 