
include("terms")

nmb_month = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

answ = {""}
day = {}
datum = {}
month = {""}
hour = {}
dif = {}

ind_d = math.random(7)
day_q = daydat[ind_d]
ind_m = math.random(12)
month_q = monthdat[ind_m]
datum_q = math.random(nmb_month[ind_m])
hour_q = math.random(24) - 1

pad_q = padez[3]
tmp = hour_q - 20
if (hour_q == 1 or tmp == 1) then
	pad_q = padez[1]
end	
if (hour_q > 1 and hour_q < 5 or tmp > 1 and tmp < 5) then
	pad_q = padez[2]
end	

dif[1] = 7
dif[2] = -6                
for i = 1,2 do
	day[i] = day_q
	datum[i] = datum_q
	month[i] = month_q
    hour[i] = hour_q + dif[i]		
	if (hour[i] > 23) then
		hour[i] = hour[i] - 24
        if (ind_d == 7) then
			day[i] = daydat[1]
		else
			day[i] = daydat[ind_d+1]	
		end
        datum[i] = datum[i]+1
		if (datum[i] > nmb_month[ind_m]) then
		    datum[i] = 1
			if (ind_m == 12) then
	            month[i] = monthdat[1]
			else
	            month[i] = monthdat[ind_m + 1]	
            end	
		end
    end	
	if (hour[i] < 0) then
		hour[i] = hour[i] + 24  
        if (ind_d == 1) then
			day[i] = daydat[7]
		else
			day[i] = daydat[ind_d-1]	
		end
        datum[i] = datum[i]-1
		if (datum[i] < 1) then
			if (ind_m == 1) then
	            month[i] = monthdat[12]
		        datum[i] = nmb_month[12]				
			else
	            month[i] = monthdat[ind_m - 1]	
				datum[i] = nmb_month[ind_m-1]	
            end	
		end
    end	
	pad = padez[3]
	tmp = hour[i] - 20
	if (hour[i] == 1 or tmp == 1) then
		pad = padez[1]
	end	
	if (hour[i] > 1 and hour[i] < 5 or tmp > 1 and tmp < 5) then
		pad = padez[2]
	end		
    answ[i] = lib.check_string(day[i],70).. ", \( \ \) " .. lib.check_number(datum[i],15) .. lib.check_string(month[i],80) .. ",  \( \  \) " .. lib.check_number(hour[i],20) ..  pad
end

remark = ""
if (ind_m == 2 ) then
    remark = "(Napomena: godina nije prestupna.)"
end        
            