                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
enum = {}
denom = {}
index = {}
value = {}
number = {}

fact = 2

min = 1
max = 500
    
for i = 1,fact do
    index[i] = math.random(3)
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

dec = index[2] - index[1]
term_e = enum[1] * 10^dec
term_d = enum[2] 

for i = 1,fact do 
    number[i] = lib.dec_to_str(lib.math.round_dec(value[i], index[i]))
end	

quest = ""
for i = 1,fact do
     if (i == fact) then 
	     sign = " = "
     else		 
         sign = " : "
	 end	 
     quest = quest .. number[i] .. sign
end

result = lib.math.round_dec(term_e / term_d, 3)
if (dec < 0) then
    dec = -dec
	reply = lib.check_number(lib.math.round_dec(term_e, dec),40)
else	
    reply = lib.check_number(term_e,40) 
end	
reply = reply .. " : " .. lib.check_number(math.floor(term_d), 40) .. " = " .. lib.check_number(result, 60)
              