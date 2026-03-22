
bracketl = "{"
bracketr = "}"
dot = "\(\dots\)"

opt = {"P ∪ R", "P ∩ R", "P \ R", "R \ P"}

numbp = {}
numbr = {}
value = {}

setp = bracketl	
minp = 50 + math.random(19)
difp = 50 + math.random(29)
for i = 1, difp do
    numbp[i] = i - 1 + minp 
    if (i < 4) then
	    setp = setp .. tostring(numbp[i]) .. ", "
	end
	if (i == difp) then
       setp = setp .. " " .. dot .. " , " .. tostring(numbp[i]) .. bracketr
	end	

end
maxp = numbp[difp]
	
setr = bracketl
minr = minp + 20 + math.random(19)
difr = 53 + math.random(29)
for i = 1, difr do
    numbr[i] = i - 1 + minr
	if (i < 4) then
       setr = setr .. tostring(numbr[i]) .. ", "	
	end
	if (i == difr) then
       setr = setr .. " " .. dot .. " , " .. tostring(numbr[i]) .. bracketr
	end	
end
maxr = numbr[difr]

ind = math.random(4)
value[1] = maxr - minp + 1
value[2] = maxp - minr + 1
value[3] = minr - minp 
value[4] = maxr - maxp
    