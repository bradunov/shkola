
measure1 = {"m", "kg" , "t", "km", "l"}
measure2 = {"cm", "g", "kg", "m", "cl"}

rel = {100, 1000, 1000, 1000, 100}

brojilac = 51 + math.random(849)

if (ITEM > 1 and ITEM < 5) then 
    brojilac = brojilac * 10
end	

temp = brojilac % rel[ITEM]
if (temp == 0) then
    brojilac = brojilac + math.random(9)
end

res_dec = brojilac / rel[ITEM]	
result = brojilac
                  
stampa = math.random(2)

if (stampa == 1) then
    numleft = result 
	measleft = measure2[ITEM]
    numright = res_dec
	measright = measure1[ITEM]  
else
    numleft = lib.dec_to_str(res_dec) 
	measleft = measure1[ITEM]
    numright = result 
	measright = measure2[ITEM] 	
end	      
   