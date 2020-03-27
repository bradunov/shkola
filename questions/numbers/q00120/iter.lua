numb = 3 + math.random(15)

choose = lib.math.gcd(ITEM, 2)

if (choose == 1) then
    ind = numb * 2 - 1
    summ = numb * ind   
else   
    ind = numb * 2 
    summ = numb * (ind + 1)          
end
                                    