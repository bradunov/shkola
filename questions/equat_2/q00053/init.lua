 
include("terms") 

msg = {"jesu",  "nisu"}

rel = {" < ", " > ", " ≤ ", " ≥ "}
brac = {"(", ")", "[", "]"}

num = {}
partx = ""
partinx = ""

number = {}
free = "" 
termx = ""
terminx = ""

ineq = {""}
sol = {""}
reply = ""

opqu = math.random(4)
if (opqu < 3) then
    opcont = 3 - opqu
else	
    opcont = 7 - opqu
end

sg = math.random(2)
num[1] = math.random(9)
if (sg == 2) then
    num[1] = - num[1]
end	
num[2] = 10 - math.random(19)

if (math.abs(num[1]) ~= 1) then
	partx = num[1] 
	partinx = -num[1]	
else
    if (num[1] == -1) then
        partx = "- "
	else
        partinx = "- "	
    end
end	
partx = partx .. " x "	
partinx = partinx .. " x "
ineq[1] = partx
if (num[2] ~= 0) then 
	if (num[2] > 0) then 
		ineq[1] = ineq[1] .. " + " .. num[2] 
	else
		ineq[1] = ineq[1] .. " - " .. math.abs(num[2])
    end		
end	
ineq[1] = ineq[1] .. rel[opqu] .. " 0 "   
sol[1] = "x " 
if (num[1] > 0) then
    sol[1] = sol[1] .. lib.check_one_option_dropdown(rel, rel[opqu])
	denom = num[1]
	enum = num[2]
else	
    sol[1] = sol[1] .. lib.check_one_option_dropdown(rel, rel[opcont])
	denom = -num[1]
	enum = -num[2]	
end
qq = lib.math.gcd(enum, denom)
enum = math.floor(enum/qq)
denom = math.floor(denom/qq)
val = -enum/denom
rest = 10*val - math.floor(10*val)
if (rest == 0) then
	sol[1] = sol[1] .. " " .. lib.check_number(lib.math.round_dec(val,1)) 		
else	
	condit = "is_ok = math.eq(numerator/denominator, "..tostring(val)..");"	
	solut = "numerator="..tostring(-enum)..";denominator="..tostring(denom)..";"
	sol[1] = sol[1] .. " " ..  lib.check_fraction_condition(condit, nil, nil, solut)
end

num[3] = 1  

operqu = opqu
opercont = opcont
if (opqu < 3) then
	op = math.random(2)
else
	op = 2 + math.random(2)
end  

termx = partx
terminx = partinx
for i = 1,3 do
    number[i] = num[i]
end	
ch = -1 + math.random(3)       --[[ ch = 0 num[i], ch=1  num[i]= -num[3]*num[i], ch=2  num[i]= num[3]*num[i], i=1,2]]--
if (ch > 0) then
	number[3] = 1 + math.random(4)
	if (ch == 1) then
		number[3] = - number[3]
		operqu = opcont
		opercont = opqu		
	end	
	for i = 1,2 do
		number[i] = number[3] * num[i]	
	end	
	termx = number[1] .. " x "
	terminx = -number[1] .. " x "		
end

ind = math.random(4)

if (ind == 1) then
	if (number[2] ~= 0) then
        mod = math.random(8)		
		if (mod < 5) then
			free = -number[2]
			if (op == operqu) then
				reply = msg[1]
			else
				reply = msg[2]		
			end
		else	
			free = number[2]
			reply = msg[2]			
		end	
		if (free < 0) then
			ineq[2] = termx .. " + "
        else
			ineq[2] = termx .. " - "	
        end			
		ineq[2] = ineq[2] .. math.abs(free) 
		imen = number[1]
	else
	    mod = math.random(4)
	    free = 0
		if (op == opercont) then
			reply = msg[1]
		else
			reply = msg[2]		
		end
		ineq[2] = terminx 	
		imen = - number[1]		
	end	
end  
 
