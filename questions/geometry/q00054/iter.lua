include("terms")

min = 10
max = 30

base = min + math.random(max - min)
side = base + 5 + math.random(max - min)
circ = base + 2 * side

if (ITEM == 1) then
    result = circ		 
    quest = arr[1] .. tostring(base) .. arr[2] .. tostring(side) .. arr[3]
else
    result = side		 
    quest = arr[4] .. tostring(circ) .. arr[5] .. tostring(base) .. arr[6]
end	           
                   
            