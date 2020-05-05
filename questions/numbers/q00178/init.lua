
fct2 = math.random(6) + 2;
tp = math.floor(1000/fct2)
fct1 = math.random(tp - 110) + 110;

val1 = math.floor(fct1/100)
ost1 = fct1 - val1 * 100
val2 = math.floor(ost1/10)
ost2 = ost1 - val2 * 10

if (ost == 0) then
    fct1 = fct1 - 1
    val1 = math.floor(fct1/100)
    ost1 = fct1 - val1 * 100
    val2 = math.floor(ost1/10)
    ost2 = ost1 - val2 * 10	
end

tm1 = val1 * 100
tm2 = val2 * 10
tm3 = ost2

out1 = tm1 * fct2
out2 = tm2 * fct2
out3 = tm3 * fct2

res = fct1 * fct2                                   
                             