
number = {}

number[1] = 100 + math.random(499)
number[2] = number[1] + 100 + math.random(899 - number[1])

dif = (number[2] - number[1])/2
number[3] = number[1] + dif

for i = 1,3 do
    number[i] = number[i]/10
end	
dif = dif/10
         

