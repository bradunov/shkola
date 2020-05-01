
measure = {"m", "dm", "cm","mm"}
numb = {0, 0, 0, 0}
value = {0, 0, 0}
temp = {}

ind = math.random(3)

for i = 1,2 do
    numb[i] = math.random(4)  
    numb[i+2] = math.random(8) 
    temp[i] = numb[i] * 10 + numb[i+2]	
end

circ = 2 * (temp[1] + temp[2])

value[2] = math.floor(circ/10)

value[3] = circ - 10 * value[2]

if (value[2] > 9 and ind > 1) then
    value[1] = math.floor(value[2]/10)
    value[2] = value[2] - 10 * value[1] 
    answ = " = " .. lib.check_number(value[1],20) .. measure[ind-1] .. " ".. lib.check_number(value[2],20) .. measure[ind] .. " " .. lib.check_number(value[3],20) .. measure[ind+1]
else
    answ = " = " .. lib.check_number(value[2],20) .. measure[ind] .. " " .. lib.check_number(value[3],20) .. measure[ind+1]
end	
   
    

   
    
