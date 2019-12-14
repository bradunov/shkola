array_decname = {"prve", "druge", "treće", "četvrte", "pete", "šeste", "sedme", "osme", "devete", "desete"}
array_izbor = {"najmanji paran", "najveći paran", "najmanji neparan", "najveći neparan"}


factor = math.random(10);
name = array_decname[factor]

index = math.random(4)
izbor = array_izbor[index]

if (index == 1) then
    value = (factor-1) * 10
end	
if (index == 2) then   
	value = (factor-1) * 10 + 8 
end
if (index == 3) then
	value = (factor-1) * 10 + 1
end
if (index == 4) then
    value = (factor-1) * 10 + 9 	 	
end
                  
          