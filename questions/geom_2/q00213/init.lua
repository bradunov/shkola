
include("terms")

numb = {}
meas = {"cm", "cm²", "cm³"} 
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

if (ch == 2) then
    area_b = numb[3]
else	
	area_b = numb[1]*numb[1]*pi
end	
if (ch == 5) then
	area = 2*area_b + numb[3]
else
	area = 2*area_b + 2*pi*numb[1]*numb[2]
end	
vol = area_b * numb[2]
area = lib.math.round_dec(area, 1)
vol = lib.math.round_dec(vol, 1)


      