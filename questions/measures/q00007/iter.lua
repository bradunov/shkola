include("terms")

measure = {"m", "dm", "cm","mm"}
measure2 = {"m\(^2\)", "dm\(^2\)", "cm\(^2\)","mm\(^2\)"}

ind = math.random(2)

min = 5;
max = 20;

edge = min + math.random(max - min);
dif = math.random(min-1)
surface = 6 * edge * edge 

if (ind == 1) then
    surface_new = 6 * (edge + dif)^2 
	result = surface_new - surface	
else
    surface_new = 6 * (edge - dif)^2 
	result = surface - surface_new
end    
              


     
               

