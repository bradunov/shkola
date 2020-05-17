
cifra = {}
cifra[1] = math.random(9) 
cifra[2] = math.random(6) - 1
cifra[3] = math.random(3) - 1
value = (cifra[1] * 10 + cifra[2]) * 10 + cifra[3]

ind = math.random(3)
number2 = 10^ind

number1 = value * number2

if (cifra[3] == 0) then
    ind = ind + 1
	if(cifra[2] == 0) then
	   ind = ind + 1
	end   
end	

number2 = 10^ind
      

           
            
            