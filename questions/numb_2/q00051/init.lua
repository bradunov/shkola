
include("terms")
  
uni = "∪"  
sect = "∩"
dif = "∖"
empt = "∅"

reply = {""}
solut = {}
choice = {}

stampa = 6
total = 16

q = {}
for i = 1,total do
    q[i] = i
end
choice = lib.math.random_shuffle(q)	

for i = 1,stampa do

    if (choice[i] == 1) then
	    solut[i] = "A " .. dif .. " " .. empt .. " = " .. " A" 
		reply[i] = ch[1]
	end
	if (choice[i] == 2) then
	    solut[i] = "A " .. uni .. " " .. empt .. " = " .. " A"
	    reply[i] = ch[1]
	end			
	if (choice[i] == 3) then
	    solut[i] = "A " .. sect .. " " .. empt .. " = " .. " A"
	    reply[i] = ch[2]
	end			
	if (choice[i] == 4) then
	    solut[i] = empt .. " " .. dif .. " A " .. " = " .. " A"
	    reply[i] = ch[2]
	end	
	if (choice[i] == 5) then
	    solut[i] = "A " .. dif .. " (A " .. dif .. " A) = " .. " A"
	    reply[i] = ch[1]
	end		
	if (choice[i] == 6) then
	    solut[i] = "A " .. dif .. " (A " .. sect .. " A) = " .. empt
	    reply[i] = ch[1]
	end	
	if (choice[i] == 7) then
	    solut[i] = "A " .. dif .. " (A " .. uni .. " A) = " .. " A"
	    reply[i] = ch[2]
	end		
	if (choice[i] == 8) then
	    solut[i] = "A " .. sect .. " (A " .. dif .. " A) = " .. empt
	    reply[i] = ch[1]
	end	 
	if (choice[i] == 9) then
	    solut[i] = "A " .. uni .. " (A " .. dif .. " A) = " .. empt
	    reply[i] = ch[2]
	end	 
	if (choice[i] == 10) then
	    solut[i] = "(A " .. uni .. " " .. empt .. " ) " .. sect .. " A = " .. " A "
	    reply[i] = ch[1]
	end	 
	if (choice[i] == 11) then
	    solut[i] = "(A " .. sect .. " " .. empt .. " ) " .. sect .. " A = " .. " A "
	    reply[i] = ch[2]
	end	 	
	if (choice[i] == 12) then
	    solut[i] = "(A " .. sect .. " B) " .. dif .. " A = " .. empt
	    reply[i] = ch[1]
	end	 
	if (choice[i] == 13) then
	    solut[i] = "(A " .. uni .. " B) " .. dif .. " A = B" 
	    reply[i] = ch[2]
	end	 
	if (choice[i] == 14) then
	    solut[i] = "A " .. sect .. " (B " .. uni .. " A) = A" 
	    reply[i] = ch[1]
	end	
	if (choice[i] == 15) then
	    solut[i] = "A " .. dif .. " (B " .. sect .. " " .. empt .. " ) = A" 
	    reply[i] = ch[1]
	end	
	if (choice[i] == 16) then
	    solut[i] = "A " .. dif .. " (B " .. uni .. " " .. empt .. " ) = A" 
	    reply[i] = ch[2]
	end	
	
end                   
