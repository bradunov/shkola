
side ={}
out = {}

min = 5
max = 30

result = 2*min + math.random(max - min)

circ = 3 * result

side[1] = result + math.random(min)
temp = math.floor((circ - side[1])/2)
side[2]= temp + math.random(min)
side[3] = circ - side[1] - side[2]
 
out = lib.math.argsort(side)

temp = out[3] -(out[1] + out[2])
if(temp >= 0) then
   out[1] = out[1] + 3 * temp
   circ = circ + 3 * temp
   result = result + temp
end   