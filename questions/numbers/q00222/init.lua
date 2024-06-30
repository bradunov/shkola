
include("names")
include("terms")

rm = math.random(#musko_ime_nom)
ime1 = musko_ime_nom[rm] 

rf = math.random(#zensko_ime_nom)
ime2 = zensko_ime_nom[rf]

money = {50, 20, 10, 5, 2, 1}
space = "\( \ \ \ \)"

total = {}
total[1] = math.random(60) + 39;
total[2] = math.random(50) + 49;
                  
quest = {"", ""}

value = total[1] - total[2]
reply = "answer == '" .. ime1 .. "' ";  
ans = "answer = '" .. ime1 .. "' ";  

if (value == 0) then
    value = 2 + math.random(19)
    total[2] = total[2] - value
end

if (value < 0) then
    value = - value 
    reply = "answer == '" .. ime2 .. "' ";  
    ans = "answer = '" .. ime2 .. "' ";  
end	

for j = 1,2 do
    temp = total[j] 
    for i = 1,6 do
        factor = math.floor(temp/money[i])
	    if (factor ~= 0) then		
		    if (i < 4) then
			    if(factor > 1) then
			       moneta = plural[1]
				else
			       moneta = apoen[1]		   
                end				   
			else
 			    if(factor > 1) then
			       moneta = plural[2]	   
				else
			       moneta = apoen[2]	   
                end		
            end	
            if (i == 6) then
       			valuta = valute[1]
			else
			    valuta = valute[2]
			end	
			quest[j] = quest[j] .. space .. tostring(factor) .. " " .. moneta .. od .. tostring(money[i]) .. " " .. valuta  	
	    end 
        temp = temp - factor * money[i]		
    end
end
          
          
	
	
