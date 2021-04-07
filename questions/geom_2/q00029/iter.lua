
numb = {}
index = {}
value = {}
term = {""}
sign = {""}
fct = {}

for j = 1,2 do
    numb[j] = {}
    for i = 1,3 do
        index[i] = math.random(4) - 1
	    if (index[i] > 0) then
	        index[i] = 1
	    end	
    end	
    numb[j][1] = index[1] * math.random(40)
    value[j] = numb[j][1]
    for i = 2,3 do
        numb[j][i] = index[i] * math.random(59)  
        value[j] = value[j] * 60 + numb[j][i]	
    end
    if (value[j] == 0) then
        numb[j][1] = math.random(40)
	    value[j] = numb[j][1] * 3600
    end
end

for i = 1,2 do
    fct[i] = 1 + math.random(4)
	value[i+2] = value[i] * fct[i]
end

ind = math.random(2)
if (ind == 1) then
    sign[1] = "*"
	sign[2] = ":"
    if (value[3] > value[2]) then
	    value[5] = value[3] - value[2]
		sign[3] = "-"
    else
	    value[5] = value[3] + value[2]
		sign[3] = "+"	
	end
else
    sign[1] = ":"
	sign[2] = "*"
    if (value[1] > value[4]) then
	    value[5] = value[1] - value[4]
		sign[3] = "-"
    else
	    value[5] = value[1] + value[4]
		sign[3] = "+"	
	end
end

for i = 3,5 do
    numb[i] = {}
    numb[i][1] = math.floor(value[i]/3600)
    rest = value[i] - numb[i][1] * 3600
    numb[i][2] = math.floor(rest/60)
    numb[i][3] = math.floor(rest - numb[i][2] * 60)
end	

for j = 1,2 do
    term[j] = ""
    if (ind == 1) then
	    if (j == 1) then  
		    jj = 1
		else
            jj = 4
        end
    else
	    if (j == 1) then  
		    jj = 3
		else
            jj = 2
        end   	
    end
    for i = 1,3 do 
        if (numb[jj][i] ~= 0) then 
            term[j] = term[j] .. " " .. tostring(numb[jj][i]) .. measure[i]	
        end
    end		
end	
     
answ = ""
for i = 1,3 do 
    if (numb[5][i] ~= 0) then 
        answ = answ .. " " .. lib.check_number(numb[5][i], 25) .. measure[i]	
    end
end		  
      