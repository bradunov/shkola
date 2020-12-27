
if (ITEM == 1) then
    quest[ITEM] = msg_1
    if (index == 1) then
        quest[ITEM] = quest[ITEM] .. msg_2 .. tostring(dif) .. measure[ind].. "?"
        surface1[ITEM] = 2 * ((edge1+dif) * (edge2+dif) + (edge1+dif) * (edge3+dif) + (edge2+dif) * (edge3+dif))
	    result = surface1[ITEM] - surface
		answ[ITEM] = msg_3 .. lib.check_number(result,30) .. measure2[ind] .. "."
	else
	    quest[ITEM] = quest[ITEM] .. msg_4 .. tostring(dif) .. measure[ind] .. "?"
        surface1[ITEM] = 2 * ((edge1-dif) * (edge2-dif) + (edge1-dif) * (edge3-dif) + (edge2-dif) * (edge3-dif))	
	 	result = surface - surface1[ITEM]
	    answ[ITEM] = msg_5 .. lib.check_number(result,30) .. measure2[ind] .. "."
	end	
else	
    quest[ITEM] = msg_6
    dif1 = dif * dif
	if (index == 1) then
        quest[ITEM] = quest[ITEM] .. msg_7 .. tostring(dif) .. msg_8
        surface1[ITEM] = surface * dif1
		answ[ITEM] = msg_9 ..lib.check_number(dif1,15) .. msg_10
	else
	    quest[ITEM] = quest[ITEM] .. msg_11 .. tostring(dif) .. msg_8
        surface1[ITEM] = 2 * (edge1_b * edge2_b + edge1_b * edge3_b + edge2_b * edge3_b)	
		answ[ITEM] = msg_12 ..lib.check_number(dif1,15) .. msg_10
    end	
end                              
       	
       


     
               

