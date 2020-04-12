operation = {"veća", "manja"}

tomato = 1110 + math.random(4889)
vegetable = 1110 + math.random(3889)
chicken = 1110 + math.random(2889)

diff = 1110 + math.random(1889)
ind = math.random(2)
sign = operation[ind] 
	
temp = tomato + vegetable + chicken

if (ind == 1) then
    result = 2 * temp - diff
else
    result = 2 * temp + diff
end	



