
bracketl = "{"
bracketr = "}"

uni = "∪"  
sect = "∩"
dif = "∖" 
empt = "∅"
n0 = "N₀"  
nn = "N"
elem = "∈"  

op1 = "≤" 
op2 = "≥"
op3 = ">"
op4 = "<"


reply = {""}
solut = {}

numb = 2 + math.random(4)
numba = numb + 1
numbc = numb - 1
solut[1] = "A = " .. bracketl .. " a | " .. "a" .. elem .. nn .. ",  a" .. op4 .. numba .. " " .. bracketr 
solut[2] = "B = " .. bracketl .. " b | " .. "b" .. elem .. n0 .. ", b" .. op1 .. numb .. " " .. bracketr 
solut[3] = "C = " .. bracketl .. " c | " .. "c" .. elem .. nn .. ", c" .. op3 .. numbc .. " " .. bracketr 

stampa = 3
total = 8
choice = {}
q = {}
for i = 1,total do
    q[i] = i
end
choice = lib.math.random_shuffle(q)	

for i = 1,stampa do
	jmin = 1
	jmax = numb	
	if (choice[i] == 1) then           --[[ (AuB)\(ApC)]]--
		jmax = numbc
	    reply[i] = "(A " .. uni .. " B) " .. dif .. " (A " .. sect .. " C) = " .. bracketl .. " " .. lib.check_string("0",10) .. ", " 
	end				
	if (choice[i] == 2) then            --[[ (ApB)\(BpC)]]--
		jmax = numbc
	    reply[i] = "(A " .. sect .. " B) " .. dif .. " (B " .. sect .. " C) = " .. bracketl .. " "  
	end	
	if (choice[i] == 3) then            --[[ (A\B)u(A\C)]]--
		jmax = numbc
	    reply[i] = "(A " .. dif .. " B) " .. uni .. " (A " .. dif .. " C) = " .. bracketl .. " " 
	end	
	if (choice[i] == 4) then            --[[ (AuB)\(AuC)]]--
		jmax = 0
	    reply[i] = "(A " .. uni .. " B) " .. dif .. " (A " .. uni .. " C) = " .. bracketl .. " " .. lib.check_string("0",10) .. " " .. bracketr 
	end	
	if (choice[i] == 5) then            --[[(ApB)u(A\C)]]--
		jmax = numb
	    reply[i] = "(A " .. sect .. " B) " .. uni.. " (A " .. dif .. " C) = " .. bracketl .. " " 
	end		
	if (choice[i] == 6) then            --[[ ((AuB)\(ApC))\(BpC)]]--
		jmax = numbc
	    reply[i] = "((A " .. uni .. " B) " .. dif .. " (A " .. sect .. " C)) " .. dif .. " (B " .. sect .. " C) = " .. bracketl .. " " .. lib.check_string("0",10) .. ", "
	end	
	if (choice[i] == 7) then            --[[ (AuB)\((ApC)\(BpC))]]--
		jmax = numb
	    reply[i] = "(A " .. uni .. " B) " .. dif .. " ((A " .. sect .. " C) " .. dif .. " (B " .. sect .. " C)) = " .. bracketl .. " " .. lib.check_string("0",10) .. ", "
	end	
	if (choice[i] == 8) then            --[[ (B\A)\(C\B)]]--
		jmax = 0
	    reply[i] = "(B " .. dif .. " A) " .. dif .. " (C " .. dif .. " B) = " .. bracketl .. " " .. lib.check_string("0",10) .. " " .. bracketr 
	end		
	
    if (jmax ~= 0) then		
        for j = jmin, jmax do
		    if ( j == jmax) then
		        reply[i] = reply[i] .. lib.check_number(j,10) ..  " " .. bracketr 
		    else
		        reply[i] = reply[i] .. lib.check_number(j,10) ..  ", "   
            end  	
        end			
    end		
	
end	
