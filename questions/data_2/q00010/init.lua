
include("terms")

per = 2 * (4 + math.random(11))
number = 4999 + math.random(3001)

tax = per * number /100
tax = lib.math.round_dec(tax * conv,dec)
if (tax - 10*math.floor(tax/10) == 1) then
    val = msg[1]
else
    val = msg[2]
end	

price = 100 * tax / per 
price = lib.math.round_dec(price, dec)
    
if (price - 100*math.floor(price/100) == 1) then
    valnew = msg[1]
else
    valnew = msg[2]
end	            
  