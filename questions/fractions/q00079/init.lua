
include("names")
include("terms")

r = math.random(#musko_ime_nom);
ime = musko_ime_nom[r];

number = 15 + math.random(20) 
fact = 1 + math.random(4)

rest = number - 10 * math.floor(number/10)
if (rest == 0 or rest > 4) then
    pad = padez[3]
else
	if (rest == 1) then
		pad = padez[1]
	else
		pad = padez[2]
	end	
end		

nr = 0
quant = number
for i = 1,number do
	value = math.floor(quant/fact)
	if (value == 0) then
	    if (quant ~= 0) then
		    nr = nr + 1
			quant = 0
		end	
	else	
		quant = quant - value
		nr = nr + 1
	end
end












