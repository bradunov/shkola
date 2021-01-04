
broj1 = math.random(20);
broj2 = broj1 + 2 + math.random(20);
imen = 10 + math.random(30); 

if (imen == broj1) then
    imen = imen + 1
end

if (imen == broj2) then
    imen = imen + 1
end	

ind = math.random(2)

if (ind == 1) then
    broj_left = broj1
    broj_right = broj2
	sign = "<"
else
    broj_left = broj2
	broj_right = broj1
	sign = ">"	
end        
