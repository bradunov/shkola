
letter = {"a", "b", "c", "m", "n", "p", "x", "y", "z"}
operation = {"*", ":"}

bracl = "\(\bigl(\)"
bracr = "\(\bigl)\)"

numb = {""}
nugr = {}
sign = {}

quest = ""
answ = ""

op = math.random(2)
oper = operation[op]
op3 = math.random(2)
oper3 = operation[op3]

choice = math.random(9)
base = letter[choice]
base1 = "-" .. base
cor = ""

ind = math.random(3)
stampa =  1 + math.random(2)
max_range = 6      --[[ max_range > 3 ]]--

if (stampa == 2) then
	nugr[3] = 1 + math.random(4)			    	
	if (ind == 1) then
		nugr[1] = 1 + math.random(max_range)		
		sum = nugr[1] * nugr[3]
		if (op == 1) then
			nugr[2] = 1 + math.random(max_range)		
			sum = sum + nugr[2]
		else
			nugr[2] = 1 + math.random(sum-2)		
			sum = sum - nugr[2]   
		end		   
	end
	if (ind == 2) then
		nugr[2] = 1 + math.random(max_range)
		sum = nugr[2] * nugr[3]	
		if (op == 1) then
			nugr[1] = 1 + math.random(max_range)		
			sum = nugr[1] + sum
		else
			nugr[1] = sum + math.random(max_range)		
			sum = nugr[1] - sum 
		end			
	end
	if (ind == 3) then
		nugr[2] = 1 + math.random(max_range)	
		if (op == 1) then
			nugr[1] = 1 + math.random(max_range)		
			sum = (nugr[1] + nugr[2]) * nugr[3]			
		else
			nugr[1] = nugr[2] + math.random(max_range)			
			sum = (nugr[1] - nugr[2]) * nugr[3]				
		end		  
	end	
else
	nugr[4] = 2 + math.random(4)
	nugr[5] = 1 + math.random(4)				    	
	if (ind == 1) then
		if (op3 == 1) then
			nugr[2] = 1 + math.random(max_range-2)			
			nugr[3] = 1 + math.random(max_range-2)		
			sum = nugr[2] + nugr[3]
		else
			nugr[2] = 3 + math.random(max_range-2)			
			nugr[3] = 1 + math.random(nugr[2]-2)		
			sum = nugr[2] - nugr[3]   
		end					
		sum = sum * nugr[5]
		if (op == 1) then
			nugr[1] = 1 + math.random(max_range-2)		
			sum = nugr[1] * nugr[4] + sum 
		else
			nugr[1] = sum + math.random(max_range-2)		
			sum = nugr[1] * nugr[4] - sum    
		end		   
	end
	if (ind == 2) then
		nugr[1] = 3 + math.random(max_range-2)		
		sum = nugr[1] * nugr[4]  		
		if (op == 1) then
			nugr[2] = 1 + math.random(max_range-2)		
			sum = sum + nugr[2]  
		else
			nugr[2] = 1 + math.random(sum-4)		
			sum = sum - nugr[2]    
		end		
		if (op3 == 1) then			
			nugr[3] = 1 + math.random(max_range-2)		
			sum = sum + nugr[3] * nugr[5]
		else			
			nugr[3] = 1 + math.random(nugr[1]-2)
			nugr[5] = 1 + math.random(nugr[4]-2)			
			sum = sum - nugr[3] * nugr[5] 				
		end								
	end
	if (ind == 3) then
		if (op == 1) then
			nugr[1] = 1 + math.random(max_range-2)			
			nugr[2] = 1 + math.random(max_range-2)		
			sum = nugr[1] + nugr[2]
		else
			nugr[1] = 4 + math.random(max_range-2)			
			nugr[2] = 1 + math.random(nugr[1]-4)		
			sum = nugr[1] - nugr[2]   
		end	
		tmp = sum			
		sum = sum * nugr[4]
		if (op3 == 1) then
			nugr[3] = 1 + math.random(max_range-2)		
			sum = sum + nugr[3] * nugr[5] 
		else
			nugr[3] = 1 + math.random(tmp-2)
			nugr[5] = 1 + math.random(nugr[4]-2)			
			sum = sum - nugr[3] * nugr[5] 			
		end	
	end	
end	

for i = 1,stampa do	
	sg = math.random(2)
	if (sg == 1) then 
		numb[i] = "(" .. base .. ")\(^{" .. nugr[i] .. "}\) "
		sign[i] = 1			
	else
		numb[i] = "(" .. base1 .. ")\(^{" .. nugr[i] .. "}\) "
		sign[i] = - 1
	end
end

