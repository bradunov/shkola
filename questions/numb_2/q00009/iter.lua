
out = {}
sg = ""
space = "\( \ \ \ \) "
reply = {""}
stampa = 6

number = 21 + math.random(78)

max = math.floor(number/2)

nr = 0
for i = 2,max do  
    j = max + 2 - i  
    factor = math.floor(number/j) 
	rest = number - factor*j
	if (rest == 0) then
	    nr = nr + 1
		out[nr] = factor
	end		   
end

if (nr == 0) then
    sg = "p" 
end	

nr = nr + 1
out[nr] = number

answ = lib.check_string(sg,10) .. space .. number .. space .. "1"
if (nr > stampa) then
    stampa = nr
end	 
for i = 1,stampa do
    if (i <= nr) then
        reply[i] = tostring(out[i])
	else
        reply[i] = ""  	   
    end	
    answ = answ .. " " .. lib.check_string(reply[i],15)       
end   
            
     
         