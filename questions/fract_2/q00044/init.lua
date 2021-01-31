
include("names")

r = math.random(#zensko_ime_nom);
name = zensko_ime_nom[r];
padez = zensko_ime_dativ[r]

enum = {}
number = {}

denom = 300 + math.random(140)
min = math.floor(denom/4)
max = math.floor(denom/3)
temp = min+max
enum[1] = min - 10 + math.random(max-min)
enum[3] = min + math.random(max-min)       
enum[2] = denom - enum[1] - enum[3]

total = denom/100    
for i = 1,3 do
    number[i] = enum[i]/100
end
       
    
             