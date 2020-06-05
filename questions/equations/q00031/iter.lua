
total = math.random(699999) + 200001
number = math.random(89) + 11
numberkg = number * 10^3
                                                                                                                                 
if (ITEM == 1) then 
    solution = total - numberkg 
    sign = "-" 
    comp = ">"	
	quest = "proda tako da u silosu ostane više od"
else 
    number = number * 100
    numberkg = numberkg * 100
    solution =  numberkg - total
    sign = "+"	
	comp = "<"
	quest = "doda u silos, ako u silos može da stane manje od"	
end
                
            
            
                      
            