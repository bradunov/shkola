
reply = ""

ind = math.random(2)

min = 1;
max = 10;
bound = min + math.random(max - min);
if (ITEM == 1) then
    dist = 2 * bound
    sign = ">"
    reply =  "d " .. lib.check_one_option_dropdown(answ, sign) .. lib.check_number(bound,20) .. measure[ind] 
else
    dist = bound
    bound2 = 2 * bound
    sign = "<"
    reply =  "d " .. lib.check_one_option_dropdown(answ, sign) .. lib.check_number(bound2,20) .. measure[ind] 
end         	
      	
    
   	
    


     
               

