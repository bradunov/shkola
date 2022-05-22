
letter = {"a", "b", "c", "m", "n", "p", "x", "y", "z"}

numb = 1 + math.random(9)
grd = 1 + math.random(4)

ch = math.random(3)
sg = math.random(2)

if (ch < 3) then
    if (ch == 1) then
        base = tostring(numb)
    else	
        base = letter[numb-1]
    end	
    if (sg == 1) then 
	    base = "-" .. base
    end		
else
    denom = math.random(numb-1)
    qq = lib.math.gcd(denom, numb)
	denom = math.floor(denom/qq)
	numb = math.floor(numb/qq)
    if (sg == 1) then 
	    denom = -denom
    end		
    base = "\(\frac{" .. tostring(denom) .."}{" .. tostring(numb) .. "}\)"
end

quest = "(" .. base .. ")"
for i = 2, grd do
    quest = quest .. " * " .. "(" .. base .. ")"
end	    
            
answ = ""
if (ch < 3) then
    answ = lib.check_string(base,20)
else
    answ = lib.check_fraction_simple(denom, numb)
end           
                   