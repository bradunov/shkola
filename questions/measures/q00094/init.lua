
include("terms")
include("names")

nmb_month = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

rm = math.random(#musko_ime_nom); 
ime = musko_ime_nom[rm];

ind_m = math.random(12)
start_m = month2[ind_m]
start_d = math.random(nmb_month[ind_m])

max = 8
last_w = math.random(max)
last_d = math.random(7) - 1
last = last_w * 7 + last_d

temp = math.floor(last/10)
rest = last - temp * 10

if (rest == 1 and temp ~=1) then
    week = day_str[1]
else    	
    week = day_str[2]
end	
	
stampa = math.ceil(max/4) + 1
temp = start_d + last
q = ind_m
index = 0
for i = 1, stampa  do
    if (temp <= nmb_month[q]) then
        finish_d = temp
		finish_m = month2[q]
    else 
        temp = temp - nmb_month[q]
	    q = q + 1
		if (q > 12) then
		    q = 1
		end	
    end
end	
   
remark = ""
if (ind_m <= 2 and q > 2) then
    remark = remark_str
end        
   