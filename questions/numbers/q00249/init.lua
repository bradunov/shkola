
include("terms")

numb = {}
val = {}

value = 31 + math.random(28);
if (value == 10*math.floor(value/10)) then
    value = value + math.random(9)
end	
val_f = math.floor(value/10)
val_c = math.ceil(value/10)
value = value * 1000
val_f = val_f * 10000
val_c = val_c * 10000

ch = math.random(2)
if (ch == 1) then
    numb[2] = val_f
	numb[1] = value - numb[2]
	op = 2
	numb[3] = val_c
	numb[4]	= numb[3] - value
else
    numb[2] = val_c
	numb[1] = numb[2] - value
	op = 1
	numb[3] = val_f
	numb[4]	= value	- numb[3] 
end	

val[1] = lib.math.round(value/10)
for i = 2,3 do
    val[i] = lib.math.round(val[i-1]/10)
end	     
       