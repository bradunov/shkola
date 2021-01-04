
numb_r = 2 + math.random(997) 

sign =  math.random(2)
diff = 2 + math.random(7)
if (sign == 1 ) then 
   znak = "<"
   numb_l = numb_r - diff
else
   znak = ">"
   numb_l = numb_r + diff
end                    
      
dec = math.random(3)                         
numb_r = numb_r / 10^dec
numb_l = numb_l / 10^dec
           