include("terms")

measure = {"m", "dm", "cm","mm"}
measure2 = {"m\(^2\)", "dm\(^2\)", "cm\(^2\)","mm\(^2\)"}

ind = math.random(4)

min = 2;
max = 20;

edge = min + math.random(max - min);
surface = edge * edge * 6
	
if (ITEM == 1) then
    circ = edge * 4
    quest = msg_str[1] .. tostring(math.floor(circ)) .. measure[ind] .. "."
else
    circ = edge * 12
    quest = msg_str[2] .. tostring(math.floor(circ)) .. measure[ind] .. "."
end            
             	
    


     
               

