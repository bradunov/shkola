
include("names")
r1 = math.random(#musko_ime_nom)
r2 = math.random(#musko_ime_nom-1)
if (r2 >= r1) then r2 = r2 + 1 end
ime1 = musko_ime_nom[r1]
ime2 = musko_ime_nom[r2] 

prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
dim = 3                                    --[[25]]--

ind = 2

number = {}
deg = {}

q = {}
quest = {}
value = {}
word = {}


numbmax = 200
numbmin = 60

for j = 1,ind do
    number[j] = prime[3]
end	


prod = number[1]
for i = 1,dim do
    if (i < 3) then
	    max = 4
        min = 1
    else
        max = 2
        min = 0
    end	
    for j = 1, ind do
        if (number[j] >= numbmax) then
            deg[j] = 0
        else			
            deg[j]= min - 1 + math.random(max-min)
		end	
	    if (deg[j] > 0) then
	        for k = 1,deg[j] do
                number[j] = number[j] * prime[i]
	        end
	    end	
    end
	q = lib.math.argsort(deg)
	if (deg[q[ind]] ~= 0) then
        for k = 1,deg[q[ind]] do
			prod = prod * prime[i]
		end	
	end	               		
end	       
sign = 0         
for i = 1,ind do
    temp = math.floor(number[i]/60)
	if (temp < 3) then
	    number[i] = number[i] * prime[4]
		sign = 1
    end
end	

if (sign == 1) then 
    prod = prod * prime[4]
end

for i = 1,ind do
    temp = math.floor(number[i]/60)	
	rest = number[i] - 60 * temp
	if (rest == 0) then
	    quest[i] = tostring(temp) .. "min" 
	else
	    quest[i] = tostring(temp) .. "min " .. tostring(rest) .. "s"	
	end	
end	

temph =  math.floor(prod/3600)
resth = prod - 3600 * temph
temp =  math.floor(resth/60)
rest = resth - 60 * temp
if (temph == 0) then
    answ = ""	
else
    answ = lib.check_number(temph,20) .. " h "
end	
if (temp ~= 0) then
	answ = answ .. lib.check_number(temp,20) .. " min " 
end
if (rest ~= 0) then
	answ = answ .. lib.check_number(rest,30) .. " s"	
end	
 
for i = 1,ind do
    value[i] = prod/number[i]
    temp = math.floor(value[i]/10)
	rest = value[i] - 10 * temp
	if (temp ~= 1) then
	    if (rest > 4) then
	        word[i] = "krugova"
	    else
            if (rest > 1) then	
	            word[i] = "kruga"
	        else     
	            word[i] = "krug"
	        end
	    end
	else
	    word[i] = "krugova"	
	end	
end	    
          
  
            
            
            
   
        
       
             
       