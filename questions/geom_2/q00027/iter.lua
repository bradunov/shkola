
measure = {"\(^\circ\)", "'", "''"}

numb = {}
index = {}
value = {}
term = {""}


for j = 1,2 do
    numb[j] = {}
    for i = 1,3 do
        index[i] = math.random(4) - 1
	    if (index[i] > 0) then
	        index[i] = 1
	    end	
    end	
    numb[j][1] = index[1] * math.random(100)
    value[j] = numb[j][1]
    for i = 2,3 do
        numb[j][i] = index[i] * math.random(59)  
        value[j] = value[j] * 60 + numb[j][i]	
    end
    if (value[j] == 0) then
        numb[j][1] = math.random(90)
	    value[j] = numb[j][1] * 3600
    end	
end

for j = 1,2 do
    term[j] = ""
    for i = 1,3 do 
        if (numb[j][i] ~= 0) then 
            term[j] = term[j] .. " " .. tostring(numb[j][i]) .. measure[i]	
        end
    end		
end	
      
if (value[1] < value[2]) then	
    sign = "+"
	value[3] = value[1] + value[2]
else
	sign = "-"
	value[3] = value[1] - value[2]	
end		

numb[3] = {}
numb[3][1] = math.floor(value[3]/3600)
rest = value[3] - numb[3][1] * 3600
numb[3][2] = math.floor(rest/60)
numb[3][3] = math.floor(rest - numb[3][2] * 60)

answ = ""
for i = 1,3 do 
    if (numb[3][i] ~= 0) then 
        answ = answ .. " " .. lib.check_number(numb[3][i], 20) .. measure[i]	
    end
end		  
