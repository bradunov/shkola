
number = {}
term = {}

term[1] = math.random(3999) + 6000;
term[2] = math.random(1999) + 3000;

value1 =  (222 + math.random(555)) * 10^2
if ( value1 <= term[1] ) then
    value1 = value1 * 10
end	
term[3] = value1 - term[1] 

value2 = (111 + math.random(444)) * 10^2
if ( value2 <= term[2] ) then
    value2 = value2 + 111
end	
term[4] = value2 - term[2] 

index = math.random(2)

for i = 1,2 do
    number[i] = term[i]
end	
number[3] = term[2+index]
number[4] = term[5-index]

result = value1 + value2
    




          
         
                     