if (stampa == 2) then
    frc = math.random(2)
    if (ind == 1) then
        if (frc == 1 and op == 2) then 
			broj = bracl .. numb[1] .. bracr .. "\(^{" .. nugr[3]  .. "}\) " 
			imen =  numb[2]
			quest = lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end()
        else		
			quest = bracl .. numb[1] .. bracr .. "\(^{" .. nugr[3]  .. "}\) " .. oper .. " " .. numb[2]
        end		
		sigans = sign[1]^(nugr[1] * nugr[3]) * (sign[2]^nugr[2])		
    end	
    if (ind == 2) then
       if (frc == 1 and op == 2) then 
			broj = numb[1] 
			imen =  bracl .. numb[2] .. bracr .. "\(^{" .. nugr[3]  .. "}\) "
			quest = lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end()
        else		
			quest = numb[1] .. oper .. " " .. bracl .. numb[2] .. bracr .. "\(^{" .. nugr[3]  .. "}\) "
		end
		sigans = sign[2]^(nugr[2] * nugr[3]) * (sign[1]^nugr[1])		 
    end	
    if (ind == 3) then	
        if (frc == 1 and op == 2) then 
			broj = numb[1] 
			imen =  numb[2]
			quest = bracl .. lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end() .. bracr .. "\(^{" .. nugr[3]  .. "}\) "
        else		
			quest = bracl .. numb[1] .. oper .. " " .. numb[2] .. bracr .. "\(^{" .. nugr[3]  .. "}\) "
		end	
		sigans = (sign[1]^nugr[1] * sign[2]^nugr[2])^nugr[3]		 
    end
else
    if (ind == 1) then	
        quest = bracl .. numb[1] .. bracr .. "\(^{" .. nugr[4]  .. "}\) " .. oper .. " " .. bracl .. numb[2] .. oper3 .. " " .. numb[3] .. bracr .. "\(^{" .. nugr[5]  .. "}\) "  
		sigans = sign[1]^(nugr[1] * nugr[4]) * sign[2]^(nugr[2]*nugr[5]) * sign[3]^(nugr[3]*nugr[5])		
    end	
    if (ind == 2) then	
        quest = bracl .. numb[1] .. bracr .. "\(^{" .. nugr[4]  .. "}\) " .. oper .. " " .. numb[2] .. " " .. oper3 .. bracl .. numb[3] .. bracr .. "\(^{" .. nugr[5]  .. "}\) "  
		sigans = sign[1]^(nugr[1] * nugr[4]) * sign[2]^(nugr[2]) * sign[3]^(nugr[3]*nugr[5])			 
    end	
    if (ind == 3) then	
        quest =  bracl .. numb[1] .. oper .. " " .. numb[2] .. bracr .. "\(^{" .. nugr[4]  .. "}\) " ..  oper3 .. " " .. bracl .. numb[3] .. bracr .. "\(^{" .. nugr[5]  .. "}\) " 
		sigans = sign[1]^(nugr[1] * nugr[4]) * sign[2]^(nugr[2]*nugr[4]) * sign[3]^(nugr[3]*nugr[5])			 
    end
    frc = math.random(3)
	if (frc < 3) then
	    if (ind == 1) then
	        if (frc == 1 and op == 2) then
				broj = bracl .. numb[1] .. bracr .. "\(^{" .. nugr[4]  .. "}\) " 
				imen =  bracl .. numb[2] .. oper3 .. " " .. numb[3] .. bracr .. "\(^{" .. nugr[5]  .. "}\) " 
				quest = lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end() 		
		    end
	        if (frc == 2 and op3 == 2) then
				quest = bracl .. numb[1] .. bracr .. "\(^{" .. nugr[4]  .. "}\) " .. oper .. " " .. bracl .. lib.frac_start() .. numb[2] .. lib.frac_mid() .. numb[3] .. lib.frac_end() .. bracr .. "\(^{" .. nugr[5]  .. "}\) "  
            end				
		end	
	    if (ind == 2) then
	        if (frc == 1 and op == 2) then
				broj = bracl .. numb[1] .. bracr .. "\(^{" .. nugr[4]  .. "}\) "
				imen =  numb[2]
				quest = lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end() .. " " .. oper3 .. bracl .. numb[3] .. bracr .. "\(^{" .. nugr[5]  .. "}\) " 		
		    end
	        if (frc == 2 and op3 == 2) then
				broj = bracl .. numb[1] .. bracr .. "\(^{" .. nugr[4]  .. "}\) " .. oper .. " " .. numb[2] 
				imen =  bracl .. numb[3] .. bracr .. "\(^{" .. nugr[5]  .. "}\) " 
				quest =  lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end() 
            end				
		end	
	    if (ind == 3) then
	        if (frc == 1 and op == 2) then
				quest = bracl .. lib.frac_start() .. numb[1] .. lib.frac_mid() .. numb[2] .. lib.frac_end() .. bracr .. "\(^{" .. nugr[4]  .. "}\) " ..  oper3 .. " " .. bracl .. numb[3] .. bracr .. "\(^{" .. nugr[5]  .. "}\) " 	
		    end
	        if (frc == 2 and op3 == 2) then
				broj = bracl .. numb[1] .. oper .. " " .. numb[2] .. bracr .. "\(^{" .. nugr[4]  .. "}\) "
				imen =  bracl .. numb[3] .. bracr .. "\(^{" .. nugr[5]  .. "}\) "  
				quest =  lib.frac_start() .. broj .. lib.frac_mid() .. imen .. lib.frac_end() 
            end				
		end			
    end		
end
	
if (sigans == -1) then
	cor = "-"
end 	
answ = lib.check_string(cor,10) .. lib.check_string(base,15) .. lib.sup_start() .. lib.check_number(sum,20) .. lib.sup_end()  
		     