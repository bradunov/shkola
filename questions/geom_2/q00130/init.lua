
include("terms")

meas = {"dm", "cm"}

ind = math.random(2)
ch = math.random(2)

fact = 10 + math.random(17)

if (ch == 1) then
    dist = 2 * fact
else
    dist = fact
end	

leng = 3 * fact
numb = lib.dec_to_str(lib.math.round_dec(leng/10,1))

