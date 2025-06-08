
include("names")
include("terms")

index_ime = math.random(#zensko_ime_nom);    
ime = zensko_ime_nom[index_ime];
padez = zensko_ime_dativ[index_ime];                   

proc = "%"
answ = {""}

ind = 2
denom = 100 
per =  10 + math.random(20);

numb1 = 500 + math.random(498)
numb2 = 800 + math.random(798)
min = numb1 + numb2
number = 100 * math.floor((min + math.random(499))/100)

price1 = numb1 * (1 - per/denom)
price2 = numb2 * (1 + per/denom)
price = price1 + price2

total = number - price
if (total == 100*math.floor(total/100)) then
    round = 0
else
    round = ind
end	    

if (total == 0) then
    index = 0
end	
if (total > 0) then 
    index = 2
end
bound = math.abs(total) + 2 + math.random(50)	
if (total < 0) then
    total = math.abs(total)	
    if (total <= bound ) then
        index = 1
    else	
        index = 3		
    end	
end	

result = lib.dec_to_str(lib.math.round_dec(total, round))
answ[1] = ime .. reply[4] .. reply[3] .. "."
answ[2] = padez .. reply[2] .. result .. " " .. msg .. reply[3] .. "."
answ[3] = ime .. reply[1] .. result .. " " .. msg .. "."
answ[4] = padez .. reply[2] .. reply[5] .. math.floor(bound) .. " " .. msg .. reply[3] .. "." 
