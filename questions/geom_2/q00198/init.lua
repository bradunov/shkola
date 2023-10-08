
include("terms")

numb = {}
meas = {"cm", "cm²"} 
space = "\( \ \ \ \ \) " 

quest1 = ""
quest2 = ""

ind = math.random(3)
ch = math.random(5) - 1

fct = 4 - ind
coef = ind/fct

sg = math.random(2)
if (ch == 0 or ind == 1) then
   sg = 1
end  

min_range = 2
max_range = 8
	
for i = 1,2 do
	numb[i] = min_range + math.random(max_range)
end

bound = math.sqrt(numb[2]^2 + numb[1]^2/fct)
numb[4] = math.ceil(bound) + math.random(max_range)
if (ind > 1) then	
	numb[5] = numb[1] * numb[2] + math.random(max_range)		
else
	numb[5] = 0	
end	

if (ch < 3) then
	if (ch == 1) then
		bound = numb[1] + 2*numb[4]
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
	
if (sg == 1) then
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
else
	if (ch < 3) then	
		if (ch == 1) then
			if (numb[4] <= numb[1]*math.sqrt(fct)) then
				numb[4] = math.ceil(numb[1]*math.sqrt(fct)) + math.random(8)
			end				
			numb[2] = math.sqrt(numb[4]^2 - numb[1]^2/fct)			
		end
		if (ch == 2) then
			if (numb[4] <= numb[2]) then
				numb[4] = numb[2] + math.random(8)
			end			
			numb[1] = math.sqrt((numb[4]^2 - numb[2]^2)*fct )			
		end
	else
		tmp = math.sqrt(fct)		
		if (ch == 3) then
			numb[2] = tmp *numb[5] / numb[1]			
		end
		if (ch == 4) then
			numb[1] = tmp *numb[5] / numb[2] 
		end	
		numb[4] = math.sqrt(numb[2]^2+numb[1]^2/fct)	
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
		if (sg == 1) then
			if (ch == 1) then
				quest2 = elem[5] 
			else
				quest2 = elem[3]	   
			end
			quest2 = quest2 .. space .. " O = " .. numb[3] .. meas[1]  
		else 
			quest2 = elem[7] .. space .. " s = " .. numb[4] .. meas[1] 	
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
end
	
area_b = numb[1] * numb[1]
if (ind == 1) then
	area_b = 0.25* area_b * math.sqrt(3)
end	
if (ind == 3) then
	area_b = 1.5 * area_b * math.sqrt(3)
end	
area_o = math.sqrt(numb[4]^2-numb[1]^2/4) 
area_o = 0.5 * numb[1] * area_o
if (sg == 1 and ch ~= 0) then
	if (ch == 3) then
		area_o = numb[3]
    end
	if (ch == 4) then	
		area_b = numb[3]
    end		
end
if (ind < 3) then
    coef_o = ind + 2
else
    coef_o = ind + 3
end	
area = area_b + coef_o*area_o
area = lib.math.round_dec(area, 1)
                     
            