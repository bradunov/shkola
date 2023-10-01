
include("terms")

numb = {}
meas = {"cm", "cm²"} 
space = "\( \ \ \ \ \) " 

quest1 = ""
quest2 = ""


ind = math.random(3)
ch = math.random(5) - 1

for i = 1,2 do
	numb[i] = 2 + math.random(8)
end

if (ch == 0) then
    quest1 = elem[1] .. space .. " a = " .. numb[1] .. meas[1]  	
    quest2 = elem[2] .. space .. " H = " .. numb[2] .. meas[1] 	
else
	if (ch < 3) then
		if (ch == 1) then
			min_range = 2*(numb[1]+numb[2]) + 1
		else
			min_range = (ind + 2) * numb[1]	+ 1	
			if (ind == 3) then
				min_range = min_range + numb[1]	
			end
		end	
	else	
		if (ch == 3) then
			min_range = numb[1] * numb[2] + 1
		else
			min_range = numb[1] * numb[1] + ind - 1	
			if (ind == 3) then
				min_range = 3 * numb[1] * numb[1]	
			end
		end
	end   
	numb[3] = min_range + math.random(5)  
	if (ind > 1) then
		numb[4] = 2*numb[1] + numb[2] + 1 + math.random(5)	
		numb[5] = 2*numb[1] * numb[2] + 1 + math.random(5)		
	else
		numb[4] = 0
		numb[5] = 0	
	end	

	if (ch == 1 or ch == 3) then
		quest1 = elem[1] .. space .. " a = " .. numb[1]  	
	else
		quest1 = elem[2] .. space .. " H = " .. numb[2]  	
	end	
	quest1 = quest1 .. meas[1] .. ","
 
	sg = math.random(2)
    if (ind == 1) then
        sg = 1
	end
	if (ch < 3) then
		if (sg == 1) then
			if (ch == 1) then
				quest2 = elem[5] 
			else
				quest2 = elem[3]	   
			end
			quest2 = quest2 .. space .. " O = " .. numb[3] .. meas[1]  
		else 
			quest2 = elem[7] .. space .. " d = " .. numb[4] .. meas[1] 	
		end		
	else
		if (sg == 1) then
			if (ch == 3) then
				quest2 = elem[6] 
			else
				quest2 = elem[4]	   
			end
			quest2 = quest2 .. space .. " S = " .. numb[3] .. meas[2]
		else
			quest2 = elem[8] .. space .. " Q = " .. numb[5] .. meas[2] 	
		end			
	end	
    if (sg == 1) then
		if (ch == 1) then
			numb[2] = 0.5 * (numb[3] - 2*numb[1])
		end
		if (ch == 3) then
			numb[2] = numb[3] / numb[1]
		end
		if (ch == 2) then
			if (ind < 3) then
				numb[1] = numb[3] / (ind+2)
			else
				numb[1] = numb[3] / (ind+3)	
			end
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
	else
	    if (ind < 3) then
		    tmp = math.sqrt(2)
        else
            tmp = 2
        end			
		if (ch == 1) then
			numb[2] = math.sqrt(numb[4]^2 - tmp^2*numb[1]^2)
		end
		if (ch == 2) then
			numb[1] = math.sqrt(numb[4]^2 - numb[2]^2) /tmp 
		end
		if (ch == 3) then
			numb[2] = numb[5] / (tmp*numb[1])
		end
		if (ch == 4) then
			numb[1] = numb[5] / (tmp*numb[2]) 
		end		
	end
end
	
area_b = numb[1] * numb[1]
if (ind == 1) then
	area_b = 0.25* area_b * math.sqrt(3)
end	
if (ind == 3) then
	area_b = 1.5 * area_b * math.sqrt(3)
end	
area_o = numb[1] * numb[2]
if (ind < 3) then
    coef = ind + 2
else
    coef = ind + 3
end	
if (sg == 1 and ch == 4) then
	area_b = numb[3]
end
if (sg == 1 and ch == 3) then
	area_o = numb[3]	
end

area = 2*area_b + coef*area_o
area = lib.math.round_dec(area, 2)
                     
            