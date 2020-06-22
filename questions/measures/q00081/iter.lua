
measure = {"m", "dm", "cm"}
measure2 = {"m\(^3\)", "dm\(^3\)", "cm\(^3\)"}

ind = math.random(3)
number = 4 + math.random(8)

min = 7;
max = 20;

edge = min + math.random(max - min);

number = 4 + math.random(6);

cube = edge ^ 3

volume = number * cube 

if (ITEM == 1) then
    answ = "Kvadar se sastoji od " .. tostring(number) .. " takvih kocki."
else
    answ = "Kvadar ima istu dužinu i širinu kao i kocka, a visina mu je " .. tostring(number) ..  " puta duža od ivice kocke." 
end      
        