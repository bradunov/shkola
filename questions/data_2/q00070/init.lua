
include("names")

index_ime = math.random(#zensko_ime_nom);    
ime = zensko_ime_nom[index_ime];                   

denom = { 2, 3, 4, 5, 6, 8}
money = {"€", "£"}

price = 65 + 5 * math.random(8)
ch = math.random(6)
imen = denom[ch]
broj = 1
quest = "\(\frac{" .. broj .. "}{" .. imen .. "}\)"
proc = lib.math.round(broj/imen * 100) - 5 + math.random(10)

first = lib.math.round_dec(price * (1 - broj/imen),1)
second = lib.math.round_dec(price * (1 - proc/100),1)
