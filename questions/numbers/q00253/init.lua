
include("terms")
include("names")

r = math.random(#zensko_ime_nom)
ime = zensko_ime_nom[r] 

book = 100 + math.random(99)
numb = 4 + math.random(5)
period = math.ceil(book /numb)

if (period - 10*math.floor(period/10) == 1) then
    term = msg[2]
else
	term = msg[1]	
end	
     