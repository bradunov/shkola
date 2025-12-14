
include("names")

index_ime = math.random(#musko_ime_nom);    
name = musko_ime_nom[index_ime];                  

numb = 3000 + 50 * math.random(20)
part = 2 + math.random(3)
period = 1 + math.random(4)
tmp = 1 + 0.01 * part
total = numb
for i = 1,period do
    total = total * tmp
end   
rest = lib.math.round_dec(total - numb, 2)   
         