
include("terms")

numb = {}
meas = {"cm", "cm²"} 
space = "\( \ \ \ \ \) " 

quest1 = ""
quest2 = ""
ans1 = ""
ans2 = ""
ans3 = ""
ans4 = ""

ind = math.random(3)
ch = math.random(5) - 1

fct = 4 - ind
coef = ind/fct

min_range = 2
max_range = 8

for i = 1,2 do
	numb[i] = min_range + math.random(max_range)
end
 						
if (ch < 3) then
	if (ch == 1) then
                tmp = math.sqrt(numb[1]^2 + numb[2]^2)
		bound = numb[1] + 2*math.ceil(tmp)
	else
		bound = (ind + 2) * numb[1]		
		if (ind == 3) then
			bound = bound + numb[1]	
		end
	end	
else	
	if (ch == 3) then
	    tmp = math.sqrt(numb[2]^2 + 0.25*coef*numb[1]^2)
		bound = math.ceil(0.5*numb[1] * tmp)
	else
		bound = numb[1] * numb[1]	
		if (ind == 3) then
			bound = 2 * bound	
		end
	end
end   
numb[3] = bound + math.random(max_range)  

if (ch ~= 1) then
	if (ch == 2) then
		if (ind < 3) then
			numb[1] = numb[3] / (ind+2)
		else
			numb[1] = numb[3] / (ind+3)	
		end	
	end 
	if (ch == 3) then
		tmp = 2*numb[3] / numb[1]
		if (tmp <= 0.5*numb[1] * math.sqrt(coef)) then
			numb[3] = math.ceil(math.sqrt(coef)*0.25*numb[1]^2)  + math.random(8)
			tmp = 2*numb[3] / numb[1]
		end
		numb[2] = math.sqrt(tmp^2-0.25*coef*numb[1]^2)	
	end
	if (ch == 4) then
		if (ind == 2) then
			numb[1] = math.sqrt(numb[3])
		else
			numb[1] = 2 * math.sqrt(numb[3] / math.sqrt(3))	
			if (ind == 3) then
				numb[1] = numb[1]/ math.sqrt(6)  
			end			
		end
	end 
	numb[4] = math.sqrt(numb[2]^2+numb[1]^2/fct)
else
	if (numb[3] <= numb[1]) then
		numb[3] = 3*numb[1] + 2 + math.random(8)
	end
    numb[4] = 0.5 * (numb[3] - numb[1])
	numb[2] = math.sqrt(numb[4]^2-numb[1]^2/fct)
end

numb[5] = 0	
if (ind > 1) then
	numb[5] = numb[1] * numb[2]
	if (ind == 2) then
		numb[5] = numb[5] / math.sqrt(2)
	end		
end

if (ch == 0) then
    quest1 = elem[1] .. space .. " a = " .. numb[1] .. meas[1]  
	quest2 = elem[2] .. space .. " H = " .. numb[2] .. meas[1] 
else	
	if (ch == 1 or ch == 3) then
		quest1 = elem[1] .. space .. " a = " .. numb[1]  	
	else
		quest1 = elem[2] .. space .. " H = " .. numb[2]  	
	end	
	quest1 = quest1 .. meas[1] .. ","
	if (ch < 3) then
		if (ch == 1) then
			quest2 = elem[5] 
		else
			quest2 = elem[3]	   
		end
		quest2 = quest2 .. space .. " O = " .. numb[3] .. meas[1]   		
	else
		if (ch == 3) then
			quest2 = elem[6] 
		else
			quest2 = elem[4]	   
		end
		quest2 = quest2 .. space .. " P = " .. numb[3] .. meas[2]
	end	
end

for i = 1,5 do
	numb[i] = lib.math.round_dec(numb[i], 2)
end

if (ch ~= 0) then
	if (ch == 1 or ch == 3) then
		ans1 = elem[2] .. space .. " H = " .. lib.check_number(numb[2]) 	
	else
		ans1 = elem[1] .. space .. " a = " .. lib.check_number(numb[1]) 	
	end	
	ans1 = ans1 .. meas[1] .. ","
end	
ans2 = elem[7] .. space .. " s = " .. lib.check_number(numb[4],40) .. meas[1] 
if (ind == 1) then
	ans2 = ans2 .. "."
	ans3 = ""
	ans4 = ""
else
	ans2 = ans2 .. "," 	
	ans3 = elem[8]
	ans4 = " Q = " .. lib.check_number(numb[5],50) .. meas[2] .. "." 
end