                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
enum = {}
denom = {}
index = {}
value = {}
number = {}

fact = 2

min = 1
max = 500
dec = 0	    
for i = 1,fact do
    index[i] = math.random(3)
    dec = dec+index[i]
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

term_e = 1
term_d = 1
for i = 1,fact do
    term_e = term_e * enum[i]
    term_d = term_d * denom[i]	
end	

for i = 1,fact do 
    number[i] = lib.dec_to_str(lib.math.round_dec(value[i], index[i]))
end	

quest = ""
for i = 1,fact do
     if (i == fact) then 
	     sign = " = "
     else		 
         sign = " * "
	 end	 
     quest = quest .. number[i] .. sign
end

result = lib.math.round_dec(term_e / term_d, dec)
reply = lib.check_fraction_simple(term_e, term_d) .. " = " .. lib.check_number(result, 60)
         