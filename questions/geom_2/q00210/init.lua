
include("terms")

numb = {}
meas = {"cm", "cm²"} 
space = "\( \ \ \ \ \) " 

symb = "π"
pi = 22/7

quest1 = ""
quest2 = ""
ans1 = ""
ans2 = ""
ans3 = ""


ch = math.random(5)

for i = 1,2 do
	numb[i] = 2 + math.random(8)
end

if (ch == 1) then
	min_range = 7 * numb[1]	+ 1	
else	
    if (ch == 2) then
		min_range = 4 * numb[1] * numb[1] + 1	
	else		
	    min_range =  7 * numb[1] * numb[2] + 1		
	end
end   
numb[3] = min_range + math.random(8)  
numb[4] = 2 * numb[1] * numb[2] + math.random(8)

if (ch < 4) then
    quest1 = elem[2] .. space .. " H = " .. numb[2]  	
else
    quest1 = elem[1] .. space .. " r = " .. numb[1]  	
end	
quest1 = quest1 .. meas[1]

if (ch == 1) then
	quest2 = elem[3] .. space .. " O = " .. numb[3] .. meas[1]   		
else
    if (ch < 4) then
		if (ch == 2) then
			quest2 = elem[4] .. space .. " P = " .. numb[3] .. meas[2]		
		else
			quest2 = elem[6] .. space .. " Q = " .. numb[4] .. meas[2]	   
		end
    else
		if (ch == 4) then
			quest2 = elem[6] .. space .. " Q = " .. numb[4] .. meas[2]		
		else
			quest2 = elem[5] .. space .. " P = " .. numb[3] .. meas[2]	   
		end
    end	
end	

if (ch < 3) then
	if (ch == 1) then
		numb[1] = numb[3] / (2*pi)
	end
	if (ch == 2) then
		numb[1] = math.sqrt(numb[3] / pi)
	end
	numb[4] =  2 * numb[1] * numb[2]
else	
	if (ch == 3) then
		numb[1] = numb[4] / (2*numb[2])
		numb[3] = numb[1] * numb[1] * pi
	end 
	if (ch == 4) then
		numb[2] = numb[4] / (2*numb[1])
		numb[3] = 2*pi*numb[1] * numb[2] 
	end 
	if (ch == 5) then
		numb[2] = numb[3] / (2*pi*numb[1])
		numb[4] = 2*numb[1] * numb[2] 
	end 
end	

for i = 1,4 do
	numb[i] = lib.math.round_dec(numb[i], 2)
end

if (ch < 4) then
    ans1 = elem[1] .. space .. " r = " .. lib.check_number(numb[1]) 	
else
    ans1 = elem[2] .. space .. " H = " .. lib.check_number(numb[2]) 	
end	
ans1 = ans1 .. meas[1]
if (ch < 3) then
	ans2 = elem[6] .. space .. " Q = " .. lib.check_number(numb[4],50) .. meas[2] 	
else
    if (ch < 5) then
	    if (ch == 4) then
			ans2 = elem[5]  
        else
			ans2 = elem[4]  		
        end
		ans2 = ans2 .. space .. " P = " .. lib.check_number(numb[3],50)
	else
		ans2 = elem[6] .. space .. " Q = " .. lib.check_number(numb[4],50) .. meas[2]
    end
end	
            
            