
measure = {"m", "dm", "cm","mm"}
measure2 = {"m\(^2\)", "dm\(^2\)", "cm\(^2\)","mm\(^2\)"}

change = {"uvećala", "umanjila"}  

ind = math.random(2)

min = 5;
max = 20;

edge = min + math.random(max - min);
dif = math.random(min-1)
surface = 6 * edge * edge 
	
quest = tostring(ITEM) .. ") ivica dužine " .. tostring(edge) .. measure[ind] .. " " .. change[ind] .. " za " .. tostring(dif) .. measure[ind] .. "?"

if (ind == 1) then
    surface_new = 6 * (edge + dif)^2 
	result = surface_new - surface	
else
    surface_new = 6 * (edge - dif)^2 
	result = surface - surface_new
end    
       
answ = "Površina kocke bi se " .. change[ind] .. " za " .. lib.check_number(result,30) .. measure2[ind] .. "."	             	
       


     
               

