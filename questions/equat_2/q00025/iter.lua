
include("terms")                                                                                                                                                                                                                                                                                                                                                                             

brac = {"\(\big ( \)", "\(\big ) \)"}
oper = {" - ", " + ", ":", "*"}

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
term = {""}
ch = {}
inds = {}

com = 0

max = 8

inds[1] = math.random(4);
if (inds[1] < 3) then
    min = 2
else
    min = 0
end	
inds[2] = min + math.random(2)

for i = 1,3 do
    denom[i] = 2 + math.random(max);
    enum[i] =  math.random(2*max);
    if (enum[i] == denom[i]) then
        denom[i] = denom[i] + 1
    end
	fact = math.random(2)
	if (fact == 1) then
        enum[i] = - enum[i]
	end	
end	

index = math.random(4)

if (index < 3) then

    if (inds[1] < 3) then
        imenilac = denom[1] * denom[2] 
        if (inds[1] == 1) then
            brojilac = enum[1] * denom[2] - enum[2] * denom[1]
        else
            brojilac = enum[1] * denom[2] + enum[2] * denom[1]	
        end
    else
        if (inds[1] == 3) then
	        imenilac = enum[2] * denom[1]
            brojilac = enum[1] * denom[2] 
        else
	        brojilac = enum[1] * enum[2]
            imenilac = denom[1] * denom[2] 
        end    	
    end	
    if (inds[2] < 3) then
        denom[4] = imenilac * denom[3] 
        if (inds[2] == 1) then
            enum[4] = brojilac * denom[3] - imenilac * enum[3] 
        else
            enum[4] = brojilac * denom[3] + imenilac * enum[3] 	
        end
    else
        if (inds[2] == 4) then
	        denom[4] = imenilac * denom[3] 
            enum[4] = brojilac * enum[3] 
        else
	        denom[4] = imenilac * enum[3] 
            enum[4] = brojilac * denom[3] 
        end    	
    end	

else

    if (inds[1] < 3) then
        imenilac = denom[2] * denom[3] 
        if (inds[1] == 1) then
            brojilac = enum[2] * denom[3] - enum[3] * denom[2]
        else
            brojilac = enum[2] * denom[3] + enum[3] * denom[2]	
        end
    else
        if (inds[1] == 3) then
	        imenilac = enum[3] * denom[2]
            brojilac = enum[2] * denom[3] 
        else
            imenilac = denom[2] * denom[3] 
	        brojilac = enum[2] * enum[3]		
        end    	
    end	
    if (inds[2] < 3) then
        denom[4] = imenilac * denom[1] 
        if (inds[2] == 1) then
            enum[4] = enum[1] * imenilac  - denom[1] * brojilac
        else
            enum[4] = enum[1] * imenilac  + denom[1] * brojilac 	
        end
    else
        if (inds[2] == 4) then
	        denom[4] = imenilac * denom[1] 
            enum[4] = brojilac * enum[1] 
        else
	        enum[4] = imenilac * enum[1] 
            denom[4] = brojilac * denom[1] 
        end    	
    end	

end
 
if (denom[4] < 0) then
    denom[4] = - denom[4]
    enum[4]	= - enum[4]
else
    if (denom[4] == 0) then
       com = 1
    end	   
end	

if (com == 0) then
for i = 1,4 do
    term[i] = ""
    q = lib.math.gcd(enum[i], denom[i])
    denom[i] = denom[i] / q
    enum[i] = enum[i] / q
    value[i] = enum[i]/denom[i]
    tmp = math.floor(value[i] * 10)
	rest = value[i] * 10 - tmp	
    if (rest == 0) then	
	    term[i] = lib.dec_to_str(lib.math.round_dec(value[i], 1))
        ch[i] = 1
	else	
        if (value[i] > 0) then
            whl[i] = math.floor(value[i])
        else 
            whl[i] = math.ceil(value[i])
        end
        enum_p[i] = enum[i]	- whl[i] * denom[i]
        if (whl[i] ~= 0) then
            term[i] = term[i] .. tostring(whl[i])  
			enum_p[i] = math.abs(enum_p[i])
        end
        term[i] = term[i] .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	
        ch[i] = 2
	end
end


quest = ""
if (index == 1) then
    quest = brac[1] .. "x " .. oper[inds[1]] .. " ("  .. term[2] .. ") " .. brac[2] .. " " .. oper[inds[2]] .. " ("  ..  term[3] .. ") = " .. term[4]
end
if (index == 2) then
    quest = brac[1] .. " ("  .. term[1] .. ") ".. oper[inds[1]]  .. " x" .. brac[2] .. " " .. oper[inds[2]] .. " ("  ..  term[3] .. ") = " .. term[4]
end
if (index == 3) then
    quest = " ("  .. term[1] .. ") " .. oper[inds[2]] .. " " .. brac[1] .. "x " .. oper[inds[1]] .. " ("  ..  term[3] .. ") " .. brac[2] .. " = " .. term[4]
end
if (index == 4) then
    quest = " ("  .. term[1] .. ") " .. oper[inds[2]] .. " " .. brac[1] .. " ("  ..  term[2] .. ") " .. oper[inds[1]] .. " x ".. brac[2] .. " = " .. term[4]
end

answ1 = ""
answ2 = ""

if (index > 2) then
   index = index - 1
end   

if (ch[index] == 1) then	
        answ1 = lib.check_number(value[index],30)	
else 
    if (whl[index] ~= 0) then
        answ1 = lib.check_number(whl[index],20)  
    end
	tmp = enum_p[index]/denom[index]	
 	condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
    sln2 = "numerator="..tostring(enum_p[index])..";denominator="..tostring(denom[index])..";"
    answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)
end

else 
    answ1 = msg
end	


