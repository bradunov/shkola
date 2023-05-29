
coef = {}
numb = {}
equ = {""}
arg = {"x", "y"}

min_range = 2
max_range = 5
coef[1] = min_range + math.random(max_range)
coef[2] = coef[1] + min_range + math.random(max_range)
coef[3] = coef[2] - coef[1] + min_range + math.random(max_range)

equ[1] = lib.frac_start() .. lib.check_number(1, 20) .. lib.frac_mid() .. lib.check_string(arg[1],20) .. lib.frac_end() .. " " .. lib.check_string("+", 10) .. " " .. lib.frac_start() .. lib.check_number(1, 20) .. lib.frac_mid() .. lib.check_string(arg[2],20) .. lib.frac_end() ..  " = " .. lib.frac_start() .. lib.check_number(1, 20) .. lib.frac_mid() .. lib.check_string(coef[2],20) .. lib.frac_end() 	
equ[2] = lib.frac_start() .. lib.check_number(coef[1], 20) .. lib.frac_mid() .. lib.check_string(arg[1],20) .. lib.frac_end() .. " " .. lib.check_string("+", 10) .. " " .. lib.frac_start() .. lib.check_number(coef[1], 20) .. lib.frac_mid() .. lib.check_string(arg[2],20) .. lib.frac_end() .. lib.check_string("+", 20) .. lib.frac_start() .. lib.check_number(coef[3], 20) .. lib.frac_mid() .. lib.check_string(arg[2],20) .. lib.frac_end() .. " = " .. lib.check_number(1, 20) 	

tmp = coef[2] * coef[3]
numb[1] = tmp / ( coef[3] - coef[2] + coef[1])         
numb[2] = tmp / ( coef[2] - coef[1]) 
numb[1] = lib.math.round_dec(numb[1],1)          
numb[2] = lib.math.round_dec(numb[2],1)   
            
     