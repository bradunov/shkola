
letter = {"a", "b", "c", "m", "n", "p", "x", "y", "z"}
oper = {" * ", " : "}
grd = {}
number = {""}

numb = 1 + math.random(9)

ch = math.random(3)
sg = math.random(3)

if (ch < 3) then
    if (ch == 1) then
        base = tostring(numb)
    else	
        base = letter[numb-1]
    end	
    if (sg == 1) then 
	    number[1] = base
	    number[2] = base		
    end		
    if (sg == 2) then 
	    number[1] = "-" .. base
	    number[2] = "-" .. base		
    end		
    if (sg == 3) then 
	    number[1] = base
	    number[2] = "-" .. base		
    end		
else
    denom = math.random(numb-1)
    qq = lib.math.gcd(denom, numb)
	denom = math.floor(denom/qq)
	numb = math.floor(numb/qq)
    base = "\(\frac{" .. tostring(denom) .."}{" .. tostring(numb) .. "}\)"
    base1 = "\(\frac{" .. tostring(-denom) .."}{" .. tostring(numb) .. "}\)"	
    if (sg == 1) then 
	    number[1] = base
	    number[2] = base		
    end		
    if (sg == 2) then 
	    number[1] = base1
	    number[2] = base1		
    end		
    if (sg == 3) then 
	    number[1] = base
	    number[2] = base1		
    end		
end

grd[1] = 3 + math.random(8)
grd[2] = 1 + math.random(grd[1]-3)
sum = grd[1] - grd[2]

op = math.random(2)
if (op == 1) then
	tmp = grd[1]
	grd[1] = sum
	sum = tmp
end

sign = ""
rest = 0
if (sg == 2) then
    rest = sum - 2 * math.floor(sum/2)
end	
if (sg == 3) then
    rest = grd[2] - 2 * math.floor(grd[2]/2)
end	
if (rest ~= 0) then
    sign = "-"
end	

answ = lib.check_string(sign,10) .. " " 
if (ch < 3) then
    answ = answ .. "(" .. lib.check_string(base,20) .. ")"
else
    answ = answ .. "(" .. lib.check_fraction_simple(denom, numb) .. ")"
end           
             