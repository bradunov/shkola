
number = {}

deg2 = 1 + math.random(2)
deg1 = deg2 + 1 + math.random(3)
number[1] =  math.random(999) * 10^deg1 
number[2] =  math.random(99) * 10^deg2  
sg = math.random(2)
if (sg == 1) then
   value = number[1] - number[2]
   sign = "-"
else
   value = number[1] + number[2]
   sign = "+"     
end
            