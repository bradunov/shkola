
include("terms")

set = {2, 2, 2, 3, 3, 5}
dim = 6

brac = {"\(\big ( \)", "\(\big ) \)"}
oper = {" - ", " + ", ":", "*"} 

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}
inds = {} 

quest = {""}    
task = ""
reply1 = ""
reply2 = ""

max = 30 

inds[1] = math.random(4);
if (inds[1] < 3) then
    min = 2
else
    min = 0
end	
inds[2] = min + math.random(2)

ch = 1
for i = 1,3 do
    qq = lib.math.random_shuffle(set)
    index = math.random(3)
	denom[i] = 1
	for j = 1,index do
        denom[i] = denom[i] * qq[j];
	end	 
    enum[i] = max - math.random(2*max - 1);	
    if (enum[i] == 0) then
        enum[i] = - 1 - math.random(10)
    end		
    value[i] = enum[i] / denom[i]	
    tmp = math.floor(value[i] * 10)
	rest = value[i] * 10 - tmp	
    if (rest == 0) then
	    numb = lib.math.round_dec(value[i], 1)
        quest[i] = lib.dec_to_str(numb)		
	    if (i == 1) then
            task = task .. " " .. brac[1] .. " (" .. lib.check_number(numb,30) .. ") " .. lib.check_string(oper[inds[i]],10)	
        end		
	    if (i == 2) then
            task = task .. "(" .. lib.check_number(numb,30) .. ") " .. brac[2] .. " " .. lib.check_string(oper[inds[i]],10)
		end	
	    if (i == 3) then
            task = task .. "(" .. lib.check_number(numb,30) .. ") " 
		end			
    else	    
	    q = lib.math.gcd(enum[i], denom[i])
		enum[i] = enum[i] / q
		denom[i] = denom[i] / q
        value[i] = enum[i]/denom[i]
        if (value[i] > 0) then
            whl[i] = math.floor(value[i])
        else 
            whl[i] = math.ceil(value[i])
        end	
        if (whl[i] == 0) then
            quest[i] = "\(\frac{" .. tostring(math.floor(enum[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	
			answ = lib.check_fraction_simple(enum[i], denom[i])
        else
	        enum_p[i] = math.abs(enum[i] - denom[i] * whl[i])			     
	        quest[i] = tostring(whl[i]) .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	      
			answ = lib.check_number(whl[i],20) .. lib.check_fraction_simple(enum_p[i], denom[i])			
        end	
		ch = 2			
	    if (i == 1) then
            task = task .. " " .. brac[1] .. " (" .. answ .. ") " .. lib.check_string(oper[inds[i]],10)	
        end		
	    if (i == 2) then
            task = task .. " (" .. answ .. ") " .. brac[2] .. " " .. lib.check_string(oper[inds[i]],10)
		end	
	    if (i == 3) then
            task = task .. " (" .. answ .. ") " 
		end					
    end			
end   

sign1 = operat1[inds[1]]
if (inds[1] == 1) then 
    term = value[1] - value[2]
end
if (inds[1] == 2) then
    term = value[1] + value[2]	
end	
if (inds[1] == 3) then 
    term = value[1] / value[2]
end
if (inds[1] == 4) then
    term = value[1] * value[2]	
end	

sign2 = operat2a[inds[2]];
temp = math.floor((inds[2]+1)/2)
sign3 = operat1p[temp]
if (inds[2] == 1) then 
    result = term - value[3]
end
if (inds[2] == 2) then 
    result = term + value[3]	
end	
if (inds[2] == 3) then 
    result = term / value[3]
end
if (inds[2] == 4) then 
    result = term * value[3]	
end	

if (ch == 2) then
   tmp = math.floor(result * 10)
   rest = result * 10 - tmp
   if (rest == 0) then
       ch = 1
   end	
end

if (ch == 2) then
    if (inds[1] == 3) then
       imenilac = denom[1] * enum[2] 
	   brojilac = enum[1] * denom[2] 
	else
       imenilac = denom[1] * denom[2]    
       if (inds[1] == 1 ) then
	       brojilac = enum[1] * denom[2] - enum[2] * denom[1]
       end 
       if (inds[1] == 2 ) then	
	       brojilac = enum[1] * denom[2] + enum[2] * denom[1]	
       end
       if (inds[1] == 4 ) then	
	       brojilac = enum[1] * enum[2]	
       end	
	end   
    if (inds[2] == 3) then
       imen_t = imenilac * enum[3] 
	   broj_t = brojilac * denom[3] 
	else
       imen_t = imenilac * denom[3]    
       if (inds[2] == 1 ) then
	       broj_t = brojilac * denom[3] - enum[3] * imenilac
       end 
       if (inds[2] == 2 ) then	
	       broj_t = brojilac * denom[3] + enum[3] * imenilac	
       end
       if (inds[2] == 4 ) then	
	       broj_t = brojilac * enum[3]	
       end
    end	   
    q = lib.math.gcd(imen_t, broj_t)
    broj = broj_t/ q
    imen = imen_t / q
	if (imen < 0) then
	    broj = - broj
		imen = - imen
    end		
    result = broj/imen
    if (result == 0) then
	    reply1 = lib.check_number(result,30)
    else
		if (result > 0) then
            ceo = math.floor(result)
	    else
            ceo = math.ceil(result)	
	    end	
        rest = broj - ceo * imen		
        if (ceo ~= 0) then
            reply1 = lib.check_number(ceo,30)
            rest = math.abs (rest)			
        end						
	    if (rest ~= 0) then		
			tmp = rest/imen				
            condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
            sln2 = "numerator="..tostring(rest)..";denominator="..tostring(imen)..";"
            reply2 = lib.check_fraction_condition(condition2, nil, nil, sln2)	
        end
	end	
else
    reply1 = lib.check_number(lib.math.round_dec(result,1),40)		
end		

                

         
   

