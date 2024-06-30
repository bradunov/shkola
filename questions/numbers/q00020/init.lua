
include("terms")
include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 
padez = musko_ime_dativ[r]

price = math.random(60) + 20;
change = 100 - price
                  
money = {50, 20, 10, 5, 2, 1}

answ = ""

value = change

for i = 1,6 do
    factor = math.floor(value/money[i])
	if (factor ~= 0) then
	    if (factor == 1) then
			answ = answ .. lib.check_number(factor,10) .. msg1 .. lib.check_number(money[i],15)  
			if ( i == 6) then
			    answ = answ .. msg2
			else
                answ = answ .. msg3			
			end	
		else
			answ = answ .. lib.check_number(factor,10) .. msg4 .. lib.check_number(money[i],15) 
		    if ( i == 6) then
			    answ = answ .. msg5
			else
                answ = answ .. msg6				
			end	
        end			
	    value = value - factor * money[i]
	end   	
end
               
	
	
