
ind = math.random(4)

min = 2;
max = 15;

side = min + math.random(max - min);
factor = min + math.random(5);


if (ITEM == 1) then
    circ = side * 4
	surface = side * side
    answ = msg1 .. tostring(math.floor(surface)) .. measure2[ind] .. msg2
else
    circ = side * (factor + 1) * 2
	surface = side^2 * factor
    answ = msg3 .. tostring(math.floor(surface)) .. measure2[ind] .. msg4 .. tostring(math.floor(factor)) .. msg5
end            
  
     
                  
             	
    


     
               

