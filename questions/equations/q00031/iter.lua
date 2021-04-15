
include("terms")

answ = {"<", ">"}

total = math.random(699999) + 200001
number = math.random(89) + 11
numberkg = number * 10^3
                                                                                                                                 
if (ITEM == 1) then 
    solution = total - numberkg 
    sign = "-" 
    comp = ">"	
else 
    number = number * 100
    numberkg = numberkg * 100
    solution =  numberkg - total
    sign = "+"	
	comp = "<"
end
     
                
            
            
                      
            