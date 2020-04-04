include("names")
r1 = math.random(#musko_ime_nom)
r2 = math.random(#musko_ime_nom-1)
if (r2 >= r1) then r2 = r2 + 1 end
ime1 = musko_ime_nom[r1]
ime2 = musko_ime_nom[r2] 
padezg1 = musko_ime_gen[r1]
padezg2 = musko_ime_gen[r2]                 
padezd1 = musko_ime_dativ[r1]; 
padezd2 = musko_ime_dativ[r2];


factor1 = 2 + math.random(4)
cost1 = 41 + math.random(59)
money1 = cost1 * factor1

factor2 = factor1 + math.random(9 - factor1)
cost2 = 61 + math.random(39)
money2 = cost2 * factor2 


if (money1 == money2 or cost1 == cost2) then
    cost2 = cost2 - 10
    factor2 = factor2-1
    money2 = cost2 * factor2
end

rest1 = money1 - cost1
rest2 = money2 - cost2

if (money1 > money2) then
    money = money1
    diff = money1 - money2
    first = ime1
	second = ime2
	fract_f = factor1
	fract_s = factor2
else
    money = money2
    diff = money2 - money1	
    first = ime2
	second = ime1
	fract_f = factor2
	fract_s = factor1	
end	

if (cost1 > cost2) then
    cost = cost1 - cost2
	ime = ime1
	padezg = padezg2
	ime_UK = ime2
else
    cost = cost2 - cost1
    ime = ime2
	padezg = padezg1
	ime_UK = ime1
end


