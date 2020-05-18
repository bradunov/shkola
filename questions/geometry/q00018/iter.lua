
min = 2;
max = 20;

side = min + math.random(max - min);
factor = min + math.random(5);


if (ITEM == 1) then
    circ = side * 4
    answ = msg1 .. tostring(math.floor(circ)) .. msg2
else
    circ = side * (factor + 1) * 2
    answ = msg3 .. tostring(math.floor(circ)) .. msg4 .. tostring(math.floor(factor)) .. msg5
end            
                  	
    


     
               

