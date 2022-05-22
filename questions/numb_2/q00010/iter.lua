
prime = {11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97} 

out = {}
sg = ""
space = "\( \ \ \) "
reply = {""}
stampa = 6

number1 = 11 + math.random(48)
number2 = number1 + 5 + math.random(93 - number1)

for  i = 1,21 do
     if (number1 == prime[i]) then 
         number1 = number1 + 1
     end
     if (number2 == prime[i]) then 
         number2 = number2 + 1
     end
end	 

max = math.floor(number1/2)

nr = 0
for i = 2,max do  
    j = max + 2 - i  
    factor = math.floor(number1/j) 
	rest1 = number1 - factor*j
	if (rest1 == 0) then
        rest2 = number2 - math.floor(number2/factor) * factor
        if (rest2 == 0) then
	        nr = nr + 1
		    out[nr] = factor		
		end	
	end		   
end

if (number2 >= number1) then
    rest1 = number2 - number1 * math.floor(number2/number1)
	if (rest1 == 0) then
	    nr = nr + 1
        out[nr] = number1
	end
end	
 
if (nr == 0) then
    sg = "p" 
end	

answ = lib.check_string(sg,10) .. space .. number1 .. space .. number2 .. space .. lib.check_number(1,20)

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
  