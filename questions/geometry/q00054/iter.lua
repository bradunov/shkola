
measure = {"mm","cm", "dm", "m", "km"}

indl = 1 + math.random(4)

if (indl == 5) then
    indr = 4
	factor = 1000
else	
    indr = math.random(indl-1)
    factor = 10^(indl-indr)
end

numleft = math.random(9)
numright = numleft * factor	 
                               
                  
                             

