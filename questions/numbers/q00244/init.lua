
include("names")
include("terms")

r = math.random(#zensko_ime_nom)
ime = zensko_ime_nom[r] 

numb = {}
text = {""}
 
numb[2] =  20 + math.random(10)
add = 5 + math.random(10)
min_range = 2 * numb[2] + add
numb[1] =  min_range + 5 + math.random(94 - min_range)

ind = math.random(2)         

numb[3] = numb[1] - 2 * numb[2]
if (ind == 1) then
    numb[3] = numb[3] - add
else	
    numb[3] = numb[3] + add
end            
            
for i = 1,3 do 
    if (numb[i] > 9 and numb[i] < 20) then
		text[i] = msg[3]
    else	    
		tmp = numb[i] - 10 * math.floor(numb[i]/10)
		if (tmp > 0 and tmp < 5) then
			if (tmp == 1) then 
				text[i] = msg[1]
			else
				text[i] = msg[2]
			end		
		else
			text[i] = msg[3]
		end	
	end
end	