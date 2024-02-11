
include("names")

index_ime = math.random(#musko_ime_nom);    
ime = musko_ime_nom[index_ime];                   

denom = { 2, 3, 4, 5, 6, 8}

ch = math.random(6)
imen = denom[ch]
if (imen > 4) then
    if (imen == 8) then
	    min_range = 2
		max_range = imen - 3
	else
		min_range = 1
		max_range = imen - 2
	end
else
    min_range = 0
    max_range = imen - 1
end	
broj = min_range + math.random(max_range)
quest = "\(\frac{" .. broj .. "}{" .. imen .. "}\)"
person = 3 + math.random(12)
brojilac = person * broj

numb = math.ceil(brojilac/imen)
rest = numb * imen - brojilac
val = rest / imen

if (rest == 0) then
    answ = lib.check_number(0,20)
else		
    condition = "is_ok = math.eq(numerator/denominator, "..tostring(val)..");"       
    g = lib.math.gcd(rest, imen)
    sln = "numerator="..tostring(rest/g)..";denominator="..tostring(imen/g).. ";"
    answ = lib.check_fraction_condition(condition, nil, nil, sln)
end	         

if (ch == 6) then
    broj1 = 2
	imen1 = denom[ch - 1]
else	
    broj1 = broj
	imen1 = denom[ch + 1] 
end	
if (broj1/imen1 >= broj/imen) then
    if (broj1 == 1) then
	    imen1 = 8
    else
        broj1 = 1
    end
end	
quest1 =  "\(\frac{" .. broj1 .. "}{" .. imen1 .. "}\)"
add = math.floor(numb*imen1/broj1)
add = add - person
             