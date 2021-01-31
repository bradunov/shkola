
include("names")
include("terms")

index_m = math.random(#musko_ime_nom);    
ime_m = musko_ime_nom[index_m];                   
index_f = math.random(#zensko_ime_nom);    
ime_f = zensko_ime_nom[index_f];

set = {2, 2, 2, 3, 3, 5}

enum = {}
denom = {}
value = {}
qq = {}

for i = 1,2 do
    qq = lib.math.random_shuffle(set)
    ind = math.random(2)
	denom[i] = 1
	for j = 1,ind do
        denom[i] = denom[i] * qq[j];
	end	
--[[	
	if (i == 1) then
		max = denom[i] - 1
	else	
		max = math.floor(denom[2]/(1-value[1]))
	end	
]]--	
    enum[i] = math.random(denom[i] - 1);	 
    value[i] = enum[i] / denom[i]
end	

rest = denom[1] - enum[1]    --[/denom[1]]]--

result_e = rest * (denom[2] - enum[2])
result_d = denom[1] * denom[2]
result = (1 - value[1]) * (1 - value[2])

q = lib.math.gcd(result_e, result_d)
broj = result_e / q
imen = result_d / q

if (broj == 1) then
    ans = msg[1]
else
    if (broj == 2) then
        ans = msg[2]
    else	
        ans = msg[3]
	end	
end		

condition = "is_ok = math.eq(numerator/denominator, "..tostring(result)..");"	          
solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
    
   