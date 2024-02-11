
meas = {"dm²", "m²", "km²"} 
val = 4 + math.random(5);
number = val^2
area_m = lib.math.round(10000*number)
area_k = math.ceil(0.1*number) 
area_k = lib.math.round_dec(0.1*area_k,1)        