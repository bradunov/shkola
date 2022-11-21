 
include("terms") 
 
brac = {"\(\big ( \)", "\(\big ) \)"}

enum = {}
denom = {}
broj = {}
imen = {}
term = {""}
ch = {}
value = {}

--[[koeficijenti i resenje]]--	
max_range = 5

for j = 1,2 do
    imax = 4
	if (j == 2) then
	    imax = 3
	end	
	for i = 1,imax do	    --[[ j=1, i=4   resenje x]]--
		ch[i] = 1 + math.random(2)
		enum[i] = math.random(2*max_range)
        if (i == 2) then
		    enum[i]	= enum[i] - 1	
		end	
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
	brojilac = enum[1] * enum[4] 
	imenilac = denom[1] * denom[4]

    term[j] = ""
		val = enum[1]/denom[1]
    if (val ~= 1) then
		if (ch[1] < 3) then
			term[j] = term[j] .. lib.dec_to_str(lib.math.round_dec(enum[1]/denom[1],1)) 		
		else		
			term[j] = term[j] .. "\(\frac{" .. tostring(enum[1]) .."}{" .. tostring(denom[1]) .. "}\)"
		end	
    end
    term[j] = term[j] .. "x"
	free = ""
	if (enum[2] ~= 0) then
		if (ch[2] < 3) then
			free = lib.dec_to_str(lib.math.round_dec(enum[2]/denom[2],1)) 		
		else		
			free =  "\(\frac{" .. tostring(enum[2]) .."}{" .. tostring(denom[2]) .. "}\)"
		end			
	end	
	ind = math.random(4)
    imenbr = imenilac * denom[2]
	if (ind < 3) then
	    brojbr = brojilac * denom[2] + imenilac * enum[2]
		if (enum[2] ~= 0) then
			term[j] = term[j] .. " + " .. free
		end	
    else
	    brojbr = brojilac * denom[2] - imenilac * enum[2]
		if (enum[2] ~= 0) then
		    if (ind == 3) then
		        term[j] = term[j] .. " - " .. free
            else
		        term[j] = free .. " - " .. term[j] 
				brojbr = - brojbr
            end					
		end		
	end
    imen[j] = imenbr * denom[3]	
	broj[j] = brojbr * enum[3]	
    if (ind == 2) then
	    broj[j] = -broj[j]	
    end	
	value[j] = broj[j]/imen[j]
	coef = ""	
	if (ch[3] < 3) then
		coef = lib.dec_to_str(lib.math.round_dec(enum[3]/denom[3],1)) 		
	else		
		coef =  "\(\frac{" .. tostring(math.floor(enum[3])) .."}{" .. tostring(math.floor(denom[3])) .. "}\)"
	end				
	if (ind == 2) then
		term[j] = "-" .. coef .. brac[1] .. term[j] .. brac[2]
    else
		term[j] = coef .. brac[1] .. term[j] .. brac[2]
    end		
end


max_rang = math.floor(value[2] - value[1])
if (value[1] > value[2]) then
	max_rang = math.floor(value[1] - value[2])
end
corr = 1 + math.random(max_rang + 3)
enum[5] =  broj[2] + imen[2] * corr
denom[5] = imen[2]
enum[6] =  broj[1] + imen[1] * corr
denom[6] = imen[1]

for i = 5,6 do
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
		else
	        ch[i] = 3
        end			
	end		
	if (enum[i] ~= 0) then
		if (enum[i] > 0) then	
		    term[i-4] = term[i-4] .. " + "
			if (ch[i] < 3) then
				term[i-4] = term[i-4] .. lib.dec_to_str(lib.math.round_dec(enum[i]/denom[i],1)) 		
			else		
				term[i-4] = term[i-4] .. "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
			end	  
        else		   
		    term[i-4] = term[i-4] .. " - "	
     		enum_p = math.abs(enum[i])				   
			if (ch[i] < 3) then
				term[i-4] = term[i-4] .. lib.dec_to_str(lib.math.round_dec(enum_p/denom[i],1)) 		
			else		
				term[i-4] = term[i-4] .. "\(\frac{" .. tostring(enum_p) .."}{" .. tostring(denom[i]) .. "}\)"
			end	
		end
    end		
end	

answ1 = ""
answ2 = ""

fct = math.random(6)

if (fct - 2*math.floor(fct/2) ~= 0) then 
    reply = msg[1]
    solut = enum[4]	
else	
    reply = msg[2] 
    solut = enum[4] + 3 - fct	
end	

q = lib.math.gcd(solut, denom[4])
denom[4] = denom[4] / q
solut = solut / q
val = solut/denom[4]
tmp = math.floor(val * 10)
rest = val * 10 - tmp	
if (rest == 0) then	
	answ1 = lib.dec_to_str(lib.math.round_dec(val, 1))
else	
	if (val > 0) then
		whl = math.floor(val)
	else 
		whl = math.ceil(val)
	end
	enum_p = solut - whl * denom[4]
	if (whl ~= 0) then
		answ2 = answ2 .. tostring(whl)  
		enum_p = math.abs(enum_p)
	end
	answ2 = answ2 .. "\(\frac{" .. tostring(math.floor(enum_p)) .. "}{" .. tostring(math.floor(denom[4])) .. "}\)"	
end
	
