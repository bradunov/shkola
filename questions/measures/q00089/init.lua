
include("trans")

min_str = "min"
answ = {"", ""}

start_h = 12 + math.random(6);
start_m = 15 * (math.random(4) - 1)
last_h = math.random(2);
last_m = 5 * math.random(11);

if (last_h == 1) then
    term = hour_str[1]
else
    term = hour_str[2]
end	

finish_h = start_h + last_h
finish_m = start_m + last_m


if( finish_m >= 60) then
   temp = math.floor(finish_m/60)
   finish_m = finish_m - 60 * temp
   finish_h = finish_h + temp
end   

if (finish_m ~= 0) then
   answ[2] = tostring(finish_m) .. min_str  
end 

if (start_m ~= 0) then
   answ[1] = lib.check_number(start_m,20) .. min_str  
end 
     