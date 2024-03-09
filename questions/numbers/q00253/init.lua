
include("terms")
include("names")

r = math.random(#zensko_ime_nom)
ime = zensko_ime_nom[r] 

book = 114 + math.random(99)
rest = book - 10*math.floor(book /10)
if (rest == 0 or rest > 4) then
    pg = modif[3]
else
	if (rest == 1) then
		pg = modif[1]	
	else
	    pg = modif[2]
	end
end

numb = 4 + math.random(5)
period = math.ceil(book /numb)

if (period - 10*math.floor(period/10) == 1) then
    term = msg[2]
else
	term = msg[1]	
end	
  