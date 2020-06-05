numb = {0, 0, 0, 0}
value = {0, 0, 0}
temp = {}

ind = math.random(3)

for i = 1,2 do
    numb[i] = math.random(4)  
    numb[i+2] = math.random(8) 
    temp[i] = numb[i] * 10 + numb[i+2]	
end

value[1] = temp[1] * temp[2]

value[2] = math.floor(value[1]/100)

value[3] = value[1] - 100 * value[2]

answ = " = " .. lib.check_number(value[2]) .. measure2[ind] .. " " .. lib.check_number(value[3]) .. measure2[ind+1]
   
    
