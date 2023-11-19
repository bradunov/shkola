
include("terms")

meas = {"cm", "cm²"} 
symb = "π"
pi = 22/7

ind = math.random(2)

numb1 = 3 + math.random(8)
numb2 = numb1 + 2 + math.random(8)

if (ind == 1) then
	r = numb2 / (2*pi)
    h = numb1	
else	
 	r = numb1 / (2*pi)
    h = numb2	
end   
p = lib.math.round_dec(r * r * pi,2)
q = lib.math.round_dec(2 * r * h,2)
     