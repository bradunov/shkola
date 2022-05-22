
letter = {"a", "b", "c", "m", "n", "p", "x", "y", "z"}
grd = {}

numb = 1 + math.random(9)

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

grd[1] = 3 + math.random(8)
grd[2] = 1 + math.random(grd[1]-3)
sum = grd[1] - grd[2]

answ = ""
if (ch < 3) then
    answ = lib.check_string(base,20)
else
    answ = lib.check_fraction_simple(denom, numb)
end           
           