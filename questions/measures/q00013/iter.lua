
include("terms")

measure = {"m", "dm", "cm"}
measure2 = {"m²", "dm²", "cm²"}

ind = math.random(3)
number = 4 + math.random(8)

min = 7;
max = 20;

edge = min + math.random(max - min);

number = 4 + math.random(6);

base = edge ^ 2

surface = 4 * number * base + 2 * base

if (ITEM == 1) then
    answ = msg_1 .. tostring(number) .. msg_2
else
    answ = msg_3 .. tostring(number) ..  msg_4 
end                