
operat1 = {"Razliku", "Zbir"}
operat2 = {"umanji", "uvećaj"}

ind1 = math.random(2);
sign1 = operat1[ind1]

ind2 = math.random(2);
sign2 = operat2[ind2]

term1 = math.random(499000) + 201000;
term2 = math.random(term1 - 150000) + 100000;

diff = term1 - term2
term3 = math.random(diff - 10000) + 11000;

if (ind1 == 2) then 
    diff = term1 + term2
end	

if (ind2 == 1) then  	
    result = diff - term3;  
else
    result = diff + term3; 
end

         