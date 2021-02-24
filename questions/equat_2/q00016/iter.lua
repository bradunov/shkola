
set = {2, 2, 2, 3, 3, 5, 7}

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}

comp = {">", "<"}
choice = 5 - math.random(4)
max = 20
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
    ind = math.random(2)
	denom[i] = 1
	for j = 1,ind do
	    if (i == choice) then 
		    if (qq[j] == 3 or qq[j] == 7) then
                denom[i] = denom[i] * 5;
			else
                denom[i] = denom[i] * qq[j];
            end				
        else			
            denom[i] = denom[i] * qq[j];	
		end	
	end		
    enum[i] = denom[i] + 5 + math.random(max);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]
	end	
end	

test1 = value[1]/value[2]
test2 = value[2]/value[1]
if (test1 > 3 or test2 > 3) then
    if (value[1] < value[2]) then
	    temp = enum[1]
		enum[1] = enum[2]
		enum[2] = temp
	    temp = denom[1]
		denom[1] = denom[2]
		denom[2] = temp		
	    temp = value[1]
		value[1] = value[2]
		value[2] = temp	
        if (choice == 1) then
            choice = 2
        else
            if (choice == 2) then
                choice = 1
            end
        end
    end		
    index = 1
	nmax = math.floor(value[1] / value[2])
else
    index = 2
	nmax = math.floor(value[1] * value[2])	
end	

if (choice < 3) then
    chind = 3
    for j = 1,3 do
        temp = value[choice] * 10^(4-j) 
        if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
	        chind = 4-j
	    end	
    end
    denom[choice] = 10^chind	    
    enum[choice] = value[choice] * denom[choice]
end

for i = 1,2 do
    q = lib.math.gcd(enum[i], denom[i])
    enum[i] = enum[i] / q
    denom[i] = denom[i] / q
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
end	 

term1 = ""
if (choice == 1) then
    term1 = term1 .. lib.dec_to_str(lib.math.round_dec(value[1],chind))
else     
    if (whl[1] ~= 0) then
        term1 = term1 .. whl[1]
    end
    term1 = term1 .. "\(\frac{" .. math.floor(enum_p[1]) .. "}{" .. math.floor(denom[1]).. "}\)" 	
end	
	
term2 = ""
if (choice == 2) then
    term2 = term2 .. lib.dec_to_str(lib.math.round_dec(value[2],chind))
else 
    if (whl[2] ~= 0) then
        term2 = term2 .. whl[2]
    end
    term2 = term2 .. "\(\frac{" .. math.floor(enum_p[2]) .. "}{" .. math.floor(denom[2]).. "}\)" 	
end	

neq = ""
if (index == 1) then	
    neq = term1 .. " : n " .. comp[1] .. term2	
else
    neq = "n : " .. term1 .. " " .. comp[2] .. term2
end

stampa = 5	
reply = "n " .. "\(\in\) {" .. lib.check_number(1,15)
if (nmax > 1) then
    if (nmax <= stampa) then
        for i = 2, nmax do
	        reply = reply .. ", " .. lib.check_number(i,15) 
        end		
    else
	    reply = reply .. ", " .. lib.check_number(2,15) .. ", ... "  	
        for i = 1, 2 do
	        out = nmax - 2 + i
	        reply = reply .. ", " .. lib.check_number(out,15) 
        end		
	end	
end
reply = reply .. "}"
 

	
  	
      