include("terms")

ind = math.random(2);

term1 = math.random(750) + 100;
term2 = math.random(900 - term1) + 100;
temp = term1 + term2;
namefirst = array_operfirst[2];

if (temp > 899) then
   ind = 1;
end   
	
if (ind == 1) then 
    if (term1 < term2) then
        tt = term1
        term1 = term2
        term2 = tt
    end	
	namefirst = array_operfirst[1]
    temp = term1 - term2;	
end
   
term3 = math.random(900 - temp) + 100;

if (temp < term3 ) then 
    result =  term3 - temp;
	if (ind == 1) then
	    opersecond = msg_less[1];
    else
        opersecond = msg_less[2];
    end    	
else   
    result = temp - term3;
	if (ind == 1) then
	    opersecond = msg_great[1];
    else
        opersecond = msg_great[2];
    end  
end          
   
         
                     