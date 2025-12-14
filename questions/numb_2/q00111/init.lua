
fct1 = {3, 4, 5}
fct2 = {7, 11, 13}
numb = 250 + 50 * math.random(7)
ch1 = math.random(3)
ch2 = math.random(3)

val1 = math.floor(numb/fct1[ch1])
val2 = math.floor(numb/fct2[ch2])
val3 = math.floor(numb/(fct1[ch1]*fct2[ch2]))

result = val1 + val2 - val3 
            
    