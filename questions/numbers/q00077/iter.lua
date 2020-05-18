include("terms")

ind1 = math.random(2);

term1 = math.random(750) + 100;
term2 = math.random(900 - term1) + 100;
temp = term1 + term2;
namefirst = array_operfirst[2];
	
if (ind1 == 1 or (temp > 899)) then 
    if (term1 < term2) then
        tt = term1
        term1 = term2
        term2 = tt
    end	
	namefirst = array_operfirst[1]
    temp = term1 - term2;	
end
   
ind2 = math.random(2);

term3 = math.random(900 - temp) + 100;

if (ind2 == 1 or temp < term3 ) then 
    result = temp + term3;
	namesecond = array_opersecond[1];
else   
    result = temp - term3;
    namesecond = array_opersecond[2];	
end          
          
         
                     