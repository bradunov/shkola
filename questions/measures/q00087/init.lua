
answ = {"", ""}

start_h = 12 + math.random(7);
start_m = 15 * (math.random(3) - 1)
last_h = 1 + math.random(3);
last_m = 5 * math.random(11);
late = 5 * math.random(20)

finish = (start_h + last_h)* 60 + start_m + last_m + late

finish_h = math.floor(finish/60)
finish_m = finish - 60 * finish_h
  
if (start_m ~= 0) then
   answ[1] = lib.check_number(start_m,20) .. "min"  
end   

if (finish_m ~= 0) then
   answ[2] =  tostring(finish_m) .. "min"  
end 
  