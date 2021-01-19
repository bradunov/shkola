                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
enum = {}
denom = {}
index = {}
value = {}
number = {}

min = 100
max = 1000
dec = 0	    
for i = 1,4 do
    index[i] = math.random(3)
	if (index[i] > dec) then
	    dec = index[i]
	end	
	denom[i] = 10^index[i] 
    enum[i] = min + math.random(max-min-10);	
    if (enum[i] - 10 * math.floor(enum[i]/10) == 0) then
	    enum[i] = enum[i] + 1
	end		
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]                  
	end	
end	

temp1 = value[1] + value[2]
rest1 = temp1 - math.floor(temp1)
temp2 = math.abs(value[1] - value[2])
rest2 = temp2 - math.floor(temp2)
if (rest1 * rest2 == 0) then
    enum[1] = enum[1] + 1
    value[1] = enum[1] / denom[1]	
    if (value[1] == math.floor(value[1])) then
	    enum[1] = enum[1] + 1
		value[1] = enum[1] / denom[1]
	end		
end	

temp1 = value[3] + value[4]
rest1 = temp1 - math.floor(temp1)
temp2 = math.abs(value[3] - value[4])
rest2 = temp2 - math.floor(temp2)
if (rest1 * rest2 == 0) then
    enum[3] = enum[3] + 1
    value[3] = enum[3] / denom[3]	
    if (value[3] == math.floor(value[3])) then
	    enum[3] = enum[3] + 1
		value[3] = enum[3] / denom[3]
	end		
end

ind1 = math.random(2);
if (ind1 == 1) then 
	if (value[1] < value[2]) then	
	    temp = value[1]
		value[1] = value[2]
		value[2] = temp	
	    temp = index[1]
		index[1] = index[2]
		index[2] = temp			
	end	
    sign1 = "-"
    term1 = value[1] - value[2]	
else
    sign1 = "+"
    term1 = value[1] + value[2]	
end	

ind3 = math.random(2);
if (ind3 == 1) then 
	if (value[3] < value[4]) then	
	    temp = value[3]
		value[3] = value[4]
		value[4] = temp	
	    temp = index[3]
		index[3] = index[4]
		index[4] = temp				
	end	
	sign3 = "-"
	term2 = value[3] - value[4]
else
    sign3 = "+"
    term2 = value[3] + value[4]	
end

if (term1 > term2) then
    sign2 = "-"
    result = term1 - term2; 
    if (ind3 == 1) then
        sign3 = "+"
    else
        sign3 = "-"	
    end	
else 
   sign2 = "+"
   result = term1 + term2; 
end

for i = 1,4 do 
    number[i] = lib.dec_to_str(lib.math.round_dec(value[i], index[i]))
end	

reply = lib.math.round_dec(result, dec)
       