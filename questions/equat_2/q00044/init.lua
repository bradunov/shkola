
meas = {"mm", "cm", "dm"}
meas2 = {"mm\(\small^2\)", "cm\(\small^2\)", "dm\(\small^2\)"}

gr2 =  "\(\small^2\)"
equ = ""

ind = 1 + math.random(2)
inddif = ind - 1

fct = 1 + math.random(4)
dif = 2 * (5 + math.random(15))
kata = fct * dif
kata = lib.math.round(kata)
katb = lib.math.round(0.5 * dif * (fct * fct - 1))
hipc = lib.math.round(katb + dif) 
katainit = lib.math.round_dec(0.1 * kata,1) 
circ = (kata + hipc + katb) * 0.1
circ = lib.math.round_dec(circ,1)
area = (0.5 * kata * katb) * 0.01
area = lib.math.round_dec(area,2)

equ = lib.check_number(kata,30) .. lib.sup_start() .. lib.check_number(2,10) .. lib.sup_end() .. "  " .. lib.check_string("+",10) .. " " .. lib.check_string("b",15) .. lib.sup_start() .. lib.check_number(2,10) .. lib.sup_end().. " = (" .. lib.check_string("b",15) .. " " .. lib.check_string("+",10) .. " " .. lib.check_number(dif,20) .. ")" .. lib.sup_start() .. lib.check_number(2,10) .. lib.sup_end()  
      