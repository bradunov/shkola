
prib = "\(\approx\)" 

cifre = {}
numb1 = {}
numb2 = {}

demo = 10 
  
value1 = 127 + math.random(289) 
ceo = math.floor(value1/demo) 
ostatak = value1 - ceo * demo
if ( ostatak >= 0.5) then
    result1 = (ceo + 1) * demo
else		
    result1 = ceo * demo
end         
            
value2 = 111 + math.random(389) 
ceo = math.floor(value2/demo) 
ostatak = value2 - ceo * demo
if ( ostatak >= 0.5) then
    result2 = (ceo + 1) * demo
else		
    result2 = ceo * demo
end

near = result1 + result2          
 