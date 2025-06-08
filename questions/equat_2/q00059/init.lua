
include("terms")

elem = " ∈ "  
rel = {" < ", " > ", " ≤ ", " ≥ "}
brac = {"(", ")", "{", "}"}
space = " , \( \ \ \ \ \)"
ang = "∢"

enum = {}
denom = {}
ch = {}
val = {}
numb = {}
broj = {}

quest = ""
equ = {""}

max_range = 5
xx = 3 + math.random(max_range)
yy = math.random(xx - 1)
numb[1] = xx^2 - yy^2          
numb[2] = 2 * xx * yy
numb[3] = xx^2 + yy^2

for i = 1,4 do	   
	ch[i] = 1 + math.random(2)
	enum[i] = math.random(max_range)
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
	val[i] = enum[i] / denom[i]	
end

temp = ""
quest = " ( "

if (ch[2] < 3) then
	quest = quest .. lib.dec_to_str(lib.math.round_dec(val[2],1)) 		
else		
	quest = quest .. "\(\frac{" .. tostring(enum[2]) .."}{" .. tostring(denom[2]) .. "}\)"
end	
if (val[1] > 0) then
	quest = quest .. " + "
else
	quest = quest .. " - "	
end	
if (math.abs(val[1]) ~= 1) then
	if (ch[1] < 3) then
		tmp = math.abs(lib.math.round_dec(val[1],1))
		quest = quest .. lib.dec_to_str(tmp) 		
	else		
		quest = quest .. "\(\frac{" .. tostring(math.abs(enum[1])) .."}{" .. tostring(denom[1]) .. "}\)"
	end	
end
	quest = quest .. "k )"
	
tmp = math.abs(lib.math.round_dec(val[3],1))
if (tmp ~= 1) then
	if (ch[3] < 3) then
		temp = lib.dec_to_str(tmp) 		
	else		
		temp = "\(\frac{" .. tostring(math.abs(enum[3])) .."}{" .. tostring(denom[3]) .. "}\)"
	end	
end
quest = temp .. quest 
if (ch[4] < 3) then
    tmp = math.abs(lib.math.round_dec(val[4],1))
	temp = lib.dec_to_str(tmp) 		
else		
	temp =  "\(\frac{" .. tostring(math.abs(enum[4])) .."}{" .. tostring(denom[4]) .. "}\)"
end	
if (val[4] > 0) then
    if (val[3] > 0) then 
		quest = temp .. " + " .. quest
	else
		quest = temp .. " - " .. quest	
	end
else
   if (val[3] > 0) then 
		quest = quest .. " - " .. temp
	else
		quest = "- " .. temp .. " - " .. quest	
	end
end


if (numb[2] > numb[1]) then
    equ[1] = lib.check_number(numb[2],20) .. " - " .. lib.check_number(numb[1],20)
else
    equ[1] =  lib.check_number(numb[1],20) .. " - " .. lib.check_number(numb[2],20)	
end	
equ[1] = quest .. " " .. lib.check_one_option_dropdown(rel, rel[2]) .. " " .. equ[1]
equ[2] = quest .. " " .. lib.check_one_option_dropdown(rel, rel[1]) .. " " .. lib.check_number(numb[3],30)

sum = enum[4]*denom[2]*denom[3] + enum[2]*enum[3]*denom[4]
prod = denom[2]*denom[3]*denom[4]
broj[1] = (prod*math.abs(numb[1]-numb[2]) - sum) * denom[1]
broj[2] = (prod*numb[3] - sum) * denom[1]	
imen = enum[1] * enum[3] * denom[2] * denom[4]
 
value1 = broj[1]/imen
value2 = broj[2]/imen
if (val[1]*val[3] > 0) then
	bound_left = math.ceil(value1)
	if (value1 == bound_left) then
	    bound_left = bound_left + 1
	end	
	bound_right = math.floor(value2)
	if (value2 == bound_right) then
	    bound_right = bound_right - 1
	end		
else
	bound_left = math.ceil(value2)
	if (value2 == bound_left) then
	    bound_left = bound_left + 1
	end	
	bound_right = math.floor(value1)
	if (value1 == bound_right) then
	    bound_right = bound_right - 1
	end		
end		

set = ""
temp = " ... ,"
note = ""
nr = bound_right - bound_left
if (nr < 0) then
    note = lib.check_one_option_dropdown(msg, msg[2])
    set = " k " .. " " .. lib.check_one_option_dropdown(rel, rel[2]) .. lib.check_number(bound_left,30) .. space .. " k " .. " " .. lib.check_one_option_dropdown(rel, rel[1]) .. lib.check_number(bound_right,20)
else
    note = lib.check_one_option_dropdown(msg, msg[1])
	set = " k " .. elem .. brac[3]
	if (nr > 0) then
		if (nr <= 5) then
			for i = 1, nr do	
				set = set .. lib.check_number(bound_left+i-1,30) .. ", "  
			end	
		else
			for i = 1, 2 do
				set = set .. lib.check_number(bound_left+i-1,30) .. ", "  
				temp = temp .. lib.check_number(bound_right -3+i,30) .. ", " 		
			end	
			set = set .. temp
		end	
	end	
	set = set .. lib.check_number(bound_right,30) .. brac[4]   
end	
   
 
--[[
a = numb[1]^2 - numb[2]^2	
b = 2 * numb[1] * numb[2]	
c = numb[1]^2 + numb[2]^2
Pitagorina teorema :  c^2 = a^2 + b^2,  numb[1], numb[2] = math.random
]]--
      