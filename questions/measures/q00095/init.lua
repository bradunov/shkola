                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
month2 = {"januara", "februara", "marta", "aprila", "maja", "juna", "jula", "avgusta", "septembra", "oktobra", "novembra", "decembra"}
nmb_month = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}


ind_m = 5 + math.random(7)
start_m = month2[ind_m]
start_d = math.random(nmb_month[ind_m])

ind_f = math.random(ind_m)
finish_d = start_d
finish_m = month2[ind_f]

last = 12 - ind_m + ind_f

if (last == 1) then
    week = "mesec"
else 
    if (last < 1 and last > 4) then   	
        week = "meseca"	
	else
        week = "meseci"	
    end		
end	
	
