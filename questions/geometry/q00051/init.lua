include("names")

rz = math.random(#zensko_ime_nom);
imez = zensko_ime_nom[rz];

lesson = (2 + math.random(6)) * 5;

number = 2;
pause = 20

if(lesson > 20 and lesson < 35) then  
   number = 3
   pause = 5
end

 if( lesson < 25) then  
   number = 4
   pause = 5
end

total = number * lesson + (number - 1) * pause

hour = math.floor(total/60)
minute = total - hour * 60

answ = tostring(lib.check_number(total,30)) .. " minuta"
if (hour == 1) then
    answ = answ .. " = " .. tostring(lib.check_number(hour,20)) .. " sat " .. tostring(lib.check_number(minute,30)) .. " minuta."
else	
    answ = answ .. " = " .. tostring(lib.check_number(hour,20)) .. " sata " .. tostring(lib.check_number(minute,30)) .. " minuta."
end	
	