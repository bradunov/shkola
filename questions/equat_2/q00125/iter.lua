
bracl = "\(\bigl(\)"
bracr = "\(\bigl)\)"

enum = {}
denom = {}
broj = {}
imen = {}
value = {}
ch = {}
term = {""}


--[[koeficijenti]]--	
max_range = 9
for i = 1,2 do	
	ch[i] = 1 + math.random(2)
	enum[i] = math.random(3*max_range)		 
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
    value[i] = enum[i]/denom[i]
end	
if (value[2] > value[1]) then
    tmp = enum[1]
	enum[1] = enum[2]
	enum[2] = tmp
    tmp = denom[1]
	denom[1] = denom[2]
	denom[2] = tmp	
    tmp = value[1]
	value[1] = value[2]
	value[2] = tmp	
    tmp = ch[1]
	ch[1] = ch[2]
	ch[2] = tmp
end 
quest = bracl 
term[1] = bracl
term[2] = bracl
for i = 1,2 do 
	if (ch[i] < 3) then	
		quest = quest .. lib.dec_to_str(lib.math.round_dec(value[i],1))
		term[1] = term[1] .. lib.check_number(lib.math.round_dec(value[i],1),30) 
		term[2] = term[2] .. lib.check_number(lib.math.round_dec(value[i],1),30) 						
	else	
		quest = quest .. "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)" 
		term[1] = term[1] .. lib.frac_start() .. lib.check_number(enum[i], 30) .. lib.frac_mid() .. lib.check_number(denom[i],30) .. lib.frac_end() 
		term[2] = term[2] .. lib.frac_start() .. lib.check_number(enum[i], 30) .. lib.frac_mid() .. lib.check_number(denom[i],30) .. lib.frac_end() 	
	end	
	
	quest = quest .. bracr .. "\(^{\small" .. 2 .. "}\)"
    if (i == 1) then
        quest = quest .. " - " .. bracl
		term[1] = term[1] .. " " .. lib.check_string("+",10) .. " "
		term[2] = term[2] .. " " .. lib.check_string("-",10) .. " "		
	else
		term[1] = term[1] .. bracr
		term[2] = term[2] .. bracr			
	end	
end

ans = term[1] .. " * " .. term[2] 

for i = 1,2 do
	broj[i] = enum[i] * enum[i] 
	imen[i] = denom[i] * denom[i]
end
brojilac = broj[1] * imen[2] - broj[2] * imen[1]
imenilac = imen[1] * imen[2]
qq = lib.math.gcd(brojilac, imenilac)
brojilac = math.floor(brojilac/qq)
imenilac = math.floor(imenilac/qq)	
res = brojilac /imenilac

result = ""  	
rest = 100*res - math.floor(100*res)	
if (rest == 0) then
	result = lib.check_number(lib.math.round_dec(res,2),40) 
else	
	result = lib.frac_start() .. lib.check_number(brojilac, 40) .. lib.frac_mid() .. lib.check_number(imenilac,40) .. lib.frac_end()
end	
  