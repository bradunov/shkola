

posit = {"I", "II", "III", "IV"}

dim = 7
dim2 = 2 * dim

xa = dim - math.random(dim2-1)
ya = dim - math.random(dim2-1)

if (xa * ya == 0) then 
    if (xa == 0) then
	    xa = xa - 1
	end
    if (ya == 0) then
	    ya = ya + 1
	end	
end	

if (xa * ya > 0) then 
    if (xa > 0 and ya > 0) then
	    ind = 1
	else
        ind = 3
	end	
else
   if (xa > 0 and ya < 0) then
	    ind = 4
	else
        ind = 2
	end		
end	

xm = xa
ym = -ya
xn = -xa
yn = ya   


