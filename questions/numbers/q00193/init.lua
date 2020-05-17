
term = {}
value = {}
sign = {"+", "-"}

diff = 2111 + math.random(4888)

term[1] = math.random(299) + 700;
term[2] = math.random(199) + 300;
term[3] = math.random(diff - 1500) + 500;
term[4] = math.random(diff - 1500) + 900;

for i = 1,4 do
    if (i < 3) then
        value[i] = diff + term[i];
	else
	    value[i] = diff - term[i];
	end		
end	


          
         
                     