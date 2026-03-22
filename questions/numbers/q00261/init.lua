
include("names")
include ("terms")

r = math.random(#zensko_ime_nom)
ime = zensko_ime_nom[r] 

numb = {}
rest = {}
result = {}
note = {}
x = {}
y = {}

numb[1] = 4 + math.random(4)
numb[2] = numb[1] + 1
rest[1] = 1 + math.random(numb[1]-2)
rest[2] = 2 + math.random(numb[2]-3)
 
bound = 0
for k = 1, 3 do
	y[k] = (k + bound) * numb[1] + rest[1] - rest[2]
	result[k] = y[k] * numb[2] + rest[2]
	x[k] = math.floor((result[k] -  rest[1]) / numb[1])
end
lft = 10 * math.ceil((result[1] + 4 + math.random(3))/10)
rght =  10 * math.floor((result[3] - 4 - math.random(3))/10)  
total =  result[2]  

for i = 1,2 do
	if (rest[i] < 5) then
		if (rest[i] == 2) then
			note[i] = msg[1]
			note[i+2] = msg[4]	
		else
			note[i] = msg[2]
			note[i+2] = msg[5]			
		end
	else
		note[i] = msg[3]
		note[i+2] = msg[6]
	end	
end	        