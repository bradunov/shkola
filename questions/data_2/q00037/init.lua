
include("terms")

ans = {""}
out = {}
test = {}
reply = {}

proc = "%"

numb_a = math.random(50);
numb_b = math.random(50);

area = numb_a - numb_b - numb_a*numb_b/100
    
if (area > 0) then
    ind = 1
else
    if (area == 0) then
        ind = 3
	else
        ind = 2	
	end	
end	

ans[1] = msg1[1]
ans[2] = msg1[2]
ans[3] = msg1[3] 

test = {1, 2, 3}
out = lib.math.random_shuffle(test)
for i = 1,3 do
    reply[i] = ans[out[i]]
    if (out[i] == ind) then
	    index = i - 1
	end
end	

if (area == 0) then
    result = ""
else
    temp = lib.math.round_dec(math.abs(area), 1)
	result = msg2 .. lib.check_number(temp,30) .. proc .. "."
end	

           