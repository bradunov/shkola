
answ = {"=", "<", ">"}

enum = {} 
denom = {2, 4, 5, 8, 10}
ch = {}
imen = {}
broj = {}
value = {}
term = {""}
ind = {}

for i = 1,2 do
	ch[i] = math.random(5)
	imen[i] = denom[ch[i]]
	broj[i] = math.random(10)
	value[i] = lib.math.round_dec(broj[i] / imen[i],2)	
	if (value[i] == math.floor(value[i])) then
	    broj[i] = broj[i] + 1		
	end
	value[i] = broj[i] / imen[i]
end
if (imen[1] == imen[2] and broj[1] == broj[2]) then
	broj[1] = 11 + math.random(5)
	value[1] = broj[1] / imen[1]
end

for i = 1,2 do
	if (value[i] < 1) then
	    ind[i] = 1
	else
	    ind[i] = math.random(2)
	end
end	

if (value[1] < value[2]) then 
    sign = "<"
else
    if (value[1] > value[2]) then
        sign = ">"
	else
        sign = "="
    end
end	
for i = 1,2 do 
    term[i] = ""
	if (ind[i] == 2) then
		ceo = math.floor(value[i])
		broj[i] = broj[i] - ceo * imen[i]
		term[i] = ceo 
	end
	term[i] = term[i] .. "\(\frac{" .. broj[i] .. "}{" .. imen[i] .. "}\)"	
end	       