
include("names")
include("terms")

rz = math.random(#zensko_ime_nom);
imez = zensko_ime_nom[rz];

lesson = (4 + math.random(8)) * 5;

number = 2;
pause = 30

if(lesson > 40 and lesson < 55) then  
   number = 3
   pause = 20
end

if(lesson > 30 and lesson < 45) then  
   number = 4
   pause = 15
end

 if( lesson < 35) then  
   number = 5
   pause = 10
end

total = number * lesson + (number - 1) * pause

hour = math.floor(total/60)
minute = total - hour * 60

if (number < 5) then
    part = padez[1]
else
	part = padez[2]
end	

answ = tostring(lib.check_number(total,30)) .. " minuta"
if (hour == 1) then
    answ = answ .. " = " .. lib.check_number(hour,20) .. msg_hour .. lib.check_number(minute,20) .. msg_min .. "."
else	
    answ = answ .. " = " .. lib.check_number(hour,20) .. msg_hour_dec .. lib.check_number(minute,20) .. msg_min .. "."
end	
	