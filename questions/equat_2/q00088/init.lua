
numb = {}
price = {}
total = {}

max_range = 5
fct = 5 * (2 + math.random(max_range))
price[1] = fct * (2 + math.random(8))
price[2] = price[1] + 10 * math.random(8)
for i = 1,2 do
	total[i] = 0
    for j = 1,2 do
		numb[2*(i-1)+j] = 1 + math.random(max_range)
		total[i] = 	total[i] + numb[2*(i-1)+j] * price[j]
	end
end
