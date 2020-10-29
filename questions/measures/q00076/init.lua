include("terms")

result = {}

start_h = 8 + math.random(4)
start_m = 10 * math.random(5)

hour = 2 + math.random(2);
minute = 1 + math.random(58);
second = 11 * math.random(5) + 4;


result[1] = start_h + hour

result[2] = start_m + minute
if (result[2] > 59) then
    result[2] = result[2] - 60
	result[1] = result[1] + 1
end

result[3] = second

answ = lib.check_number(result[1],30) .. msg_hour
if (result[2] == 0) then
    answ = answ .. " " .. lib.check_number(result[3],30) .. msg_sec
else
    if (result[2] == 1) then 	
        answ = answ .. "  " .. lib.check_number(result[2],30) .. msg_min[1] .. lib.check_number(result[3],30) .. msg_sec	
	else
        answ = answ .. "  " .. lib.check_number(result[2],30) .. msg_min[2] .. lib.check_number(result[3],30) .. msg_sec
    end	 	
end	
	