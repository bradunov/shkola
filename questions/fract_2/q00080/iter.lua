
answ = {"=", "<", ">"}

min = 3
max = 6

dec = math.random(3)

if (dec < 3) then
	imen = 10^dec
else	
    imen = min + math.random(max)	
end	
broj = math.random(imen - 1)
ceo = min - math.random(max)
if (ceo < 0) then
	enum = ceo * imen - broj
else
	enum = ceo * imen + broj	
end		
numb = enum/imen

--[[skracen razlomak: out=1,2]]--
com = lib.math.gcd(broj, imen)
brojs =  broj/com				
imens = imen/com
comm = lib.math.gcd(enum, imen)
enums =  enum/comm				
denoms = imen/comm

--[[decimalni zapis: out=3]]--
rest = numb*100 - math.floor(numb*100)
if (rest == 0) then
    max_out = 3	
else	
    max_out = 2
end	
out1 = math.random(max_out)
out2 = math.random(max_out)
	

ind = math.random(3)
znak1 = ""
znak2 = ""
if (ind == 1) then
    znak1 = "-"	
else
    if (ind == 2) then   
        znak2 = "-"	
    end
end	
	

quest1 = znak1
if (out1 == 3) then		
	quest1 = quest1 .. " ( " .. lib.math.round_dec(numb,2) .. " ) "
else
    ch = math.random(2)
    if (out1 == 1) then
        if (ch == 1) then	
	        enumerator = math.floor(enum)
			denominator = math.floor(imen)
		else	
	        enumerator = math.floor(enums)
			denominator = math.floor(imens)
        end
	    quest1 = quest1 .. " ( " .. "\(\frac{" .. enumerator .. "}{" .. denominator .. "}\)" .. " ) "
    else
       if (ch == 1) then	
	        enumerator = math.floor(broj)
			denominator = math.floor(imen)
		else	
	        enumerator = math.floor(brojs)
			denominator = math.floor(imens)
        end			
		if (ceo ~= 0) then
		    quest1 = quest1 .. " ( " .. ceo .. "\(\frac{" .. enumerator .. "}{" .. denominator .. "}\)" .. " ) "
		else
		    quest1 = quest1 .. " ( " .. "\(\frac{" .. enumerator .. "}{" .. denominator .. "}\)" .. " ) "
        end
	end
end

quest2 = znak2
if (out2 == 3) then		
	quest2 = quest2 .. " ( " .. lib.math.round_dec(numb,2) .. " )² "
else
    ch = math.random(2)
    if (out2 == 1) then
        if (ch == 1) then	
	        enumerator = math.floor(enum)
			denominator = math.floor(imen)
		else	
	        enumerator = math.floor(enums)
			denominator = math.floor(imens)
        end
	    quest2 = quest2 .. " ( " .. "\(\frac{" .. enumerator .. "}{" .. denominator .. "}\)" .. " )² "
    else
       if (ch == 1) then	
	        enumerator = math.floor(broj)
			denominator = math.floor(imen)
		else	
	        enumerator = math.floor(brojs)
			denominator = math.floor(imens)
        end			
		if (ceo ~= 0) then
		    quest2 = quest2 .. " ( " .. ceo .. "\(\frac{" .. enumerator .. "}{" .. denominator .. "}\)" .. " )² "
		else
		    quest2 = quest2 .. " ( " .. "\(\frac{" .. enumerator .. "}{" .. denominator .. "}\)" .. " )² "
        end
	end
end

numb2 = numb * numb

if (ind == 1) then
    numb = - numb	
else
    if (ind == 2) then   
        numb2 = - numb2	
    end
end	

if (numb < numb2) then 
    sign = "<"
else
    if (numb > numb2) then
        sign = ">"
	else
        sign = "="
    end
end	
	
                 
