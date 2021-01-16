                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
brojilac = {}

min = 100
max = 1000
	    
for i = 1,2 do
    ind = math.random(3)
	denom[i] = 10^ind 
    enum[i] = min + math.random(max-min-10);	
    if (enum[i] - 10 * math.floor(enum[i]/10) == 0) then
	    enum[i] = enum[i] + 1
	end		
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]                    --[[value = enum/denom = whl + enum_p/denom ]]--
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

for i = 1,2 do
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
end	 
	 
index = math.random(2)
if (value[1] < value[2]) then
    index = 2
end	

q = lib.math.gcd(denom[1], denom[2])
imenilac = denom[1] * denom[2] / q
brojilac[1] = enum[1] * denom[2]/q
brojilac[2] = enum[2] * denom[1]/q

if (index == 2 ) then
    sign = "+"
	summ = brojilac[1] + brojilac[2]
	result = value[1] + value[2]
else 
    sign = "-"	
	summ = brojilac[1] - brojilac[2]	
    result = value[1] - value[2]
end

ceo = math.floor(summ/imenilac)
broj = summ - ceo * imenilac

if (ceo == 0) then
    ans =  lib.check_fraction_simple(broj, imenilac) 
else
    ans =  lib.check_number(ceo,30) .. lib.check_fraction_simple(broj, imenilac)   
end	

res = lib.math.round(result * imenilac)  
result = res / imenilac     
         