
include("terms")

set = {2, 2, 2, 3, 3, 5}
dim = 6

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}
brojilac = {}
imenilac = {}

max = 300       

for i = 1,4 do
    qq = lib.math.random_shuffle(set)
    index = 1 + math.random(3)
	denom[i] = 1
	for j = 1,index do
        denom[i] = denom[i] * qq[j];
	end	 
    enum[i] = denom[i] + math.random(max-denom[i]);	 
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
sign1 = operat1[ind1]
if (ind1 == 1) then 
    term1 = value[1] - value[2]
	if (value[1] < value[2]) then
	    temp = denom[1]
		denom[1] = denom[2]
		denom[2] = temp
	    temp = enum[1]
		enum[1] = enum[2]
		enum[2] = temp	
	    temp = value[1]
		value[1] = value[2]
		value[2] = temp	
        term1 = value[1] - value[2]
	end	
else
    term1 = value[1] + value[2]	
end	

ind3 = math.random(2);
sign3 = operat1p[ind3]
if (ind3 == 1) then 
    term2 = value[3] - value[4]
	if (value[3] < value[4]) then
	    temp = denom[3]
		denom[3] = denom[4]
		denom[4] = temp
	    temp = enum[3]
		enum[3] = enum[4]
		enum[4] = temp	
	    temp = value[3]
		value[3] = value[4]
		value[4] = temp	
        term3 = value[3] - value[4]
	end	
else
    term2 = value[3] + value[4]	
end	

for i = 1,4 do
	q = lib.math.gcd(enum[i], denom[i])
	enum[i] = enum[i]/q
	denom[i] = denom[i]/q
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
end		

q = lib.math.gcd(denom[1], denom[2])
imenilac[1] = denom[1] * denom[2] / q
if (ind1 == 1 ) then
	brojilac[1] = (enum[1] * denom[2] - enum[2] * denom[1])/q
else 
	brojilac[1] = (enum[1] * denom[2] + enum[2] * denom[1])/q	
end

q = lib.math.gcd(denom[3], denom[4])
imenilac[2] = denom[3] * denom[4] / q
if (ind3 == 1 ) then
	brojilac[2] = (enum[3] * denom[4] - enum[4] * denom[3])/q
else 
	brojilac[2] = (enum[3] * denom[4] + enum[4] * denom[3])/q	
end

q = lib.math.gcd(imenilac[1], imenilac[2])
imen_t = imenilac[1] * imenilac[2] / q
if (term1 > term2) then
   ind2 = 2
   result = term1 - term2; 
   broj_t = (brojilac[1] * imenilac[2] - brojilac[2] * imenilac[1])/q 
else 
   ind2 = 1
   result = term2 - term1; 
   broj_t = (brojilac[2] * imenilac[1] - brojilac[1] * imenilac[2])/q    
end
if (ind1 == 1) then
    sign2 = operat2a[ind2]
else
    sign2 = operat2i[ind2]	
end	

gcd = lib.math.gcd(imen_t, broj_t)
broj = broj_t/ gcd
imen = imen_t / gcd
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

if (result == 0) then
    ans = reply[1]
else	
    if (ceo == 0) then
        ans = lib.check_fraction_simple(broj, imen) 
    else
        ans = lib.check_number(ceo,20) .. lib.check_fraction_simple(broj, imen)   
    end
end	         
   

