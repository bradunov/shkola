
min_str = "min"

answ = {"", ""}

start_h = 12 + math.random(6);
start_m = 15 * (math.random(4) - 1)
last_h = 1 + math.random(2);
last_m = 5 * math.random(11);

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
   answ[1] = tostring(start_m) .. min_str  
end 
          
         