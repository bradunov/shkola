
day2 = {"ponedeljak", "utorak", "sredu", "četvrtak", "petak", "subotu", "nedelju"}
month1 = {"januar", "februar", "mart", "april", "maj", "juni", "juli", "avgust", "septembar", "oktobar", "novembar", "decembar"}
month2 = {"januara", "februara", "marta", "aprila", "maja", "juna", "jula", "avgusta", "septembra", "oktobra", "novembra", "decembra"}
nmb_month = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

ind_s = math.random(6)
day_s = day2[ind_s]
if (ind_s == 1) then
    index = 7
else
    index = ind_s - 1	
end	
day_f = day2[index]

ind_m = 2
start_m = month2[ind_m]
start_d = 15 + math.random(nmb_month[ind_m] - 16)

max = 3
last = math.random(max)

if (last == 1) then
    week = "nedelju"
else    	
    week = "nedelje"	
end	

stampa = math.ceil(max/4) + 1
temp = start_d + last * 7
q = ind_m

for i = 1, stampa  do
    if (temp <= nmb_month[q]) then
	    if (temp == 1) then
		    finish_d = nmb_month[q-1]
		    finish_m = month2[q-1]
		else
            finish_d = temp - 1
		    finish_m = month2[q]
		end	
     else 
        temp = temp - nmb_month[q]
	    q = q + 1
     end
end	
   
