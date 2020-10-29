
measure = {"m","dm","cm"}
numb = {}

indr = 1 + math.random(2)
indl = indr-1

numb[1] = math.random(9) 
numb[2] = math.random(10) - 1 	
value = numb[1] * 10 + numb[2]
    
answ = ""

index = math.random(2)

if (index == 1) then
    mes = measure[indl]
    for i = 1,2 do
        if (numb[i] ~= 0) then    
            answ = answ .. " " .. tostring(math.floor(numb[i])) .. mes
        end
	    mes = measure[indr]
    end	                                                       
    answ = answ .. " = " .. lib.check_number(value,20) .. measure[indr]
else
    mes = measure[indl]
    for i = 1,2 do
        if (numb[i] ~= 0) then    
            answ = answ .. " " .. lib.check_number(numb[i],15) .. mes
        end
     	mes = measure[indr]
    end	                                                       
    answ = answ .. " = " .. tostring(math.floor(value)) .. measure[indr]
end   
