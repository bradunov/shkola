
numb = {}
temp = {}
eq = {""}
arg = {"x", "y"}
mes = {"°C", "l"}

temp[1] = 14 + math.random(10)
temp[2] = 45 + math.random(20)
temp[3] = temp[1] + 4 + math.random(temp[2] - temp[1] - 20)

total = (10 + math.random(10)) * 10
res = total * temp[3]
tmp = total / (temp[2] - temp[1])
numb[1] = lib.math.round_dec((temp[2] - temp[3]) * tmp, 1)
numb[2] = lib.math.round_dec((temp[3] - temp[1]) * tmp, 1)

eq[1] = lib.check_number(1,20) .. lib.check_string(arg[1], 15) .. " " .. lib.check_string("+", 10) .. " " .. lib.check_number(1,20) .. lib.check_string(arg[2], 15) .. " = " .. lib.check_number(total)
eq[2] = lib.check_number(temp[1],20) .. lib.check_string(arg[1], 15) .. " " .. lib.check_string("+", 10) .. " " .. lib.check_number(temp[2],20) .. lib.check_string(arg[2], 15) .. " = " .. lib.check_number(res)         
                
      