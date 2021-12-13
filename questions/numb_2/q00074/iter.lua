
answ = {"=", "<", ">"}

broj = {}
numb = {}
sgn = {}
znak = {""}
ind = {}

for i = 1,2 do
    broj[i] = 11 - math.random(21);
	if (broj[i] == 0) then
	    broj[i] = (-1)^i * i
	end	
end	
if (broj[1] == broj[2]) then
    broj[1] = - broj[1]	
end
if (broj[1] > 0 and broj[2] > 0) then
    broj[2]= - broj[2]
end	

for i = 1,2 do
    sgn[i] = math.random(2)
    ind[i] = math.random(2)
	if (ind[i] == 2) then
	    broj[i] = lib.math.round_dec(broj[i] * 0.1,1)
    end	
    numb[i] = broj[i] * broj[i]	
	if (sgn[i] == 2) then
	    numb[i] = -numb[i]
		znak[i] = "-"
    end		
end 
if (sgn[1] * sgn[2] == 4) then
	index =  math.random(2)
	sgn[index] = 1
    numb[index] = -numb[index]
	znak[index] = ""
end	
fact = numb[1] - numb[2] 

sign = "="
if (fact < 0) then sign = "<"
end

if (fact > 0) then sign = ">"
end            
     