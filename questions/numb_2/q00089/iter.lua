
ch = math.random(4)
if (ch == 1) then
    cor = 1
    max_range = 8
else
    cor = 0
    max_range = 9
end

value = cor + math.random(max_range)
if (ch > 1) then
    for i = 2,ch do
        numb = math.random(10) - 1  
        value = 10 * value + numb
    end	
end	

dec = ch - 1
base = value * 10^(-dec)
res = lib.math.round_dec(base, dec)
fct = 1 + math.random(5)
value = value * 10^fct
grd = fct + dec                    
                        