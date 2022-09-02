
quant = math.random(8) + 2;
numb = math.random(quant - 2) + 1;
            
whole = math.floor(quant / numb)	
rest = quant - whole * numb		

if (rest == 0) then
    rest = 1
    quant = quant + 1
end	
            