include("terms")
include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 
padez = musko_ime_dativ[r]

price = (math.random(60) + 20) * 10;
change = 1000 - price
                  
money = {500, 200, 100, 50, 20, 10}

answ = ""

value = change

for i = 1,6 do
    factor = math.floor(value/money[i])
	if (factor ~= 0) then
	    if (factor == 1) then
			answ = answ .. lib.check_number(factor,10) .. msg_note[1] .. lib.check_number(money[i],30)  
			if ( i == 6) then
			    answ = answ .. msg_val1[1]
			else
                answ = answ .. msg_val2[1]			
			end	
		else
			answ = answ .. lib.check_number(factor,10) .. msg_note[2] .. lib.check_number(money[i],30) 
		    if ( i == 6) then
			    answ = answ .. msg_val1[2]
			else
                answ = answ .. msg_val2[2]				
			end	
        end			
	    value = value - factor * money[i]
	end   	
end
      
	
	
