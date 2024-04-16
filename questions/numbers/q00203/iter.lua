
measure = {}

measure[1] = {"km", "m", "dm", "cm", "mm"}
measure[2] = {"t", "kg", "g"}
measure[3] = {"hl", "l", "dl", "cl", "ml"}

dim = {5, 3, 5}

index = ITEM % 3 

if (index == 0) then
    index = 3
end	

indl = math.random(dim[index]-1)
indr = indl + math.random(dim[index]-indl)

unitl = measure[index][indl]
unitr = measure[index][indr]

if (index == 1) then
    if (indl == 1) then
	    factor = 100 * 10^(indr-indl)
	else
        factor = 10^(indr-indl)	
	end	
end	

if (index == 2) then
	    factor = 1000^(indr-indl)
end	

if (index == 3) then
    if (indl == 1) then
	    factor = 10 * 10^(indr-indl)
	else
        factor = 10^(indr-indl)	
	end	
end	

numleft = 1
numright = numleft * factor	 

            