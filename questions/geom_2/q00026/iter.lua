
measure = {"°", "'", "''"}
answ = {"=", "<", ">"}

numb = {}
index = {}
value = {}
reply = {""}

for i = 1,3 do
    index[i] = math.random(5) - 1
	if (index[i] > 0) then
	    index[i] = 1
	end	
end	
if (index[1] == 0 and index[2] == 0) then
    index[1] = 1
end	

numb[1] = {}	
numb[1][1] = index[1] * math.random(100)
value[1] = numb[1][1]
for i = 2,3 do
    numb[1][i] = index[i] * math.random(59)  
    value[1] = value[1] * 60 + numb[1][i]	
end

ind = math.random(3)
max = 4000
if (ind == 1) then
    max = value[1]-50
end	
value[2] = value[1] + (ind - 2) * math.random(max) 	

numb[2] = {}
numb[2][1] = math.floor(value[2]/3600)
rest = value[2] - numb[2][1] * 3600
numb[2][2] = math.floor(rest/60)
numb[2][3] = math.floor(rest - numb[2][2] * 60)

if (ind == 2) then	
    sign = "="
else
    if (ind == 1) then
	    sign = ">"
	else	
	    sign = "<"
	end
end	

stampa = math.random(2)
for j = 1,2 do
    reply[j] = ""
    if (j == stampa) then 
        reply[j] = tostring(value[j]) .. measure[3]	
	else
        for i = 1,3 do 
            if (numb[j][i] ~= 0) then 
                reply[j] = reply[j] .. " " .. tostring(numb[j][i]) .. measure[i]
            end		
        end
    end		
end	
    