
prime = {2, 3, 5, 7} 
dim = 4                                    

ind = 4

number = {}
fact = {}
divid = {}
q = {}

for j = 1,ind do
    number[j] = 1
end	

sum = 0
prod = 1
for i = 1,dim do
    freq = 0
    for j = 1, ind do
	    if ( i < 3) then
	        max = 5 - i
		else
            max = 2
        end		
       	fact[j]= math.random(max) - 1
		if (freq < fact[j]) then
		    freq = fact[j]
		end	
		if (fact[j] ~= 0) then
		    for k = 1, fact[j] do
                number[j] = number[j] * prime[i]
			end	
		end	
    end	
	if (freq > 0) then
	    for k = 1, freq do
		    sum = sum + 1		
		    divid[sum] = prime[i]
		    prod = prod * prime[i]
		end	
	end	               		
end	

for j = 1, ind do
    if (number[j] == 1) then
        number[j] = prime[j]
		index = 0
	    for i = 1,sum do
			if (divid[i] == prime[j]) then
				index = 1
			end	
		end	
		if (index == 0) then
		    sum = sum + 1
            divid[sum] = prime[j]			   
		    prod = prod * prime[j]	
        end			   
    end
end	   

jbrojilac = {}
brojilac = {}

for i = 1,ind do
    jbrojilac[i] = math.random(number[i] - 1)
	temp = math.floor(prod/number[i])
	brojilac[i] = temp * jbrojilac[i]
end


            