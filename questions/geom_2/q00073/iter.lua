
ang_g = {}
ang_m = {}

answ = {}
ind = {}

dat = ""

sign = math.random(3)
first_g = 60 +(2 - sign) * math.random(20)
first_m = math.random(59) - 1

ang_g[1] = first_g 
ang_m[1] = first_m 
ang_g[2] = 179 - first_g 
ang_m[2] = 60 - first_m 
temp =  math.floor(ang_m[2]/60) 
ang_g[2] = ang_g[2] + temp    
ang_m[2] = ang_m[2] - 60 * temp

sign = math.random(2)
if (sign == 1) then
    ang_g[5] = 2 * ang_g[1] 
    ang_m[5] = 2 * ang_m[1]
else	
    ang_g[5] = 2 * ang_g[2] 
    ang_m[5] = 2 * ang_m[2]
end	
temp =  math.floor(ang_m[5]/60)
ang_g[5] = ang_g[5] + temp    
ang_m[5] = ang_m[5] - 60 * temp

dat = ang_g[5] .. meas[1] .. " "
if (ang_m[5] ~= 0) then
    dat = dat .. ang_m[5] .. meas[2] .. " "
end	

for i = 1,2 do
    answ[i] = lib.check_number(ang_g[i],30) .. meas[1] .. " "	
    if (ang_m[i] ~= 0) then
        answ[i] = answ[i] .. lib.check_number(ang_m[i],20) .. meas[2] .. " "
    end	
end	

            
          