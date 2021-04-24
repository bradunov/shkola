
ang_g = {}
ang_m = {}
ang = {}
out = {}
sign = {""} 
reply = ""

ind = math.random(3)
ang_g[1] = 60 +(2 - ind) * math.random(30)
ang_m[1] = math.random(51) - 1
ang[1] = ang_g[1] * 60 + ang_m[1]
ind = math.random(3)
ang_g[2] = 50 +(2 - ind) * math.random(30)
ang_m[2] = math.random(51) - 1
ang[2] = ang_g[2] * 60 + ang_m[2]	
ang_g[3] = 178 - ang_g[1] - ang_g[2] 
ang_m[3] = 120 - ang_m[1] - ang_m[2]
temp =  math.floor(ang_m[3]/60) 
ang_g[3] = ang_g[3] + temp    
ang_m[3] = ang_m[3] - 60 * temp
ang[3] = ang_g[3] * 60 + ang_m[3]

out = lib.math.argsort(ang)

if (ang[out[3]] == ang[out[2]]) then
	sign[1] = answ[1]
else 
	sign[1] = answ[2]
end	
if (ang[out[2]] == ang[out[1]]) then
	sign[2] = answ[1]
else 
	sign[2] = answ[2]
end			
reply = lib.check_string_case(name[out[3]],30) .. " " .. " " .. lib.check_one_option_dropdown(answ, sign[1]) .. " " .. " " .. lib.check_string_case(name[out[2]],30) .. " " .. lib.check_one_option_dropdown(answ, sign[2]) .. " " .. lib.check_string_case(name[out[1]],30) 
   