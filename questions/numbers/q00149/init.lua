cifre = {}

demo = 100   
value1 = 1111 + math.random(8888) 

fract = value1/demo
ceo = math.floor(fract) 
ostatak = fract - ceo
if ( ostatak >= 0.5) then
    result1 = (ceo + 1) * demo
else		
    result1 = ceo * demo
end         
            
value2 = 3 + math.random(6) 

near = result1 * value2          
                       
 