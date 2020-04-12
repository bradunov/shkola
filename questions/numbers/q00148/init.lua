
cifre = {}
numb1 = {}
numb2 = {}

ind = math.random(2)
demo = 10^ind   
value1 = 1111 + math.random(8888) 

fract = value1/demo
ceo = math.floor(fract) 
ostatak = fract - ceo
if ( ostatak >= 0.5) then
    result1 = (ceo + 1) * demo
else		
    result1 = ceo * demo
end         
            
value2 = 1111 + math.random(8888) 

fract = value2/demo
ceo = math.floor(fract) 
ostatak = fract - ceo
if ( ostatak >= 0.5) then
    result2 = (ceo + 1) * demo
else		
    result2 = ceo * demo
end

near = result1 + result2          
                  