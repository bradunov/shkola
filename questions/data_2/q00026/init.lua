
set = {2, 2, 2, 3, 3, 5}

enum = {}
denom = {}
value = {}
whl = {}
enum_p = {}
out = {""}
qq = {}
reply = {""}
                                                                                                                                                                                                                                                                                                
choice = math.random(2)
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
    index = 1 + math.random(2)
	denom[i] = 1
	for j = 1,index do
	    if (choice == 2 and qq[j] == 3) then
            denom[i] = denom[i] * 5;
        else			
            denom[i] = denom[i] * qq[j];
		end	
	end 
    enum[i] = 1 + math.random(3*denom[i]);	
    value[i] = enum[i] / denom[i]
end

if (value[2] == value[1]) then
    enum[2] = enum[2] + math.random(9)
	value[2] = enum[2] / denom[2]
end
	
aver = value[2] - value[1]
if (value[2] < value[1]) then
    temp = denom[2]
    denom[2] = denom[1]
    denom[1] = temp
    temp = enum[2]
    enum[2] = enum[1]
    enum[1] = temp
    temp = value[2]
    value[2] = value[1]
    value[1] = temp
    aver = value[2] - value[1]	
end	
denom_av = denom[1] * denom[2]
enum_av = enum[2]*denom[1] - enum[1]*denom[2]

temp = enum[2]*denom[1]
for i = 3,5 do
    enum[i] = temp + (i-2)*enum_av
	denom[i] = denom_av
	value[i] = enum[i]/denom[i]
end	


for i = 1,5 do
	if (choice == 1) then
	    q = lib.math.gcd(enum[i], denom[i])
	    enum[i] = enum[i]/q
	    denom[i] = denom[i]/q
        whl[i] =  math.floor(enum[i]/denom[i])
	    enum_p[i] = enum[i] - denom[i] * whl[i]	
    else	  
        chind = 3
        for j = 1,3 do
            temp = value[i] * 10^(4-j) 
            if (lib.math.round(temp) == temp) then
	            chind = 4-j
	        end	
        end
        out[i] = lib.math.round_dec(value[i], chind)
     end
end	

if (choice == 1) then
    for i = 1,5 do 
        if (i == 1 or i == 5) then	
		    reply[i] = ""
	        if (whl[i] ~= 0) then
                reply[i] = reply[i] .. whl[i]
            end			
		    if (enum_p[i] ~= 0) then		
                reply[i] = reply[i] .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"    		
            end
		else
	        if (whl[i] == 0) then
                condition = "is_ok = math.eq(numerator/denominator, "..tostring(value[i])..");"
                sln = "numerator="..tostring(enum_p[i])..";denominator="..tostring(denom[i])..";"
                reply[i] = lib.check_fraction_condition(condition, nil, nil, sln) 
            else		
		        if (enum_p[i] == 0) then		
                   reply[i] = lib.check_number(whl[i],20) 
	            else
                   condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value[i])..");"
                   sln = "numerator="..tostring(enum_p[i])..";denominator="..tostring(denom[i])..";whole="..tostring(whl[i])..";"
                   reply[i] = lib.check_fraction_condition(condition, true, nil, sln)	 
                end				   
            end
        end			
	end
else
    for i = 1,5 do 
        if (i == 1 or i == 5) then		
            reply[i] = lib.dec_to_str(out[i])
		else
            reply[i] = lib.check_number(out[i], 40)
        end	
    end		 
end
     