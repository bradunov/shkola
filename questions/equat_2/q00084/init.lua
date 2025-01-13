
include("names")

name = {}

r1 = math.random(#zensko_ime_nom)
r2 = math.random(#musko_ime_nom)
name[1] = zensko_ime_nom[r1]
name[2] = musko_ime_nom[r2] 

vel = {}
free = {}
numb = {}
equ = {""}
arg = {"t", "r"}

free[1] = 0
free[2] = 500 + math.random(1500) 
vel[1] = 50 + math.random(30) 
vel[2] = vel[1] - 5 + math.random(30) 
equ[1] = lib.check_number(vel[1]) .. lib.check_string(arg[1], 15) .. " " .. lib.check_string("-", 10) .. " " .. lib.check_number(1,20) .. lib.check_string(arg[2], 15) .. " = " .. lib.check_number(free[1]) 	
equ[2] = lib.check_number(vel[2]) .. lib.check_string(arg[1], 15) .. " " .. lib.check_string("+", 10) .. " " .. lib.check_number(1,20) .. lib.check_string(arg[2], 15) .. " = " .. lib.check_number(free[2])
numb[1] = (free[1] + free[2])/(vel[1] + vel[2])           
numb[2] = vel[1] * numb[1] 
numb[1] = lib.math.round_dec(numb[1],2)          
         