
cifre = {}

cifre[3] = math.random(9)
cifre[2] = math.random(10) - 1
cifre[1] = math.random(9)
number = cifre[3] * 100 + cifre[2] * 10 + cifre[1] 

if (cifre[1] >= 5) then
    cifre[2] = cifre[2] + 1
end	
decade = cifre[3] * 100 + cifre[2] * 10

if (cifre[2] >= 5) then
    cifre[3] = cifre[3] + 1
end	
hundred = cifre[3] * 100

	
       
   
