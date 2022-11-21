
oper = {"+", "-"}
letter = {"a", "b", "m", "n", "x", "y"}

choice = {""}
degr = {}
enum = {}
denom = {}
ch = {}

term = {""}
result = ""
quest = ""

choice = lib.math.random_shuffle(letter)
arg = ""
argchk = ""
for i = 1,2 do
    degr[i] = math.random(5)
	if (degr[i] == 1) then
		arg = arg .. choice[i] 
	else
		arg = arg .. choice[i] .. "\(^{" .. degr[i] .. "}\)"
	end
    argchk = argchk .. lib.check_string(choice[i],15) .. lib.sup_start() .. lib.check_number(degr[i],10) .. lib.sup_end()
end

op = math.random(2)
ind = math.random(2)
max_range = 5

for i = 1,2 do	
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
	sg = math.random(2)
	if (sg == 2) then
		enum[i] = - enum[i]
	end	
    val = enum[i]/denom[i]
    if (math.abs(val) ~= 1) then
		if (ch[i] < 3) then
			term[i] = lib.dec_to_str(lib.math.round_dec(enum[i]/denom[i],1)) 
			if (i == 2) then
				trm = 	lib.dec_to_str(lib.math.round_dec(-enum[i]/denom[i],1))	
            end				
		else	
			if (i == 2) then
				trm = 	"\(\frac{" .. tostring(-enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
            end			
			term[i] = "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
		end	
	else
        if (val == -1) then 
 	        term[i] = "- " 
			if (i == 2) then
				trm = 	""
            end				
        else
 	        term[i] = ""  
			if (i == 2) then
				trm = 	"- "
            end				
	    end	
	end	
	term[i] = term[i] .. arg
	if (i == 2) then
		trm = 	trm .. arg
	end			
end

if (ind == 2) then		
	if (op == 1) then
		broj = enum[1] * denom[2] + enum[2] * denom[1]
	else
		broj = enum[1] * denom[2] - enum[2] * denom[1]	
	end	
else
	if (op == 1) then
		broj = enum[2] * denom[1] - enum[1] * denom[2]
	else
		broj = enum[1] * denom[2] - enum[2] * denom[1]	
	end	
end	
imen = denom[1] * denom[2]
qq = lib.math.gcd(broj, imen)
broj = math.floor(broj/qq)
imen = math.floor(imen/qq)	
value = broj/imen
valabs = math.abs (value)	
rest = 10*valabs - math.floor(10*valabs)  
if (rest == 0) then
	result = lib.check_number(lib.math.round_dec(value,1),25) .. argchk 
else	
	result = lib.frac_start() .. lib.check_number(broj, 20) .. lib.frac_mid() .. lib.check_number(imen,20) .. lib.frac_end() .. argchk
end	


if (ind == 1) then
	quest = "(" .. term[1] .. ") " .. oper[op] .. " (" .. result .. ") = " .. term[2]		
else	
    quest = "(" .. result .. ") " .. oper[3-op] .. " (" .. term[2].. ") = " .. term[1]	
end	
	   