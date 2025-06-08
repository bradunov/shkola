
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
op5 = "="

solut = {}
answ1 = {}
answ2 = {}


numb = 2 + math.random(4)
numba = numb + 1
numbc = numb - 1
solut[1] = "A = " .. bracketl .. " a | " .. "a" .. elem .. nn .. ",  a" .. op4 .. numba .. " " .. bracketr 
solut[2] = "B = " .. bracketl .. " b | " .. "b" .. elem .. n0 .. ", b" .. op1 .. numb .. " " .. bracketr 
solut[3] = "C = " .. bracketl .. " c | " .. "c" .. elem .. nn .. ", c" .. op3 .. numbc .. " " .. bracketr 


total = 6
choice = math.random(total)	
ind1 = 0
ind2 = 0
if (choice == 1) then           --[[ A\C, C\A ]]--	
    name1 = "G = A " .. dif .. " C = " 
    reply1 = bracketl .. " g | " .. lib.check_number(1,10) .. " " .. op1 .. " g " .. op1 .. " " .. lib.check_number(numbc,10) .. " " .. bracketr 	
    name2 = "H = C " .. dif .. " A = " 
    reply2 = bracketl .. " h | h " .. op2 .. " " .. lib.check_number(numba,10) .. " " .. bracketr 	
end

if (choice == 2) then           --[[ A\B, B\A]]--
    name1 = "G = A " .. dif .. " B = " 
    reply1 =  bracketl .. " g | g " .. op5 .. " " .. lib.check_string("",10) .. " " .. bracketr 	
	ind1 = 1
	name2 = "H = B " .. dif .. " A = " 
    reply2 = bracketl .. " h | h " .. op5 .. " " .. lib.check_number(0,10) .. " " .. bracketr 	
end

if (choice == 3) then           --[[ B\C, C\B]]--
    name1 = "G = B " .. dif .. " C = "  
    reply1 = bracketl .. " g | " .. lib.check_number(0,10) .. " " .. op1 .. " g " .. op1 .. " " .. lib.check_number(numbc,10) .. " " .. bracketr 	
    name2 = "H = C " .. dif .. " B = " 
    reply2 = bracketl .. " h | h " .. op2 .. " " .. lib.check_number(numba,10) .. " " .. bracketr 	
end
	
if (choice == 4) then            --[[ AuB, ApB]]--
    name1 = "G = A " .. uni .. " B = " 
    reply1 = bracketl .. " g | " .. lib.check_number(0,10) .. " " .. op1 .. " g " .. op1 .. " " .. lib.check_number(numb,10) .. " " .. bracketr 		
    name2 = "H = A " .. sect .. " B = " 
    reply2 = bracketl .. " h | " .. lib.check_number(1,10) .. " " .. op1 .. " g " .. op1 .. " " .. lib.check_number(numb,10) .. " " .. bracketr 		
end

if (choice == 5) then            --[[ AuC, ApC ]]--
    name1 = "G = A " .. uni .. " C = " 
    reply1 = bracketl .. " g | g " .. op2 .. " " .. lib.check_number(1,10) .. " " .. bracketr 	
    name2 =  "H = A " .. sect .. " C = " 
    reply2 = bracketl .. " h | h " .. op5 .. " " .. lib.check_number(numb,10) .. " " .. bracketr 	
end
	
if (choice == 6) then            --[[ BuC, BpC ]]--
    name1 = "G = B " .. uni .. " C = " 
    reply1 = bracketl .. " g | g " .. op2 .. " " .. lib.check_number(0,10) .. " " .. bracketr 	
	name2 = "H = B " .. sect .. " C = "
    reply2 = bracketl .. " h | h " .. op5 .. " " .. lib.check_number(numb,10) .. " " .. bracketr 	
end	
	
answ1[1] = name1 .. reply1
answ1[2] = name1 .. empt
answ2[1] = name2 .. reply2
answ2[2] = name2 .. empt
