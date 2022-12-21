
include("terms")

index = {}
out = {}
equ1 = ""
equ2 = ""

ind = math.random(4)
if (ind == 1) then
	index = {1, 2, 3, 4}
end
if (ind == 2) then
	index = {2, 2, 3, 3}
end
if (ind == 3) then
	index = {1, 3, 3, 3}
end
if (ind == 4) then
	index = {1, 1, 4, 4}
end
if (ind == 5) then
	index = {1, 1, 3, 5}
end
out = lib.math.random_shuffle(index)


number = 40 + 10 * math.random(6)
fct = 0.1
swim = lib.math.round(fct * out[1] * number)
volley = lib.math.round(fct * out[2] * number)
basket = lib.math.round(fct * out[3] * number)
foot = lib.math.round(fct * out[4] * number)
voldec = lib.math.round_dec(fct * out[2],1)
volper =  lib.math.round(voldec * 100)

basvol = basket - volley
if (basvol == 0) then
    basvol = math.random(swim - 4)
    basket = basket + basvol
	swim = swim - basvol
end
if (basvol > 0) then
    note = msg[1]
	sg = " + "
else
    basvol = - basvol 
    note = msg[2]
	sg = " - "	
end
enum = foot
denom = volley + basket
qq = lib.math.gcd(enum, denom)
enum = lib.math.round(enum/qq)
denom = lib.math.round(denom/qq)

equ1 = lib.check_number(swim,20) .. " + " .. lib.check_number(voldec,20) .. lib.check_string("x",10) .. " + (" .. lib.check_number(voldec,20) .. lib.check_string("x",10) .. lib.check_string(sg,10) .. lib.check_number(basvol,20) .. ") + " 
equ2 = lib.check_fraction_simple(enum,denom) ..  " ( " .. lib.check_number(voldec,20) .. lib.check_string("x",10) .. lib.check_string(" + ",10) .. lib.check_number(voldec,20) .. lib.check_string("x",10) .. lib.check_string(sg,10) .. lib.check_number(basvol,20) .. ") = " .. lib.check_string("x",10)
     