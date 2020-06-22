
if (ITEM == 1) then
    quest[ITEM] = tostring(ITEM) .. ") Za koliko bi se promenila površina kutije ako bi se sve dimenzije kutije"
    if (index == 1) then
        quest[ITEM] = quest[ITEM] .. " uvećale za " .. tostring(dif) .. measure[ind].. "?"
        surface1[ITEM] = 2 * ((edge1+dif) * (edge2+dif) + (edge1+dif) * (edge3+dif) + (edge2+dif) * (edge3+dif))
	    result = surface1[ITEM] - surface
		answ[ITEM] = " Površina bi se uvećala za " .. lib.check_number(result,30) .. measure2[ind] .. "."
	else
	    quest[ITEM] = quest[ITEM] .. " umanjile za " .. tostring(dif) .. measure[ind] .. "?"
        surface1[ITEM] = 2 * ((edge1-dif) * (edge2-dif) + (edge1-dif) * (edge3-dif) + (edge2-dif) * (edge3-dif))	
	 	result = surface - surface1[ITEM]
	    answ[ITEM] = " Površina bi se umanjila za " .. lib.check_number(result,30) .. measure2[ind] .. "."
	end	
else	
    quest[ITEM] = tostring(ITEM) .. ") Koliko puta bi se promenila površina kutije ako bi se sve dimenzije kutije"
    dif1 = dif * dif
	if (index == 1) then
        quest[ITEM] = quest[ITEM] .. " uvećale " .. tostring(dif) .. "puta?"
        surface1[ITEM] = surface * dif1
		answ[ITEM] = " Površina bi se uvećala " ..lib.check_number(dif1,15) .. "puta."
	else
	    quest[ITEM] = quest[ITEM] .. " umanjile " .. tostring(dif) .. " puta?"
        surface1[ITEM] = 2 * (edge1_b * edge2_b + edge1_b * edge3_b + edge2_b * edge3_b)	
		answ[ITEM] = " Površina bi se umanjila " ..lib.check_number(dif1,15) .. "puta."
    end	
end               
       	
       


     
               

