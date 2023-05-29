
numb = {}
value = {}
term = {""}

ind = math.random(2)
op = math.random(2)
	
for j = 1,4 do
    numb[j] = {}
end	

if (ind == 1) then
	value[4] = 36000 + math.random(36000)
    value[3] = 3 * value[4]
	if (op == 1) then
		value[1] = 60 * 3600 - value[4]
		value[2] = value[1] + value[3]
	else
		value[1] = 60 * 3600 + value[4]
		value[2] = value[1] - value[3]
    end	
else
	fct = 1 + math.random(9) 
    if (op == 1) then
		value[1] = 180 * 3600 / (2 + fct)
		value[2] = fct * value[1]
	else
		value[2] = 180 * 3600 / (2 * fct + 1)
		value[1] = fct * value[2]
    end
end	

if (ind == 1) then
    max_range = 3
else
    max_range = 2
end	
for i = 1,max_range do
	numb[i][1] = math.floor(value[i]/3600)
	rest = value[i] - numb[i][1] * 3600
	numb[i][2] = math.floor(rest/60)
	numb[i][3] = math.floor(rest - numb[i][2] * 60)
end 
	
tmp = math.floor((2*numb[1][3] + numb[2][3])/60) 
rest = (2*numb[1][3] + numb[2][3]) - tmp*60
if (rest ~= 0) then
	numb[2][3] = numb[2][3] + 60 - rest
end	
 
coef = activ[ind] .. space
if (ind == 1) then
    for i = 1,3 do  
        if (numb[3][i] ~= 0) then
		    coef = coef .. " " .. tostring(numb[3][i]) .. measure[i]	
		end
    end	
else   
    coef = tostring(fct) .. " " .. coef
end   

for j = 1,2 do
    term[j] = ""
    for i = 1,3 do 
        term[j] = term[j] .. " " .. lib.check_number(numb[j][i],25) .. measure[i]	
    end		
end	
