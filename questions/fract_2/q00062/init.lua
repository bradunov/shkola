
include("terms")
                                                                                                              
enum = {}
denom = {}
numb = {}
ind = {}
out = {}
qq = {}
quest = {}
reply = {}

answ = {"\(\small \leq\)",  "\(\small \geq\)"}

min = 3
max = 6

for i=1,6 do
    ind[i] = math.random(3)
    if (ind[i] < 3) then
       fact = 10^ind[i]
       min_range = min*fact
       max_range = max*fact
       numb[i] = (min_range - math.random(max_range))/fact
       if (numb[i] == 0) then
	       numb[i] = min - max
       end		
	   quest[i] = lib.dec_to_str(numb[i])
	   reply[i] = lib.check_number(numb[i],30)
    else
       denom[i] = min + math.random(max)
       enum[i] = min - math.random(max)
       if (enum[i] == 0) then
	       enum[i] = min - max
       end		
       numb[i] = enum[i]/denom[i]
	   if (enum[i] < 0) then
	       tmp = math.abs(enum[i])
	       quest[i] = "- " .. "\(\frac{" .. tmp .. "}{" .. denom[i] .. "}\)"	            		   
       else	
           quest[i] = "\(\frac{" .. enum[i] .. "}{" .. denom[i] .. "}\)"	
	   end
	   reply[i] = lib.check_fraction_simple(enum[i], denom[i])	
	end
end	

qq = lib.math.argsort(numb);

sign = math.random(2)
relat = msg[sign]

   for i = 1,6 do
if (sign == 1) then
        out[i] = qq[i]
	else
        out[i] = qq[7-i]
    end
end	                       
            
	            
	 


	 
