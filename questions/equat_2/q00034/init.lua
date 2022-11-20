 
include("terms") 

brac = {"\(\big ( \)", "\(\big ) \)"}

enum = {}
denom = {}
ch = {}
sifra = {}
out = {}

--[[koeficijenti c[3])*(c[1]x+c[2])+c[4] ]]--	
max_range = 5

for i = 1,4 do	   
	ch[i] = 1 + math.random(2)
	enum[i] = math.random(2*max_range)
	if (ch[i] == 2) then
		denom[i] = 1
	else
		denom[i] = 1 + math.random(max_range)
		qq = lib.math.gcd(enum[i], denom[i])
		enum[i] = math.floor(enum[i]/qq)
		denom[i] = math.floor(denom[i]/qq)
		if (denom[i] == 1) then
			ch[i] = 2
		else
			tmp = enum[i]/denom[i]
			rest = 10*tmp - math.floor(10*tmp)				
			if (rest == 0) then
				enum[i] = 10 * tmp
				denom[i] = 10
				ch[i] = 1			
			end	
		end	
	end	
end
if (denom[2]*denom[3]*enum[4] == enum[2]*enum[3]*denom[4]) then
    enum[4] = enum[4] + 1
end

term = ""
val = enum[1]/denom[1]
if (val ~= 1) then
	if (ch[1] < 3) then
		term = term .. lib.dec_to_str(lib.math.round_dec(enum[1]/denom[1],1)) 		
	else		
		term = term .. "\(\frac{" .. tostring(enum[1]) .."}{" .. tostring(denom[1]) .. "}\)"
	end	
end
term = term .. "x"	
free = ""
if (enum[2] ~= 0) then
	if (ch[2] < 3) then
		free = lib.dec_to_str(lib.math.round_dec(enum[2]/denom[2],1)) 		
	else		
		free =  "\(\frac{" .. tostring(enum[2]) .."}{" .. tostring(denom[2]) .. "}\)"
	end			
end	
coef = ""	
if (ch[3] < 3) then
	coef = lib.dec_to_str(lib.math.round_dec(enum[3]/denom[3],1)) 		
else		
	coef =  "\(\frac{" .. tostring(math.floor(enum[3])) .."}{" .. tostring(math.floor(denom[3])) .. "}\)"
end	
fct = " "	
if (ch[4] < 3) then
	fct = fct .. lib.dec_to_str(lib.math.round_dec(enum[4]/denom[4],1)) 		
else		
	fct =  fct .. "\(\frac{" .. tostring(math.floor(enum[4])) .."}{" .. tostring(math.floor(denom[4])) .. "}\)"
end
		
qst = math.random(4)	
term_left = ""
if (qst < 3) then		
	term_left = coef .. brac[1] .. term .. " + " .. free .. brac[2]  
else
	term_left = coef .. brac[1] ..term .. " - " .. free .. brac[2] 					        	
end
if (qst == 2 or qst == 4) then			
	term_left = fct .. " - " .. term_left
else
	term_left = term_left	.. " + " .. fct	
end

nr = 0
for i = 1,4 do
    for j = 1,4 do
	    nr = nr + 1
	    sifra[nr] = 10 * i + j
    end
end	

out = lib.math.random_shuffle(sifra)
                                     