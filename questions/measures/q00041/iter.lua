
ind = {}

ind[1] = math.random(3)
if (ind[1] == 1 or ind[1] == 3) then
    ind[2] = 2
else
    sign = math.random(2)
    if (sign == 1) then
       ind[2] = 1
    else
       ind[2] = 3
    end
end  

if(ind[1] < ind[2]) then
   inddif = ind[2] - ind[1]
else
   inddif = ind[1] - ind[2]
end

temp = 10^inddif

number = math.random(10)

if (ind[1] > ind[2]) then 
    if( number == 1 and ind[1] == 3) then
	    temp = 100
		ind[2] = 1
    end		
    valueleft = number
    valueright = number * temp
else
    if( number == 1 and ind[2] == 3) then
	    temp = 100
		ind[1] = 1
    end	
    valueleft = number * temp
    valueright = number
end		          
                      
                    
 

       
 