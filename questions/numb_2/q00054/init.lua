
bracketl = "{"
bracketr = "}"

uni = "\(\small\cup\)"  
sect = "\(\small\cap\)"
dif = "\"  
empt = "\(\small\emptyset\)"
n0 = "\(\small N_0\)"  
nn = "\(\small N\)"
elem = "\(\small\in\)"  

op1 = "\(\small\leq\)" 
op2 = "\(\small\geq\)"
op3 = "\(\small\gt\)"
op4 = "\(\small\lt\)"

reply = {""}
solut = {}

numb = 2 + math.random(4)
numba = numb + 1
numbc = numb - 1
solut[1] = "A = " .. bracketl .. " a | " .. "a" .. elem .. nn .. ",  a" .. op4 .. numba .. " " .. bracketr 
solut[2] = "B = " .. bracketl .. " b | " .. "b" .. elem .. n0 .. ", b" .. op1 .. numb .. " " .. bracketr 
solut[3] = "C = " .. bracketl .. " c | " .. "c" .. elem .. nn .. ", c" .. op3 .. numbc .. " " .. bracketr 

stampa = 4
total = 10
choice = {}
q = {}
for i = 1,total do
    q[i] = i
end
choice = lib.math.random_shuffle(q)	

for i = 1,stampa do
	jmin = 1
	jmax = numb	

	if (choice[i] == 1) then           --[[ A\(BpC)]]--
		jmax = numbc
	    reply[i] = "A " .. dif .. " (B " .. sect .. " C) = " .. bracketl .. " " 
	end	
	if (choice[i] == 2) then            --[[ (AuC)pB)]]--
		jmax = numb
	    reply[i] = "(A " .. uni .. " C) " .. sect .. " B = " .. bracketl .. " " 
	end	
	if (choice[i] == 3) then            --[[ B\(AuC) ]]--
		jmax = 0
	    reply[i] = "B " .. dif .. " (A " .. uni .. " C) = " .. bracketl .. " " .. lib.check_string("0",10) .. " " .. bracketr
	end	
	if (choice[i] == 4) then            --[[ (AuB)\C ]]--
		jmax = numbc
	    reply[i] = "(A " .. uni .. " B) " .. dif .. " C = " .. bracketl .. " " .. lib.check_string("0",10) .. ", " 
	end		
	if (choice[i] == 5) then            --[[ (AuB)pC ]]--
		jmax = 0
	    reply[i] = "(A " .. uni .. " B) " .. sect .. " C = " .. bracketl .. " " .. lib.check_number(numb,10) .. " " .. bracketr
	end	
	if (choice[i] == 6) then            --[[  Au(B\C)]]--
		jmax = numb
	    reply[i] = "A " .. uni .. " (B " .. dif .. " C) = " .. bracketl .. " " .. lib.check_string("0",10) .. ", " 
	end		
	if (choice[i] == 7) then           --[[ Ap(B\C)]]--
		jmax = numbc
	    reply[i] = "A " .. sect .. " (B " .. dif .. " C) = " .. bracketl .. " " 
	end		
	if (choice[i] == 8) then            --[[ B\(C\A)]]--
		jmax = numb
	    reply[i] = "B " .. dif .. " (C " .. dif .. " A) = " .. bracketl .. " " .. lib.check_string("0",10) .. ", "
	end	
	if (choice[i] == 9) then            --[[ A\(C\B)]]--
		jmax = numb
	    reply[i] = "A " .. dif .. " (C " .. dif .. " B) = " .. bracketl .. " " 
	end	
	if (choice[i] == 10) then            --[[ (B\A)\C]]--
		jmax = 0
	    reply[i] = "(B " .. dif .. " A) " .. dif .. " C = " .. bracketl .. " " .. lib.check_string("0",10) .. " " .. bracketr 
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



 


          
          
    
    
                  
                
                