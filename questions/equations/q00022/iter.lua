
operation = {"+", "-"}

ind = math.random(2)

term1 = math.random(69999) + 20001;
solution = math.random(8998) + 1001;
value = term1 + solution;
                  
if (ind == 1) then	
    value = term1 + solution;
else
    value = term1 - solution;	
end	
                  
term2 =  math.random(term1 - 20000) + 1001;              
        
if (ind == 1) then	
    result = value - term2;
else
    result = value + term2;	
end			               
                  