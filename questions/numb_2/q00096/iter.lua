
grd = {}
out = {""}
number = {""}

numb = 1 + math.random(8)

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
	numb = math.floor(numb/qq) 	
	denom = math.floor(denom/qq)
	denmin = -denom   	
	base = "\(\frac{" .. tostring(denom) .."}{" .. tostring(numb) .. "}\)"
	base1 = "\(\frac{" .. tostring(denmin) .."}{" .. tostring(numb) .. "}\)"		
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

for i = 1,3 do
    out[i] = "\(^{" .. grd[i].. "}\) "
end	

miss = math.random(3)

if (miss == 1) then
    rest = grd[1] - 2*math.floor(grd[1]/2)
    if (ch == 3) then	
		if (sg == 2 and rest ~= 0) then
			number[1] = lib.frac_start() .. lib.check_number(denmin, 20) .. lib.frac_mid() .. lib.check_number(numb,20) .. lib.frac_end()
		else	
			number[1] = lib.frac_start() .. lib.check_number(denom, 20) .. lib.frac_mid() .. lib.check_number(numb,20) .. lib.frac_end()		
		end						
	else	
		if (sg == 2 and rest ~= 0) then		
			number[1] = lib.check_string(base1, 20)
		else
			number[1] = lib.check_string(base, 20)	
		end						
    end	
    out[1] = lib.sup_start() .. lib.check_number(grd[1], 15)	.. lib.sup_end()
end	
if (miss == 2) then
    rest = grd[2] - 2*math.floor(grd[2]/2)
    if (ch == 3) then		
		if (sg > 1 and rest ~= 0 ) then
			number[2] = lib.frac_start() .. lib.check_number(denmin, 20) .. lib.frac_mid() .. lib.check_number(numb,20) .. lib.frac_end()
		else	
			number[2] = lib.frac_start() .. lib.check_number(denom, 20) .. lib.frac_mid() .. lib.check_number(numb,20) .. lib.frac_end()		
		end						
	else	
		if (sg > 1 and rest ~= 0) then		
			number[2] = lib.check_string(base1, 20)
		else
			number[2] = lib.check_string(base, 20)	
		end			
    end	
    out[2] = lib.sup_start() .. lib.check_number(grd[2], 15)	.. lib.sup_end()
end	
if (miss == 3) then
    rest = grd[3] - 2*math.floor(grd[3]/2)
	tmp = sg - 2*math.floor(sg/2)
    if (ch == 3) then	
		if (tmp == 0 and rest ~= 0) then
			number[3] = lib.frac_start() .. lib.check_number(denmin, 20) .. lib.frac_mid() .. lib.check_number(numb,20) .. lib.frac_end()
		else	
			number[3] = lib.frac_start() .. lib.check_number(denom, 20) .. lib.frac_mid() .. lib.check_number(numb,20) .. lib.frac_end()		
		end					
	else
		if (tmp == 0 and rest ~= 0) then		
			number[3] = lib.check_string(base1, 20) 
		else
			number[3] = lib.check_string(base, 20)
		end	    		
    end	
    out[3] = lib.sup_start() .. lib.check_number(grd[3], 15)	.. lib.sup_end()
end	

frc = math.random(2)
quest = ""

if (ind == 1) then
	if (grd[3] == 1 and miss ~= 3) then
		if (frc == 2) then
			quest = bracl .. "(" .. number[1] .. ")" .. out[1]  .. " " .. oper[op] .. " (" .. number[2] .. ")" .. out[2]  ..  bracr .. " : (" .. number[3] .. ")"
		else
			broj = "(" .. number[1] .. ")" .. out[1]  .. " " .. oper[op] .. " (" .. number[2] .. ")" .. out[2] 
			imen = " (" .. number[3] .. ")"
			quest = lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end()	
        end			
	else
     	if (frc == 2) then	
			quest = bracl .. "(" .. number[1] .. ")" .. out[1]  .. " " .. oper[op] .. " (" .. number[2] .. ")" .. out[2]  .. bracr .. " : (" .. number[3] .. ")" .. out[3]
	    else
			broj = "(" .. number[1] .. ")" .. out[1]  .. " " .. oper[op] .. " (" .. number[2] .. ")" .. out[2] 
			imen = " (" .. number[3] .. ")" .. out[3]
			quest = lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end()
		end	
    end		
	if (op == 1) then
        val = grd[1] + grd[2] - grd[3]
    else
        val = grd[1] - grd[2] - grd[3]	
	end	
else
    if (frc == 2) then
        quest = "(" .. number[3] .. ")" .. out[3]  .. " : " .. bracl .. "(" .. number[1] .. ")" .. out[1]  .. " " .. oper[op] .. " (" .. number[2] .. ")" .. out[2]  .. bracr 
    else	
	    broj = "(" .. number[3] .. ")" .. out[3]
		imen =  "(" .. number[1] .. ")" .. out[1]  .. " " .. oper[op] .. " (" .. number[2] .. ")" .. out[2]  
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
		
answ = sign .. " " 
if (ch < 3) then
    answ = answ .. "(" .. base .. ")"
else
    answ = answ .. bracl .. "\(\frac{" .. denom .. "}{" .. numb .. "}\)" .. bracr 
end 
answ = answ .. "\(^{" .. val  .. "}\)"   		      
          