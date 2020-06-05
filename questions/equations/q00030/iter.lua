
text1 = {"iskrca", "ukrca"}
text2 = {"ostaje", "će biti"}
text3 = {"iskrcalo", "ukrcalo"}

total = (math.random(2990) + 1010) ;
temp = math.floor(total/2)
                                                                                                                                 
if (ITEM == 1) then
    solution = 100 + math.random(temp - 500) 
    number = total - solution
    sign = "-"  
else
    solution = 100 + math.random(temp - 500) 
    number = total + solution 	
    sign = "+"	
end
                     
                       
            