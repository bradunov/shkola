
min = 10
max = 30

base = min + math.random(max - min)
side = base + 5 + math.random(max - min)
circ = base + 2 * side

if (ITEM == 1) then
    result = circ		 
    quest = "Ako je dužina osnovice " .. tostring(base) .. "cm  i dužina kraka " .. tostring(side) .. "cm, koliki je obim trougla?"
else
    result = side		 
    quest = "Ako je obim trougla " .. tostring(circ) .. "cm i dužina osnovice " .. tostring(base) .. "cm, kolika je dužina kraka trougla?"
end	           
            