
set = {2, 2, 2, 3, 3, 5}
dim = 6
add = 3

brac = {"\(\big ( \)", "\(\big ) \)"}

enum = {}
denom = {}
value = {}
ind = {}
qq = {}
sign = {""}

max = 100            
         
quest = {""}
task = ""
reply1 = ""
reply2 = ""

choice = math.random(dim)
for i = 1,add do
    qq = lib.math.random_shuffle(set)
    index =  math.random(3)
	denom[i] = 1
	for j = 1,index do
	    if (i == choice and qq[j] == 3) then
            denom[i] = denom[i] * 5;
        else			
            denom[i] = denom[i] * qq[j];
		end	
	end 
    enum[i] = max - math.random(2*max - 1);	
    if (enum[i] == 0) then
        enum[i] = - 1 - math.random(10)
    end		
    value[i] = enum[i] / denom[i]
    tmp = math.floor(value[i] * 10)
	rest = value[i] * 10 - tmp
    if (rest == 0) then
        quest[i] = lib.dec_to_str(lib.math.round_dec(value[i], 2))	
	    ind[i] = 1	
    else	    
	    q = lib.math.gcd(enum[i], denom[i])
		enum[i] = enum[i] / q
		denom[i] = denom[i] / q
        value[i] = enum[i]/denom[i]
        if (value[i] > 0) then
            swhole = math.floor(value[i])
        else 
            swhole = math.ceil(value[i])
        end	
        if (swhole == 0) then
            quest[i] = "\(\frac{" .. tostring(math.floor(enum[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	
        else	
            rest = math.abs(enum[i] - swhole*denom[i])	     
	        quest[i] = tostring(swhole) .. "\(\frac{" .. tostring(math.floor(rest)) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	      		   
        end	
		ind[i] = 2	
    end		
end

ch = 1
for i = 1,4 do
    if (ind[i] == 2) then
	    ch = 2
    end
end	

imen = denom[1]
for i =  2,add do
    imen = imen*denom[i]
end	
summ = value[1]
broj = enum[1] * imen / denom[1]

bropt = 1
for i = 2,add do
    oper = math.random(2)	
    if (i > 2) then	
       if (oper == 1) then
	       sign[i-1] = "-"
	       if (bropt == 0) then
	           summ = summ + value[i]
               broj = broj + enum[i] * imen / denom[i]	   
	       else	   
	           summ = summ - value[i]
               broj = broj - enum[i] * imen / denom[i]
           end	   
       else
	       sign[i-1] = "+"
	       if (bropt == 0) then
	           summ = summ - value[i]
               broj = broj - enum[i] * imen / denom[i]	   
	       else	   
	           summ = summ + value[i]
               broj = broj + enum[i] * imen / denom[i]
           end
	   end	
	else
       if (oper == 1) then
	       sign[i-1] = "-"
	       summ = summ - value[i]
           broj = broj - enum[i] * imen / denom[i]
           bropt = 0		   
       else
	       sign[i-1] = "+"
	       summ = summ + value[i]
           broj = broj + enum[i] * imen / denom[i]
	   end	
	end   
end	

task = "(" .. quest[1] .. ") " .. sign[1] .. " " .. brac[1] .. " (" .. quest[2] .. ") " .. sign[2] .. " (" .. quest[3] .. ") " .. brac[2]

tmp = math.floor(summ * 10)
rest = summ * 10 - tmp
if (rest == 0) then
    ch = 1
end		

if (ch == 1) then
    reply1 = lib.check_number(summ, 30)
else
	q = lib.math.gcd(broj, imen)
	broj = broj / q
	imen = imen / q
    result = broj/imen
    if (result == 0) then
	    reply1 = lib.check_number(result,30)
    else
        if (result > 0) then
            swhole = math.floor(result)
        else 
            swhole = math.ceil(result)
        end
        rest = broj - swhole * imen		
        if (swhole ~= 0) then
            reply1 = lib.check_number(swhole,30)
            rest = math.abs (rest)			
        end						
	    if (rest ~= 0) then		
			tmp = rest/imen				
            condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
            sln2 = "numerator="..tostring(rest)..";denominator="..tostring(imen)..";"
            reply2 = lib.check_fraction_condition(condition2, nil, nil, sln2)	
        end
    end		
end		
