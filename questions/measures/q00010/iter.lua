
measure = {"m", "dm", "cm", "mm"}
measure2 = {"m\(^2\)", "dm\(^2\)", "cm\(^2\)","mm\(^2\)"}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                

ind = math.random(4)

min_range = 5
max_range = 20

edge1 = min_range + 1 + math.random(max_range - min_range)
edge2 = min_range + math.random(edge1 - min_range)
edge3 = min_range -1 + math.random(edge2 - min_range)
  
summ = 4 * (edge1 + edge2 + edge3)

surface = (edge1 * edge2 + edge1 * edge3 + edge2 * edge3) * 2 
	
if (ITEM == 1) then
    quest = "Ako je zbir svih ivica kvadra " .. tostring(summ) .. measure[ind] .. ", kolika je njegova površina?" 
    answ = "Površina kvadra je " .. lib.check_number(surface) .. measure2[ind] .. "."	
else
    quest = "Ako je površina kvadra " .. tostring(surface) .. measure2[ind] .. ", kolika je njegova visina?"
    answ = "Visina kvadra je " .. lib.check_number(edge3,20) .. measure[ind] .. "."
end          
           
              
       
             	
    


     
               