if (ind == 2) then
    mod = math.random(8)	
	if (mod < 5) then
		free = number[2]	
		if (op == opercont) then
			reply = msg[1]
		else
			reply = msg[2]		
		end
	else
		free = -number[2]
		if (number[2] == 0 and op == opercont) then
			reply = msg[1]
		else
			reply = msg[2]		
		end
    end	
	ineq[2] = terminx	
	if (free ~= 0) then
		if (free < 0) then
			ineq[2] = terminx .. " + "
		else
			ineq[2] = terminx .. " - "	
		end		
		ineq[2] = ineq[2] .. math.abs(free)
	end	

	imen = -number[1]
end 
  
if (ind == 3) then
    mod = math.random(8)
	free = number[2]
	ineq[2] = free
	if (mod < 5) then
		if (op == operqu) then
		    reply = msg[1]
		else
		    reply = msg[2]		
	    end
		if (number[1] < 0) then
			ineq[2] = ineq[2] .. " - " .. terminx
		else
			ineq[2] = ineq[2] .. " + " .. termx
		end	
		imen = -number[1]		
	else
		if (number[2] == 0 and op == opercont) then
			reply = msg[1]
		else
			reply = msg[2]		
		end		
		if (number[1] < 0) then
			ineq[2] = ineq[2] .. " + " .. terminx
		else
			ineq[2] = ineq[2] .. " - " .. termx
		end			
		imen = number[1]		
	end	
	
end   

if (ind == 4) then
    mod = math.random(8)
	free = - number[2]
	ineq[2] = free	
	if (mod < 5) then
		if (op == opercont) then
		    reply = msg[1]
		else
		    reply = msg[2]		
	    end
		if (number[1] < 0) then
			ineq[2] = ineq[2] .. " + " .. terminx
		else
			ineq[2] = ineq[2] .. " - " .. termx
		end			
		imen = number[1]		
	else
		if (number[2] == 0 and op == operqu) then
			reply = msg[1]
		else
			reply = msg[2]		
		end
		if (number[1] < 0) then
			ineq[2] = ineq[2] .. " - " .. terminx
		else
			ineq[2] = ineq[2] .. " + " .. termx
		end			
		imen = -number[1]		
	end	
	
end   
ineq[2] = ineq[2] .. rel[op] .. " 0"
	
broj = free
if (op < 3) then	
	opinv = 3 - op
else	
	opinv = 7 - op
end
if (imen < 0) then
    imen = - imen
	broj = - free
	tmp = op
	op = opinv
	opinv = tmp
end	

sol[2] = "x " 
if (ind < 3) then
    sol[2] = sol[2] .. lib.check_one_option_dropdown(rel, rel[op]) 
else	
    sol[2] = sol[2] .. lib.check_one_option_dropdown(rel, rel[opinv])  
end
qq = lib.math.gcd(broj, imen)
broj = math.floor(broj/qq)
imen = math.floor(imen/qq)
value = broj/imen
rest = 10*value - math.floor(10*value)
if (rest == 0) then
	sol[2] = sol[2] .. " " .. lib.check_number(lib.math.round_dec(value,1)) 		
else	
	condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"	
	solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
	sol[2] = sol[2] .. " " ..  lib.check_fraction_condition(condition, nil, nil, solution)
end
         
--[[
    a x + b = 0,     a, c: =/= 0,    b: >, =, < 0, 
    a x = - b            			ind = 1 , mod = 1, 2, 3, 4,     
				ax = b,                         mod = 5, 6, 7, 8,
	- a x = b              			ind = 2
	            - a x = - b
	b = - a x         				ind = 3	
	            b = a x	
	 - b = a x                      ind = 4
	 	        - b = - a x
				
#	uopstenje prethodnog          ch = 0:    c = 1
                                  ch = 1:    c < -1
                                  ch = 1:    c > 1								  
    c (a x + b) = 0            	   c < 0  opqu -> opcont
	
]]--
	         