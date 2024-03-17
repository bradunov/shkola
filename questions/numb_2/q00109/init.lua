
include("names")

r = math.random(#zensko_ime_nom)
ime = zensko_ime_nom[r] 

bag = {}
rest = {}

min_range = 50
max_range = 70
total = min_range + math.random(max_range-min_range-1)
for i = 1,5 do
    bag[i] = 10 - i
    rest[i] = total - bag[i]*math.floor(total/bag[i])
end      
            