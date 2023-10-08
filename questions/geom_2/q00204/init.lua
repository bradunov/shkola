
include("terms")

numb = {}
meas = {"cm", "cm²", "cm³"} 
space = "\( \ \ \ \ \) " 

quest1 = ""
quest2 = ""
ans = ""

ind = math.random(3)
ch = math.random(3)

for i = 1,2 do
	numb[i] = 2 + math.random(8)
end

if (ch == 1) then
	bound = math.ceil(3*numb[1] * (numb[1]+ math.sqrt(numb[1]^2+numb[2]^2))) 
else
	bound = numb[1]*numb[1]*numb[2]	
end	
numb[3] = bound + math.random(8) 

if (ch < 3) then
	quest1 = elem[1] .. space .. " a = " .. numb[1] .. meas[1] .. ","  	
else
	quest1 = elem[2] .. space .. " H = " .. numb[2] .. meas[1] .. "," 	
end	
if (ch == 1) then
	quest2 = elem[3] .. space .. " P = " .. numb[3] .. meas[2] .. "."  
else 
	quest2 = elem[4] .. space .. " V = " .. numb[3] .. meas[3] .. "." 	
end		

if (ind < 3) then
    coef = ind + 2
else
    coef = ind + 3
end	
par = 0.25*ind / (4-ind)
	
if (ch < 3) then
	area_b = numb[1] * numb[1]
	if (ind == 1) then
		area_b = 0.25* area_b * math.sqrt(3)
	end	
	if (ind == 3) then
		area_b = 1.5 * area_b * math.sqrt(3)
	end	
	if(ch == 1) then
        result = padez[2]	
		tmp = 2*(numb[3] - area_b)/(coef*numb[1])
		if (tmp^2 <= par*numb[1]^2) then
		    numb[3] = 6*numb[1]^2 + math.random(8) 
			tmp = 2*(numb[3] - area_b)/(coef*numb[1])			
		end	
		numb[2] = math.sqrt(tmp^2 - par*numb[1]^2)
		numb[4] = area_b * numb[2]/3
		numb[4] = lib.math.round_dec(numb[4], 1)		
		ans = "V = " .. lib.check_number(numb[4],60) .. meas[3] 
	else
        result = padez[1]	
		numb[2] = 3 * numb[3] / area_b
		tmp = math.sqrt(numb[2]^2 + par*numb[1]^2)
		numb[4] = area_b + 0.5*coef*numb[1]*tmp
		numb[4] = lib.math.round_dec(numb[4], 1)		
		ans = "P = " .. lib.check_number(numb[4],60) .. meas[2] 		
    end		
else
    area_b = 3 * numb[3] / numb[2]
	if (ind == 1) then
		numb[1] = 2*math.sqrt(area_b / math.sqrt(3))
	end	
	if (ind == 2) then
		numb[1] = math.sqrt(area_b)
	end	
	if (ind == 3) then
		numb[1] = 2*math.sqrt(area_b / (6*math.sqrt(3)))
	end	
	tmp = math.sqrt(numb[2]^2 + par*numb[1]^2)
	numb[4] = area_b + 0.5*coef * numb[1] * tmp	
	numb[4] = lib.math.round_dec(numb[4], 1)	
    result = padez[1]
	ans = "P = " .. lib.check_number(numb[4],60) .. meas[2]  
end 