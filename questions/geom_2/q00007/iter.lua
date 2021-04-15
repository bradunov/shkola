
numb1 = 2 + math.random(9);
numb2 = numb1 + 2 + math.random(15 - numb1)

min = numb2 - numb1
max = numb2 + numb1

ind = math.random(6)

reply = ""
if (ind == 1) then 
	reply = "AB " .. lib.check_one_option_dropdown(answ,">") .. " " .. lib.check_number(max,15) .. meas 
end	
if (ind == 2) then 
	reply = "AB " .. lib.check_one_option_dropdown(answ,"=") .. " " .. lib.check_number(max,15) .. meas 	
end	
if (ind == 3) then 
	reply = "AB " .. lib.check_one_option_dropdown(answ,"=") .. " " .. lib.check_number(min,15) .. meas 	
end	
if (ind == 4) then    
	reply = lib.check_number(min,15) .. meas .. lib.check_one_option_dropdown(answ,"<") .. "AB" .. lib.check_one_option_dropdown(answ,"<") .. lib.check_number(max,15) .. meas 	
end	
if (ind == 5) then 
	reply = "AB " .. lib.check_one_option_dropdown(answ,"<") .. " " .. lib.check_number(min,15) .. meas 	
end	
if (ind == 6) then 
	reply = "AB " .. lib.check_one_option_dropdown(answ,"=") .. " " .. lib.check_number(0,15) .. meas 	
end	