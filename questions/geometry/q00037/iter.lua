measure = {"m", "dm", "cm","mm"}
measure2 = {"\( m^2\)", "\( dm^2\)", "\( cm^2\)","\( mm^2\)"}

ind = math.random(4)

min = 2;
max = 15;

side = min + math.random(max - min);
factor = min + math.random(5);


if (ITEM == 1) then
    circ = side * 4
	surface = side * side
    answ = "Površina kvadrata je " .. tostring(surface) .. measure2[ind] ..". Koliki je njegov obim?"
else
    circ = side * (factor + 1) * 2
	surface = side * side* factor
    answ = "Površina pravougaonika je " .. tostring(surface) .. measure2[ind] ..". Jedna njegova stranica je " .. tostring(factor) .. " puta kraća od druge. Koliki je obim  pravougaonika?"
end            
  
     
                  
             	
    


     
               

