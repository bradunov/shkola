
answ = {"=", "<", ">"}
lnumber = {}
rnumber = {}

min_range = 39
max_range = 60

test = 0 
for i = 1,2 do
    lnumber[i] = min_range - math.random(max_range);
	if (i > 1 and lnumber[i] < 0) then
	    test = 1
	end	
end
if (test == 0) then
    ch = math.random(2)
	lnumber[ch] = -lnumber[ch]
end

test = 0 
for i = 1,2 do
    rnumber[i] = min_range - math.random(max_range);
	if (i > 1 and rnumber[i] < 0) then
	    test = 1
	end	
end
if (test == 0) then
    ch = math.random(2)
	rnumber[ch] = -rnumber[ch]
end

loper = math.random(2)
if (loper == 1) then
    leftsumm = lnumber[1] + lnumber[2]
    ls = "+"
else
    leftsumm = lnumber[1] - lnumber[2]
    ls = "-"	
end	
roper = math.random(2)
if (roper == 1) then
    rightsumm = rnumber[1] + rnumber[2]
    rs = "+"
else
    rightsumm = rnumber[1] - rnumber[2]
    rs = "-"	
end	

sign = "="   
if (leftsumm > rightsumm) then sign = ">"	
end
if (leftsumm < rightsumm) then sign = "<"
end
                           
                                   

           
                                   
