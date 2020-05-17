
term = {}
value = {}
sign = {"+", "-"}

summ = 2111 + math.random(4888)

term[1] = math.random(299) + 700;
term[2] = math.random(199) + 300;
term[3] = math.random(summ - 1500) + 500;
term[4] = math.random(summ - 1500) + 900;

for i = 1,4 do
    if (i < 3) then
        value[i] = summ + term[i];
	else
	    value[i] = summ - term[i];
	end		
end	


          
         
                     