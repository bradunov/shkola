
include("terms")

enum = {}
denom = {}
value = {}
term = {""}
note = ""
equ = ""

dim = 2

numb = 3 + math.random(7)
max_range = 9

index = math.random(2)
ch = math.random(2)

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
		
ind = math.random(2)
if (ind == 1) then
	choice = 1 + math.random(5)		
	enum[2] = 1
	denom[2] = choice
	value[2] = enum[2] / denom[2]	
	term[2] = part[choice]
end

nr = 0
if (value[1] == value[2]) then
    for i = 3, dim+5 do
	    if (nr == 0) then
			if (value[1] ~= value[i]) then
				nr = i
				enum[1] = enum[i]
				denom[1] = denom[i]
				value[1] = value[i]	
				term[1] = term[i]			
			end
		end
	end
end		

if (index == 1 and nr > 0) then
    index = 2
end	

imen = denom[1] * denom[2]
if (index == 2) then	
	equ = lib.check_fraction_simple(enum[1], denom[1]) .. lib.check_string("a", 15)
	broj = (enum[1] * denom[2] - enum[2] * denom[1]) * numb	   
else	
	if (ch == 1) then
		brojilac = 100 + enum[1]			
    else  
		brojilac = 100 - enum[1]		
    end	
	broj = (brojilac * denom[2] - enum[2] * denom[1]) * numb
    if (enum[1] > 4) then
        note = part[1]
    else
        if (enum[1] == 1) then 
			note = part[7]	
        else
			note = part[8]		
		end
	end
	equ = lib.check_number(lib.math.round_dec(brojilac/denom[1],2)) .. lib.check_string("a", 15)
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
equ = equ .. lib.check_string(op,15)	
if (math.abs(rest) < 1e-7) then
	equ = equ .. lib.check_number(lib.math.round_dec(math.abs(fct),2))	
else
	equ = equ .. lib.check_fraction_simple(math.abs(broj), imen)	
end
	 
equ = equ .. " " .. "="
if (ind == 1) then
	equ = equ .. lib.frac_start() .. lib.check_string("a", 20) .. lib.frac_mid() .. lib.check_number(choice,20) .. lib.frac_end() 
else
	equ = equ .. lib.check_fraction_simple(enum[2], denom[2]) .. lib.check_string("a", 20) 
end   
            
            