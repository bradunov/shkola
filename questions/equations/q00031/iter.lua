
include("terms")

answ = {"<", ">", "≤", "≥"}

total = math.random(699999) + 200001
number = math.random(89) + 11
numberkg = number * 10^3
                                                                                                                                 
if (ITEM == 1) then 
    solution = total - numberkg 
    sign = "-" 
	ind = 2*math.random(2)
	index = ind - 1
else 
    number = number * 100
    numberkg = numberkg * 100
    solution =  numberkg - total
    sign = "+"	
	ind = 2*math.random(2) - 1	
	index = ind	
end
text = relat[ind]
compneq = answ[ind]	
comp =  answ[index]	    
                         
                
            
            
                      
            