
cifra1 = math.random(9)
cifra2 = math.random(10) - 1
cifra3 = math.random(9)

number = cifra1 * 100 + cifra2 * 10 + cifra3

decmin = cifra1 * 100 + cifra2 * 10
if (cifra2 + 1 ~= 10) then
    decmax = cifra1 * 100 + (cifra2 + 1) * 10   
else
    decmax = (cifra1 + 1)* 100 
end
                  
hundmin = cifra1 * 100
hundmax = (cifra1 + 1) * 100
                  