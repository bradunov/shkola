
if (ch == 1) then
	ind = ITEM
else
	ind = 3 - ITEM
end	

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
 