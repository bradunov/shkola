index = {1,2,3,4}

ind = lib.math.random_shuffle(index)

if(ind[1] < ind[2]) then
   inddif = ind[2] - ind[1]
else
   inddif = ind[1] - ind[2]
end

temp = 100^inddif

number = 7 + math.random(43)

if (ind[1] > ind[2]) then 
    valueleft = number
    valueright = number * temp
else
    valueleft = number * temp
    valueright = number
end		          
                  
                    
 

       
 