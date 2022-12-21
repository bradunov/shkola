
include("terms")

enum = {}
denom = {}
value = {}
ind = {}
term = {""}
note = ""
quest = ""
equ = ""

dim = 3

numb = 3 + math.random(7)
max_range = 9

index = math.random(2)
ch = math.random(2)
sg = math.random(2)

for i = 1,dim+5 do	
	enum[i] = math.random(2*max_range)	
	denom[i] = 1 + math.random(max_range)
	qq = lib.math.gcd(enum[i], denom[i])
	enum[i] = math.floor(enum[i]/qq)
	denom[i] = math.floor(denom[i]/qq)		
	if (denom[i] == 1) then
		denom[i] = enum[i] + math.random(max_range)
		qq = lib.math.gcd(enum[i], denom[i])
		enum[i] = math.floor(enum[i]/qq)
		denom[i] = math.floor(denom[i]/qq)
	end	
	value[i] = enum[i] / denom[i]
	term[i] = "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
end
		
if (index == 1) then
	denom[1] = 100
	value[1] = enum[1] / denom[1]	
	term[1] = tostring(enum[1])
end		

chold = 1
for i = 2,3 do		
	ind[i] = math.random(2)
	choice = 1 + math.random(5)		
	if (ind[i] == 1 and choice ~= chold) then	
		enum[i] = 1
		denom[i] = choice
		value[i] = enum[i] / denom[i]	
		term[i] = part[choice]
	    if (i == 2) then
			chold = choice	
        end			
	end
end
if (chold == choice) then
    ind[3] = 2
end	

nr = 1
sum1 = value[2] + value[3]
sum2 = value[2] - value[3]
if (sg == 1 and value[1] == sum1) then  
    for i = 4, dim+10 do
	    if (nr == 1) then
			if (value[i] ~= sum1) then 
				nr = i
			end
		end
	end
else	
	if (sg == 2 and value[1] == sum2) then
	    for i = 4, dim+10 do
			if (nr == 1) then
				if (value[i] ~= sum2) then 
					nr = i
				end
			end
		end	
	end
end	
if (nr > 1) then
	index = 2
	enum[1] = enum[nr]
	denom[1] = denom[nr]
	value[1] = value[nr]	
	term[1] = term[nr]	
end

imenilac = denom[2] * denom[3]
imen = denom[1] * imenilac
if (sg == 1) then
	brojilac = enum[2] * denom[3] + enum[3] * denom[2]	
else
	brojilac = enum[2] * denom[3] - enum[3] * denom[2]	
end	
if (index == 2) then
	quest = term[1]	.. text[1] .. text[2]	
	equ = lib.check_fraction_simple(enum[1], denom[1]) .. lib.check_string("a", 15)
	broj = (enum[1] * imenilac - brojilac * denom[1]) * numb	   
else	
	quest = text[4] 
	if (ch == 1) then
		quest = quest .. relat[5]
		brojper = 100 + enum[1]			
    else 
 		quest = quest .. relat[4] 
		brojper = 100 - enum[1]		
    end	
	broj = (brojper * imenilac - brojilac * denom[1]) * numb
    if (enum[1] > 4) then
        note = part[1]
    else
        if (enum[1] == 1) then 
			note = part[7]	
        else
			note = part[8]		
		end
	end
	quest = quest .. relat[1] .. term[1] .. " " .. note .. ", " .. text[2]
	equ = lib.check_number(lib.math.round_dec(brojper/denom[1],2)) .. lib.check_string("a", 15)
end	

broj = lib.math.round(broj)
imen = lib.math.round(imen)
fct = broj/imen	
rest = 100*fct - lib.math.round(100*fct)				
if (math.abs(rest) < 1e-7) then
	if (fct == lib.math.round(fct)) then
		coef = lib.math.round(math.abs(fct)) 
	else
		if (fct*10 == lib.math.round(fct*10)) then
			coef = lib.math.round_dec(math.abs(fct),1) 
		else
			coef = lib.math.round_dec(math.abs(fct),2) 
		end
	end
else 
	qq = lib.math.gcd(broj, imen)
	broj = math.floor(broj/qq)
	imen = math.floor(imen/qq)	
	coef = "\(\frac{" .. tostring(math.abs(broj)) .."}{" .. tostring(imen) .. "}\)"				
end		
quest = quest .. relat[1] .. coef      	
if (broj < 0) then
	if (index == 1) then
		sign = relat[6]		
	else
		sign = relat[2]	
	end	
	op = " + "		
else
	if (index == 1) then
		sign = relat[7]		
	else
		sign = relat[3]	
	end	
	op = " - "			
end
quest = quest .. sign .. text[3] 	
equ = equ .. lib.check_string(op,15)	
if (math.abs(rest) < 1e-7) then
	equ = equ .. lib.check_number(lib.math.round_dec(math.abs(fct),2))	
else
	equ = equ .. lib.check_fraction_simple(math.abs(broj), imen)	
end

if (sg == 1) then
    sign = relat[8]
	op = " + "
else
    sign = relat[9]	
	op = " - "	
end	
quest = quest .. sign .. term[2] .. text[5] .. term[3] .. text[1]
equ = equ .. " " .. "="
for i = 2,3 do
	if (ind[i] == 1) then
		equ = equ .. lib.frac_start() .. lib.check_string("a", 15) .. lib.frac_mid() .. lib.check_number(denom[i],20) .. lib.frac_end()          
	else
		equ = equ .. lib.check_fraction_simple(enum[i], denom[i]) .. lib.check_string("a", 15)  
	end
	if (i == 2) then
	    equ = equ .. lib.check_string(op,15) 
	end
end	
       