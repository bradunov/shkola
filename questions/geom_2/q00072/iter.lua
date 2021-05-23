
ang_g = {}
ang_m = {}

answ = {}
ind = {}

out = {}
dat = ""

sign = math.random(3)
first_g = 90 +(2 - sign) * math.random(50)
first_m = math.random(59) - 1

ang_g[1] = first_g 
ang_m[1] = first_m 
ang_g[2] = 179 - first_g 
ang_m[2] = 60 - first_m 
temp =  math.floor(ang_m[2]/60) 
ang_g[2] = ang_g[2] + temp    
ang_m[2] = ang_m[2] - 60 * temp
ang_g[3] = ang_g[1] 
ang_m[3] = ang_m[1] 	
ang_g[4] = ang_g[2] 
ang_m[4] = ang_m[2] 

out = lib.math.random_shuffle(index)
number = numb[out[1]]
dat = ang_g[out[1]] .. meas[1] .. " "
if (ang_m[out[1]] ~= 0) then
    dat = dat .. ang_m[out[1]] .. meas[2] .. " "
end	

nr = 0
for i = 1,4 do
    if (numb[i] ~= number) then
	    nr = nr + 1
	    ind[nr] = i
        answ[nr] = lib.check_number(ang_g[ind[nr]],30) .. meas[1] .. " "	
        if (ang_m[ind[i]] ~= 0) then
            answ[nr] = answ[nr] .. lib.check_number(ang_m[ind[nr]],20) .. meas[2] .. " "
        end	
	end	
end	
        

       

            
            
            
          