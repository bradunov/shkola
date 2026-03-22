
include("names")

index_ime = math.random(#musko_ime_nom);    
name = musko_ime_nom[index_ime];              

per = {}

price = 10 * (7 + math.random(8))
per[1] =  2 + math.random(6);	
per[2] = 5 * math.random(per[1]-2)
per[1] =  5 * per[1];	

value = price * (100-per[1]) * (100-per[2]) / 10000
value = lib.math.round_dec(value, 2)
                      
              