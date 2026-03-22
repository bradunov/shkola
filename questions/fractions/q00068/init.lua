
include("terms")
include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r]
adv = musko_mpridev[r]

numb = 8 + 2 * math.random(4);
tmp = 0.2975 + 0.0025*math.random(7)				
fct = 5 + 0.1*math.random(5)
price = fct* tmp;
cost = numb*tmp
cost = lib.math.round_dec(cost * conv,dec)
price = lib.math.round_dec(price * conv,dec)

sell = 30 + math.random(9)
profit = sell * (numb*price - cost)
total = lib.math.round(0.5 * profit) - conv*(25 + math.random(25))
profit = profit - total
total = lib.math.round_dec(total,dec)
profit = lib.math.round_dec(profit,dec)
                  
        