array_decname = {"druge", "treće", "četvrte", "pete", "šeste", "sedme", "osme", "devete", "desete"}
array_izbor = {"paran", "neparan"}


factor = math.random(9);
name = array_decname[factor]

index = math.random(2);
choice = array_izbor[index];

fact = factor * 100;
if (index == 1) then
    min = fact + 2;
    max = fact + 100;  
else
    min = fact + 1;
    max = fact + 99; 	 	
end
                      
          