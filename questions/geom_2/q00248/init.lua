
pi = 22/7
meas = {"dm", "m"}

diam = 5 + math.random(7)

ind = 1
numb = diam                                    --[[dm]]--
if (diam >= 10) then
    numb = lib.math.round_dec(0.1 * diam, 1)   --[[m]]--
	ind = 2
end	

circ = diam * pi * 0.1                         --[[m]]-- 
value = 5 * (9 + math.random(15))              --[[km/h]]--
val = 100 * value/6                            --[[m/min]]--
rot = lib.math.round(val/circ)
   
            