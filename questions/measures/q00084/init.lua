
include("names")

rz = math.random(#zensko_ime_nom); 
ime = zensko_ime_nom[rz];

brasno = math.random(35) + 35;
secer = math.random(brasno - 35) + 30;
puter = 5 * (math.random(40) + 35)

brasno = 10 * brasno
secer = 10 * secer

total = brasno + secer + puter

mes1 = math.floor(total/1000)
mes2 = total - mes1 * 1000

reply = ""

if (mes1 == 0) then
    reply = reply .. lib.check_number(mes2,30) .. "g"   
else
    reply = reply .. lib.check_number(mes1,15) .. "kg " 	
	if (mes2 ~= 0) then 
        reply = reply .. lib.check_number(mes2,30) .. "g"   
	end
end	
         