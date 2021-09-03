                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
enum = {}
denom = {}
index = {}
value = {}
number = {}
ind = {}
sign = {}

dim = 3
min = 100
max = 1000
dec = 0	    
for i = 1,dim do
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
	ind[i] = math.random(2)
	if (ind[i] == 2) then
	    value[i] = - value[i]
	end	
    number[i] = lib.dec_to_str(lib.math.round_dec(value[i], index[i]))	
end	

summ = value[1]
for i = 1,dim-1 do
    oper = math.random(2)
    if (oper == 1) then
	   sign[i] = "-"
	   summ = summ - value[i+1]
    else
	   sign[i] = "+"
	   summ = summ + value[i+1]	   
	end
end	   

reply = lib.math.round_dec(summ, dec)
       
        
            