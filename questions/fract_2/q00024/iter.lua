
answ = {"=", "<", ">"}

broj = math.random(10);
imen1 = broj + math.random(20);
imen2 = imen1 + math.random(10); 

ind = math.random(2)

if (ind == 1) then
    imen_left = imen1
    imen_right = imen2
	sign = ">"
else
    imen_left = imen2
	imen_right = imen1
	sign = "<"	
end        
  
