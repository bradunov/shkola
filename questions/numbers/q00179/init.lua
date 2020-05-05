
fct2 = math.random(6) + 2;
tp = math.floor(1000/fct2)
res = math.random(tp - 110) + 110;

fct1 = res * fct2

val1 = math.floor(fct1/(fct2*100))
ost1 = fct1 - val1 * 100 *fct2
val2 = math.floor(ost1/(fct2*10))
ost2 = ost1 - val2 * 10 * fct2

if (ost2 == 0) then
    res = res - 1
    fct1 = res * fct2
    val1 = math.floor(fct1/(fct2*100))
    ost1 = fct1 - val1 * 100 * fct2
	val2 = math.floor(ost1/(fct2*10))
    ost2 = ost1 - val2 * 10 * fct2
end	

                                  
tm1 = val1 * 100 * fct2
tm2 = val2 * 10 * fct2
tm3 = ost2

out1 = val1 * 100 
out2 = val2 * 10
out3 = res - out1 - out2
          

