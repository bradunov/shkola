
term = {} 
out = {}

answ = {}

odd_min = 2 * math.random(2) - 1;
odd_max = 2 * (10 + math.random(15)) - 1;

even_min = 2 * math.random(2);
even_max = odd_max - 5 + math.random(10);
temp = math.floor(even_max/2)
if (even_max - 2*temp ~= 0) then 
    even_max = even_max - 1
end	

number_odd = (odd_max - odd_min)/2 
number_even = (even_max - even_min)/2 

number = number_odd + number_even + 2

term[1] = number
term[2] = odd_max - odd_min

if (odd_max < even_max) then
    term[3] = even_max
else
    term[3] = odd_max
end	

term[4] = number - 2
term[5] = odd_max + even_max	

out = lib.math.argsort(term)

for i = 2,5 do
    if (term[out[i]] == term[out[i-1]]) then
	    term[out[i]] = term[out[i]] + 1
	end
end                  
                  
answ = lib.math.random_shuffle(term)	

for i = 1,5 do     
    if (answ[i] == number) then
	    ind = i - 1
	end
end	






