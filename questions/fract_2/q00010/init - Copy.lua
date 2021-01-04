
include("names")

index_ime = math.random(#musko_ime_nom);    
ime = musko_ime_nom[index_ime];                   
padez = musko_ime_gen[index_ime];

deo = math.random(6) + 3;
put1 = 2 + math.random(deo - 3);
put2 = put1 * (deo - 1);
put = put1 + put2

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
brojilac = vreme
vremeh = brojilac/imenilac

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(vremeh)..");"                     

swhole = math.floor(vremeh)
snum = lib.math.round((vremeh - swhole) * imenilac)
g = lib.math.gcd(snum, imenilac)

sln = "numerator="..tostring(snum/g)..";denominator="..tostring(imenilac/g)..";whole="..tostring(swhole)..";"
