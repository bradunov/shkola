
include("names")

index_ime = math.random(#musko_ime_nom);    
ime = musko_ime_nom[index_ime];                   
padez = musko_pridev[index_ime];

deo = 5 + math.random(13);
deo1 = math.random(deo - 3)
deo2 = deo - deo1
temp = (math.random(10)) * 35;
put = temp * deo;
put1 = temp * deo1
put2 = temp * deo2

imenilac = 1000
brojilac = put
putkm = put/imenilac
swhole = math.floor(putkm)
rest = put - swhole * imenilac
if (swhole == 0) then
    answ = lib.check_fraction_simple(put,imenilac)
else
    answ = lib.check_number(swhole,15) .. lib.check_fraction_simple(rest,imenilac)	
--[[ Ako se trazi skracivanje razlomka
	
    condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(putkm)..");"       
    snum = lib.math.round((putkm - swhole) * imenilac)
    g = lib.math.gcd(snum, imenilac)
    sln = "numerator="..tostring(snum/g)..";denominator="..tostring(imenilac/g)..";whole="..tostring(swhole)..";"
    answ = lib.check_fraction_condition(condition, true, nil, sln)
]]--	
end	         

                  
                     
