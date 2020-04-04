
cifre = {}

ind = math.random(3)
demo = 10^ind   
value = 1111 + math.random(8888) 

fract = value/demo
ceo = math.floor(fract) 
ostatak = fract - ceo
if ( ostatak >= 0.5) then
    result = (ceo + 1) * demo
else		
    result = ceo * demo
end         
            
                