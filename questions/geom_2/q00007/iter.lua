
numb1 = 2 + math.random(9);
numb2 = numb1 + 2 + math.random(15 - numb1)

min = numb2 - numb1
max = numb2 + numb1

ind = math.random(6)

ans = ""
if (ind == 1) then 
	ans = "AB " .. lib.check_string(">",10) .. " " .. lib.check_number(max,15) .. meas 
end	
if (ind == 2) then 
	ans = "AB " .. lib.check_string("=",10) .. " " .. lib.check_number(max,15) .. meas 	
end	
if (ind == 3) then 
	ans = "AB " .. lib.check_string("=",10) .. " " .. lib.check_number(min,15) .. meas 	
end	
if (ind == 4) then    
	ans = lib.check_number(min,15) .. meas .. lib.check_string("<",10) .. "AB" .. lib.check_string("<",10) .. lib.check_number(max,15) .. meas 	
end	
if (ind == 5) then 
	ans = "AB " .. lib.check_string("<",10) .. " " .. lib.check_number(min,15) .. meas 	
end	
if (ind == 6) then 
	ans = "AB " .. lib.check_string("=",10) .. " " .. lib.check_number(0,15) .. meas 	
end	