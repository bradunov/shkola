
number = {}
term = {}

cifra = 3 + math.random(3)
term[1] = 10 * (math.random(399) + 600) + cifra;
term[3] = 10 * (2222 + math.random(5555)) - cifra

value1 = term[1] + term[3]

cifra = math.random(3)
term[2] = 10 * (math.random(1999) + 3000) + cifra;
term[4] = 10 * (math.random(199) + 300) - cifra;

value2 = term[2] + term[4]

index = math.random(2)

for i = 1,2 do
    number[i] = term[i]
end	
number[3] = term[2+index]
number[4] = term[5-index]

result = value1 + value2
  



          
         
                     