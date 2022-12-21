
include("names")
include("terms")

rz = math.random(#zensko_ime_nom);
rm = math.random(#musko_ime_nom)
imez = zensko_ime_nom[rz];
imem = musko_ime_nom[rm] 
imeg = musko_ime_gen[rm]
imea = musko_ime_akuzativ[rm]
 
first = {8, 5, 4, 4, 3}
last = {14, 10, 8, 7, 6}

equ = ""

ch = math.random(5)
fct = ch + 2
whole = first[ch] + 1 + math.random(last[ch] - first[ch])
yz = (fct - 1) * whole
rest = yz - 10 * math.floor(yz / 10)
if (rest == 0 or rest > 4) then
	zyear = msg[1]
else
	if (rest == 1) then
		zyear = msg[4]
	else
		zyear = msg[2]
	end	
end		
period = 1 + math.random(whole - 2)
if (period < 5) then 
	peryear = msg[2]
else
	peryear = msg[1]	
end	
ym = whole - period
if (ym < 5) then 
    if (ym == 1) then 
		myear = msg[3]
	else
		myear = msg[2]
	end
else
	myear = msg[1]	
end	

equ =  lib.check_number(yz, 20) .. lib.check_string("+", 15) .. lib.check_string("x", 20) .. lib.check_string("+", 15) .. lib.check_number(period,20) .. " = " .. lib.check_number(fct,20) .. " ( " .. lib.check_string("x",20) .. lib.check_string("+", 15) .. lib.check_number(period,20) .. " )"    
   
