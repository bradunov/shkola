
include("names")

dimnames = 6
index = {}
for i=1,dimnames do
    index[i] = i
end	
r = lib.math.random_shuffle(index)

name = {""}
name[1] = musko_ime_nom[r[1]]
name[2] = musko_ime_nom[r[2]] 

coef = {}
numb = {}

equ = {""}
arg = {"x", "y"}

min_range = 7
max_range = 13
coef[1] = min_range + math.random(max_range)
coef[2] = min_range + math.random(max_range)
if (coef[2] == coef[1]) then
    coef[2] = coef[2] +  3 + math.random(3)
end	
if (coef[2] > coef[1]) then
	coef[3] = coef[1] - 1 - math.random(coef[1] - 4)
	coef[4] = coef[2] + 1 + math.random(min_range)
else
	coef[3] = coef[1] + 1 + math.random(min_range)
	coef[4] = coef[2] - 1 - math.random(coef[2] - 4)
end

for i = 1,2 do
	equ[i] = ""
	for j = 1,2 do
		equ[i] = equ[i] .. lib.frac_start() .. lib.check_number(coef[2*(i-1)+j], 20) .. lib.frac_mid() .. lib.check_string(arg[j],20) .. lib.frac_end() 
		if (j == 1) then 
			equ[i] = equ[i] .. " " .. lib.check_string("+", 10) .. " " 
		else
			equ[i] = equ[i] .. " = " 
        end	
    end		
	equ[i] = equ[i] .. lib.check_number(1, 20) 
end

tmp = coef[2] * coef[3] - coef[1] * coef[4]
numb[1] = tmp / ( coef[2] - coef[4])         
numb[2] = tmp / ( coef[3] - coef[1]) 
numb[1] = lib.math.round_dec(numb[1],1)          
numb[2] = lib.math.round_dec(numb[2],1)   
            
     