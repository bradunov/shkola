
letter = {"a", "b", "c", "m", "n", "p", "x", "y", "z"}

numb = 1 + math.random(6)
grd = 1 + math.random(3)

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

numb2 = 2 + math.random(6)
grd2 = 1 + math.random(5)

if (ch == 2 and numb2 == numb) then
    numb2 = numb2 - 1
end	

base2 = letter[numb2-1]
sg = math.random(2)
if (sg == 2) then 
	base2 = "-" .. base2
end	

quest = "{" .. base .. ")"
for i = 2, grd do
    quest = quest .. " * " .. "(" .. base .. ")"
end
for i = 1, grd2 do
    quest = quest .. " * " .. "(" .. base2 .. ")"
end		    
            
answ = ""
answ2 = ""
if (ch < 3) then
    answ = lib.check_string(base,15)  
else
    answ = lib.check_fraction_simple(denom, numb) 
end           
answ2 = lib.check_string(base2,15)                             
    