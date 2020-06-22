
measure = {"m", "dm", "cm"}
measure2 = {"m\(^2\)", "dm\(^2\)", "cm\(^2\)"}

ind = math.random(3)
number = 4 + math.random(8)

min = 7;
max = 20;

edge = min + math.random(max - min);

number = 4 + math.random(6);

base = edge ^ 2

surface = 4 * number * base + 2 * base

if (ITEM == 1) then
    answ = "Kvadar se sastoji od " .. tostring(number) .. " takvih kocki nanizanih jedna na drugu."
else
    answ = "Kvadar ima istu dužinu i širinu kao i kocka, a visina mu je " .. tostring(number) ..  " puta duža od ivice kocke." 
end                