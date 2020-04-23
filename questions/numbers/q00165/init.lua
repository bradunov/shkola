
fct2 = math.random(6) + 2;
tp = math.floor(100/fct2)
fct1 = math.random(tp - 11) + 11;

val = math.floor(fct1/10)
ost = fct1 - val * 10

if (ost == 0) then
    fct1 = fct1 - 1
    val = math.floor(fct1/10)
    ost = fct1 - val * 10
end

tm1 = val * 10
tm2 = tm1 * fct2
tm3 = ost * fct2

res = fct1 * fct2                                   
                                 



