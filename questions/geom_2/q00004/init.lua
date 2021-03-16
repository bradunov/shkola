
include("terms")

index = {}
out = {}
numb = {}
result = {}
reply = {}

index = {1,2,3,4,5,6,7,8,9,10}
out = lib.math.random_shuffle(index)

numb[1] = 2
result[1] = 1
reply[1] = msg[1]

numb[2] = 3
result[2] = 3
reply[2] = msg[2]

numb[3] = 2
result[3] = 1
reply[3] = msg[3]
 
numb[4] = 1 + math.random(3)
result[4] = 2 * numb[4] 
if (numb[4] > 2) then
    reply[4] = msg[7]
else
    reply[4] = msg[4]	
end	
  
numb[5] = 1 + math.random(3)
result[5] = math.floor(numb[5] * (numb[5] - 1)/2)
if (numb[5] > 2) then
    reply[5] = msg[5]
else
    reply[5] = msg[8]	
end	

numb[6] = 4 + math.random(3)
result[6] = math.floor(numb[6] * (numb[6] - 1)/2)
reply[6] = msg[9]
	
   
numb[7] = 1 + math.random(3)
result[7] = numb[7] + 1
reply[7] = msg[6]
 
numb[8] = 1 + math.random(3)
result[8] = 2 *(numb[8] + 1)
reply[8] = msg[6]

numb[9] = 2
result[9] = 9 
reply[9] = msg[6]

numb[10] = 3
result[10] = 7
reply[10] = msg[6]

           