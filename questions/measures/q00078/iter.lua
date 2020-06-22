
measure = {"m", "dm", "cm","mm"}
measure2 = {"m\(^3\)", "dm\(^3\)", "cm\(^3\)","mm\(^3\)"}

ind = math.random(4)

min = 2;
max = 20;

edge = min + math.random(max - min);
volume = edge * edge * edge


	
if (ITEM == 1) then
    circ = edge * 4
    quest = tostring(ITEM) .. ") obim jedne strane kocke jednak " .. tostring(math.floor(circ)) .. measure[ind] .. "."
    answ = "Zapremina kocke je " .. lib.check_number(volume,30) .. measure2[ind] .. "." 
end

if (ITEM == 2) then
    circ = edge * 12
    quest = tostring(ITEM) .. ") zbir dužina ivica kocke jednak " .. tostring(math.floor(circ)) .. measure[ind] .. "."
    answ = "Zapremina kocke je " .. lib.check_number(volume,30) .. measure2[ind] .. "." 
end    
       
 if (ITEM == 3) then
    factor = 1 + math.random(4)
	temp = factor^3
    quest = tostring(ITEM) .. ") dužina ivice kocke povećana " .. tostring(factor) .. " puta."
    answ = "Zapremina kocke je povećana " .. lib.check_number(temp,30) .. " puta." 	
end             	
    



     
               

