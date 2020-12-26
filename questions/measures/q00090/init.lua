include("trans")
answ = {"", ""}

start_h = 20 + math.random(3);
start_m = 15 * (math.random(4) - 1)
last_h = 1 + math.random(3);
last_m = 5 * math.random(11);

finish_h = start_h + last_h
finish_m = start_m + last_m


if( finish_m >= 60) then
   temp = math.floor(finish_m/60)
   finish_m = finish_m - 60 * temp
   finish_h = finish_h + temp
end   

if( finish_h >= 24) then
   temp = math.floor(finish_h/24)
   finish_h = finish_h - temp * 24
end  

if (finish_m ~= 0) then
   answ[2] = and_str .. lib.check_number(finish_m) .. min_str  
end 

if (start_m ~= 0) then
   answ[1] = and_str ..  tostring(start_m,20) .. min_str  
end 
