
letter = {"a", "b", "c", "m", "n", "p", "x", "y", "z"}
letter1 = {"-a", "-b", "-c", "-m", "-n", "-p", "-x", "-y", "-z"}
oper = {" * ", " : "}

bracl = "\(\bigl(\)"
bracr = "\(\bigl)\)"

grd = {}
number = {""}

numb = 1 + math.random(9)

ch = math.random(3)
sg = math.random(4)

if (ch < 3) then
    if (ch == 1) then
        base = tostring(numb)
        base1 = tostring(-numb)		
    else	
        base = letter[numb-1]
        base1 = letter1[numb-1]		
    end	
else
    denom = math.random(numb-1)
    qq = lib.math.gcd(denom, numb)
	denom = math.floor(denom/qq)
	numb = math.floor(numb/qq)
    if (numb == 1) then	
        base = tostring(denom)
        base1 = tostring(-denom)
        ch = 1
    else		
		base = "\(\frac{" .. tostring(denom) .."}{" .. tostring(numb) .. "}\)"
		base1 = "\(\frac{" .. tostring(-denom) .."}{" .. tostring(numb) .. "}\)"	
    end
end	
for i = 1,3 do
    number[i] = base	
end
if (sg == 2) then
	number[1] = base1
end	
if (sg > 1) then
	number[2] = base1
end		
if (sg - 2*math.floor(sg/2) == 0) then 
	number[3] = base1		
end


ind = math.random(2)
op = math.random(2) 

grd[1] = 4 + math.random(7)
grd[2] = 1 + math.random(grd[1]-4)

if (op == 1) then
    sum = grd[1] + grd[2]
else
    sum = grd[1] - grd[2]	
end
if (ind == 1) then
    grd[3] = math.random(sum-2)
else
    grd[3] = sum + 1 + math.random(6)
end	

quest = ""
if (ind == 1) then
    if (grd[3] == 1) then
		quest = lib.frac_start() .. " (" .. number[1] .. ")\(^{" .. grd[1]  .. "}\) " .. oper[op] .. " (" .. number[2] .. ")\(^{" .. grd[2]  .. "}\) " .. lib.frac_mid() .. " (" .. number[3] .. ")" .. lib.frac_end()
    else	
		quest = lib.frac_start() .. " (" .. number[1] .. ")\(^{" .. grd[1]  .. "}\) " .. oper[op] .. " (" .. number[2] .. ")\(^{" .. grd[2]  .. "}\) " .. lib.frac_mid() .. " (" .. number[3] .. ")\(^{" .. grd[3]  .. "}\)" .. lib.frac_end()
    end
	if (op == 1) then
        val = grd[1] + grd[2] - grd[3]
    else
        val = grd[1] - grd[2] - grd[3]	
	end	
else
    quest = lib.frac_start() .. "(" .. number[3] .. ")\(^{" .. grd[3]  .. "}\) " .. lib.frac_mid() .. " (" .. number[1] .. ")\(^{" .. grd[1]  .. "}\) " .. oper[op] .. " (" .. number[2] .. ")\(^{" .. grd[2]  .. "}\) " .. lib.frac_end() 
    if (op == 1) then
        val = grd[3] - grd[1] - grd[2]
    else
        val = grd[3] - grd[1] + grd[2]	
	end	
end	
	
sign = ""
check =  0
if (sg == 2) then
    check = grd[1] + grd[2] + grd[3]
end	
if (sg == 3) then
    check = grd[2] 
end
if (sg == 4) then
    check = grd[2] + grd[3]
end
rest = check - 2 * math.floor(check/2)
if (rest ~= 0) then
    sign = "-"
end	
		
answ = lib.check_string(sign,10) .. " " 
if (ch < 3) then
    answ = answ .. "(" .. lib.check_string(base,20) .. ")"
else
    answ = answ .. "(" .. lib.check_fraction_simple(denom, numb) .. ")"
end  	   
            