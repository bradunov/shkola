
include("names")

index_ime = math.random(#musko_ime_nom);    
ime = musko_ime_nom[index_ime];                   
padez = musko_ime_gen[index_ime];

deo = 3 + math.random(10);
deo1 = math.random(deo - 3)
temp = 2 + math.random(14 - deo);
put = temp * deo;
put1 = temp * deo1
put2 = put - put1

vreme = put2 * 6;

sat = math.floor(vreme/60)
minut = vreme - sat * 60

meas = "časova"

if (sat >= 0 and sat < 5 ) then
    if (sat == 1 and minut == 0) then
        meas = "čas"
    else
        meas = "časa"
    end
end

imenilac = 60
vremeh = vreme/imenilac
swhole = math.floor(vremeh)
rest = vreme - swhole * imenilac
if (swhole == 0) then
    answ = lib.check_fraction_simple(vreme,imenilac)
else
    if (rest == 0) then
	    answ = lib.check_number(swhole,15)
	else	
        answ = lib.check_number(swhole,15) .. lib.check_fraction_simple(rest,imenilac)	
	end	
--[[ Ako se trazi skracivanje razlomka
	
    condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(vremeh)..");"                     
    snum = lib.math.round((vremeh - swhole) * imenilac)
    g = lib.math.gcd(snum, imenilac)
    sln = "numerator="..tostring(snum/g)..";denominator="..tostring(imenilac/g)..";whole="..tostring(swhole)..";"
    answ = lib.check_fraction_condition(condition, true, nil, sln)
]]--	
end	    	              
      