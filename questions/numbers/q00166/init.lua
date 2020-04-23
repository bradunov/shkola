
fct2 = math.random(6) + 2;
tp = math.floor(100/fct2)
res = math.random(tp - 11) + 11;

fct1 = res * fct2

val = math.floor(fct1/(fct2*10))
ost = fct1 - val * 10 *fct2

if (ost == 0) then
    res = res - 1
    fct1 = res * fct2
    val = math.floor(fct1/(fct2*10))
    ost = fct1 - val * 10 * fct2
end	

tm1 = val * 10 * fct2

tm2 = val * 10
tm3 = res - val * 10    
                                  
  
