
oper = {" * ", " : "}

bracl = "\(\bigl(\)"
bracr = "\(\bigl)\)"

grd = {}
out = {}
number = {""}
check = {}

ind = math.random(2)
op = math.random(2) 

ch = math.random(2)
sg = math.random(4)

grd[1] = 4 + math.random(6)
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

numb = 1 + math.random(4)
denom = numb
enum = math.random(numb-1)	
qq = lib.math.gcd(enum, denom)
denom = math.floor(denom/qq)
enum = math.floor(enum/qq)
if (ch == 1) then
    enum = 1
end	

stampa = 2
for i = 1,3 do
    out[i] = grd[i]
	check[i] = 0
end
if (enum == 1) then 
	for j = 1,stampa do
		for i = 1,3 do
			tmp = math.floor(out[i]/2)
			rest = out[i] - 2 * tmp
			if (rest == 0 and tmp ~= 0) then    
				out[i] = tmp                    
				check[i] = check[i] + 1
			end	
		end
	end	
end	
	 
if (ch == 1) then
    base = tostring(numb)
	base1 = tostring(-numb)
	for i = 1,3 do
		if (check[i] ~= 0) then
			number[i] = tostring(math.floor(numb ^ (2* check[i])))	
        else
            number[i] =  base  		
		end
	end		
else
    base = "\(\frac{" .. tostring(enum) .."}{" .. tostring(denom) .. "}\)"
    base1 = "\(\frac{" .. tostring(-enum) .."}{" .. tostring(denom) .. "}\)"	
	for i = 1,3 do
		number[i] =  base  
		if (enum == 1 and check[i] ~= 0) then
		    den = math.floor(denom ^ (2* check[i]))
			number[i] = "\(\frac{" .. tostring(enum) .."}{" .. tostring(den) .. "}\)"	
		end
	end	
end
if (check[1] == 0 and sg == 2) then 
	number[1] = base1		
end	
if (check[2] == 0 and sg > 1) then 
	number[2] = base1		
end	
if (check[3] == 0 and sg - 2*math.floor(sg/2) == 0) then 
	number[3] = base1		
end		

term1 = " (" .. number[1] .. ") "
if (out[1] ~= 1) then
	term1 = term1 .. "\(^{" .. out[1]  .. "}\) "
end		
term2 = " (" .. number[2] .. ") "
if (out[2] ~= 1) then
	term2 = term2 .. "\(^{" .. out[2]  .. "}\) "
end	
term3 = " (" .. number[3] .. ") "
if (out[3] ~= 1) then
	term3 = term3 .. "\(^{" .. out[3]  .. "}\) "
end
quest = ""	
frc = math.random(2)
if (ind == 1) then	
    if (frc == 2) then
		quest = bracl .. term1 .. oper[op] .. term2 .. bracr .. " : " .. term3	
	else	
		broj = term1 .. oper[op] .. term2 
		imen =  term3
		quest = lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end()
    end
	if (op == 1) then
        val = grd[1] + grd[2] - grd[3]
    else
        val = grd[1] - grd[2] - grd[3]	
	end	
else
    if (frc == 2) then
		quest = term3 .. " : " .. bracl .. term1 .. oper[op] .. term2 .. bracr 
	else	
		broj = term3  
		imen =  term1 .. oper[op] .. term2
		quest = lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end()
    end		
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
		
answ = sign .. " (" .. base .. ")" 
         