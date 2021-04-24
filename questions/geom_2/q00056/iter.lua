
ang_g = {}
ang_m = {}
ang = {}
sign = {""} 
result = ""
reply = ""

ind = math.random(3)
ang_g[2] = 50 +(2 - ind) * math.random(30)
ang_m[2] = math.random(51) - 1
ang[2] = ang_g[2] * 60 + ang_m[2]	
ang_g[1] = 178 - 2 * ang_g[2] 
ang_m[1] = 120 - 2 * ang_m[2]
temp =  math.floor(ang_m[1]/60) 
ang_g[1] = ang_g[1] + temp    
ang_m[1] = ang_m[1] - 60 * temp
ang[1] = ang_g[1] * 60 + ang_m[1]
ang_g[3] = ang_g[2] 
ang_m[3] = ang_m[2] 
ang[3] = ang[2] 
ang_g[4] = 2 * ang_g[2] 
ang_m[4] = 2 * ang_m[2] 
temp =  math.floor(ang_m[4]/60) 
ang_g[4] = ang_g[4] + temp    
ang_m[4] = ang_m[4] - 60 * temp
ang[4] = 2 * ang[2] 
ang_g[5] = 179 - ang_g[2] 
ang_m[5] = 60 - ang_m[2] 
temp =  math.floor(ang_m[5]/60) 
ang_g[5] = ang_g[5] + temp    
ang_m[5] = ang_m[5] - 60 * temp
ang[5] = ang_g[5] * 60 + ang_m[5] 
ang_g[6] = ang_g[5] 
ang_m[6] = ang_m[5] 
ang[6] = ang[5] 

ch = math.random(6)
if (ang_g[1] > 90) then
    result =  "answer == '" .. msg1[3] .. "' "  ..
        "|| answer == '" .. msg2[3] .. "'" ;
    ans = "answer = '" .. msg1[3] .. "' ";
else
    if (ang_g[1] < 90) then
        result =  "answer == '" .. msg1[1] .. "' "  ..
           "|| answer == '" .. msg2[1] .. "'" ;
        ans = "answer = '" .. msg1[1] .. "' ";
    else	   
        result =  "answer == '" .. msg1[2] .. "' "  ..
           "|| answer == '" .. msg2[2] .. "'" ;
        ans = "answer = '" .. msg1[2] .. "' ";
	end
end	

if (ang[1] > ang[2]) then
	sign[1] = answ[1]
	sign[2] = answ[3]
    reply = lib.check_string_case(name[2],30) .. " " .. " " .. lib.check_one_option_dropdown(answ, sign[1]) .. " " .. " " .. lib.check_string_case(name[3],30) .. " " .. lib.check_one_option_dropdown(answ, sign[2]) .. " " .. lib.check_string_case(name[1],30)  	
else 
    if (ang[1] < ang[2]) then
	    sign[1] = answ[3]
	    sign[2] = answ[1]
        reply = lib.check_string_case(name[1],30) .. " " .. " " .. lib.check_one_option_dropdown(answ, sign[1]) .. " " .. " " .. lib.check_string_case(name[2],30) .. " " .. lib.check_one_option_dropdown(answ, sign[2]) .. " " .. lib.check_string_case(name[3],30)  	
    else 
	    sign[1] = answ[1]
	    sign[2] = answ[1]
        reply = lib.check_string_case(name[1],30) .. " " .. " " .. lib.check_one_option_dropdown(answ, sign[1]) .. " " .. " " .. lib.check_string_case(name[2],30) .. " " .. lib.check_one_option_dropdown(answ, sign[2]) .. " " .. lib.check_string_case(name[3],30)  	
    end			
end     
              