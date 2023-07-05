
numb = {}
out = {}
ans = {""}
	
ind = math.random(3) 
if (ind < 3) then
	numb[1] = 20 + math.random(60)
	if (ind == 1) then
		numb[2] = 20 + math.random(60)
		if (numb[2] == numb[1]) then
		    ind = 2
		end	
	else
		numb[2] = numb[1]
	end
	if (ind == 2 and numb[1] == 60) then
	    numb[1] = numb[1] - 2 - math.random(8)
		numb[2] = numb[1]
	end
	numb[3] = 180 - numb[1]	- numb[2]
else
	numb[1] = 20 + math.random(50)
	numb[2] = 90 - numb[1]
	numb[3] = 90
end	
  
for i = 1,3 do
    out[i] = i
end
out = lib.math.random_shuffle(out)  
ans[1] = "△ABC:" .. space 
ans[2] = "△PQR:" .. space        
for i = 1,3 do
	if (ind < 3) then
	    if (i == out[1]) then
		    ans[1] = ans[1] .. space .. orig[i] .. " = " .. numb[i] .. meas		
			ans[2] = ans[2] .. space .. pt[i] .. " = " .. lib.check_number(numb[i],25) .. meas
		else
			ans[1] = ans[1] .. space .. orig[i] .. " = " .. lib.check_number(numb[i],25) .. meas
			if (i == out[2] and ind == 1) then   
				ans[2] = ans[2] .. space .. pt[i] .. " = " .. numb[i] .. meas	
            else				
				ans[2] = ans[2] .. space .. pt[i] .. " = " .. lib.check_number(numb[i],25) .. meas	
			end
		end
	else
	    sg = math.random(2)
		if (i == sg) then
			ans[1] = ans[1] .. space .. orig[i] .. " = " .. numb[i] .. meas	
		else			
			ans[1] = ans[1] .. space .. orig[i] .. " = " .. lib.check_number(numb[i],25) .. meas		
     	end	
		if (i == 3) then
			ans[2] = ans[2] .. space .. pt[i] .. " = " .. numb[i] .. meas
		else			
			ans[2] = ans[2] .. space .. pt[i] .. " = " .. lib.check_number(numb[i],25) .. meas		
     	end				
	end
	if (i < 3) then
		ans[1] = ans[1] .. space
		ans[2] = ans[2] .. space		
	end  
end	

if (ind == 2) then
    note = msg
else
    note = ""
end	 