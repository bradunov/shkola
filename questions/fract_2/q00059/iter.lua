                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
ind = math.random(2)

index = math.random(3)
denom = 10^index 
enum = math.random(999);	
if (enum - 10 * math.floor(enum/10) == 0) then
	enum = enum + 1
end		
value = enum / denom

fact = math.random(7) - 4
if (fact == 0) then
    fact = 1
end
factor = 10^fact	
if (ind == 1) then
    sign = "*"
	number = value * factor
	dec = index - fact
else
    sign = ":"
	number = value / factor
	dec = index + fact
end	

term1 = lib.dec_to_str(lib.math.round_dec(value, index))	
if (fact < 0) then
    fact = - fact
    term2 = lib.dec_to_str(lib.math.round_dec(factor, fact))
else
    term2 = factor
end	

if (dec > 0) then
    number = lib.math.round_dec(number, dec)
else	
    number = lib.math.round(number)
end		

            
         