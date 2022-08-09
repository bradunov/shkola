
letter = {"a", "b", "c", "m", "n", "p", "x", "y", "z"}

bracl = "\(\bigl(\)"
bracr = "\(\bigl)\)"

ch = {}
numb = {}

grd = 1 + math.random(5)
rest = grd -2*math.floor(grd/2)
quest = bracl
answ = " "

stampa = 2
sign = 1
cor = ""
for i = 1,stampa do
    numb[i] = 1 + math.random(6)
	ch[i] = math.random(3)
	if (i > 1) then
	    for j = 1,i-1 do
		    if (ch[i] == ch[j] and numb[i] == numb[j]) then
                numb[i] = 10 - i
            end
        end	
    end		
	if (ch[i] < 3) then
		if (ch[i] == 1) then
			base = tostring(numb[i])
	        base1 = tostring(-numb[i])			
		else	
			base = letter[numb[i]-1]
			base1 = "-" .. base
		end		
	else
		denom = numb[i]
		enum = math.random(numb[i]-1)	
		qq = lib.math.gcd(enum, denom)
		denom = math.floor(denom/qq)
		enum = math.floor(enum/qq)		
        base = "\(\frac{" .. tostring(enum) .."}{" .. tostring(denom) .. "}\)"
        base1 = "\(\frac{" .. tostring(-enum) .."}{" .. tostring(denom) .. "}\)"	
	end
	sg = math.random(2)
    if (sg == 1) then 
        termq = base
    else
        termq = base1
		sign = -sign
    end		
	quest = quest .. "(" .. termq .. ")" 
    if (i < stampa) then
       quest = quest .. " : "
    else
	   quest = quest .. bracr .. "\(^{" .. grd  .. "}\) "	
    end	   
	if (ch[i] == 1) then
	    tmp = math.floor(numb[i]^grd)
		answ = answ .. lib.check_number(tmp,40)
	end	
	if (ch[i] == 2) then
	    terma = base
		answ = answ .. lib.check_string(terma,20) .. lib.sup_start() .. lib.check_number(grd,15)	.. lib.sup_end()
	end	
	if (ch[i] == 3) then
		en = math.floor(enum^grd)
		den = math.floor(denom^grd)	
		answ = answ .. lib.check_fraction_simple(en, den)
	end		
    if (i < stampa) then
        answ = answ .. " : "
    end
end
if (sign == -1 and rest ~= 0) then
	cor = "-"
end 
ans = lib.check_string(cor,10) .. bracl .. answ .. bracr	
   