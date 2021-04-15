
answ = {"<", ">"}

numb_r = 2 + math.random(997) 

znak =  math.random(2)
diff = 2 + math.random(7)
if (znak == 1 ) then 
   sign = "<"
   numb_l = numb_r - diff
else
   sign = ">"
   numb_l = numb_r + diff
end                    
      
dec = math.random(3)                         
numb_r = numb_r / 10^dec
numb_l = numb_l / 10^dec        
            
           