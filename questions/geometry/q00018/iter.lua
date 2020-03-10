
min = 2;
max = 20;

side = min + math.random(max - min);
factor = min + math.random(5);


if (ITEM == 1) then
    circ = side * 4
    answ = "Obim kvadrata je " .. tostring(circ) .. " cm. Kolika je njegova stranica?"
else
    circ = side * (factor + 1) * 2
    answ = "Obim pravougaonika je " .. tostring(circ) .. " cm. Jedna njegova stranica je " .. tostring(factor) .. " puta kraća od druge. Kolika je kraća stranica tog pravougaonika?"
end            
                  	
    


     
               

