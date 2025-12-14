
include("names")

index_ime = math.random(#musko_ime_nom);    
name = musko_ime_nom[index_ime];                  

aver = {}

numb = 4 + math.random(4)
aver[1] = 13 + math.random(8)
aver[2] = aver[1] + math.random(3)

res = aver[2] * (numb + 1) - aver[1] * numb
             
 