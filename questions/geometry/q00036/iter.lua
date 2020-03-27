measure = {"m", "dm", "cm","mm"}
measure2 = {"\( m^2\)", "\( dm^2\)", "\( cm^2\)","\( mm^2\)"}

ind = math.random(4)

min = 2;
max = 20;

side = min + math.random(max - min);
factor = min + math.random(5);


if (ITEM == 1) then
    circ = side * 4
	surface = side * side
    answ = "Obim kvadrata je " .. tostring(circ) .. measure[ind] ..". Kolika je njegova površina?"
else
    circ = side * (factor + 1) * 2
	surface = side^2 * factor
    answ = "Obim pravougaonika je " .. tostring(circ) .. measure[ind] ..". Jedna njegova stranica je " .. tostring(factor) .. " puta kraća od druge. Kolika je površina pravougaonika?"
end            
     
             	
    


     
               

