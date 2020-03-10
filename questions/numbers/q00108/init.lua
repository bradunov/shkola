include("names")

dimnames = 6
index = {}
for i=1,dimnames do
    index[i] = i
end
	
r = lib.math.random_shuffle(index)

ime1 = musko_ime_nom[r[1]]
ime2 = musko_ime_nom[r[2]] 

min = 101
max = 399
first = min + math.random(max - min)
second = min + math.random(max - min) 

length = first + second
result = 11 + math.random(989 - length)
length = length + result

if (first > second) then
   differ = "manje"
   part = first - second
else   
   differ = "više"
   part = second - first  
end   
   