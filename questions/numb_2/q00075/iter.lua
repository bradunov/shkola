
prime = {2, 2, 2, 3, 3, 5, 7}
perm = {}
fct = {}
out = {}
reply = "" 

dim = 1 + math.random(4) 
perm = lib.math.random_shuffle(prime)
for i = 1,dim do
    fct[i] = perm[i]
end 
out = lib.math.argsort(fct)  

number = 1
for i = 1,dim do
    number = number * fct[out[i]]
	reply = reply .. lib.check_number(fct[out[i]],15) .. " * " .. lib.check_number(fct[out[i]],15) 
	if (i < dim) then
	    reply = reply .. " * "	
	end	
end
numb2 = number * number   
              
         



