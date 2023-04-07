
numb = 5

fun = {""}
enum = {}
denom = {}
ch = {}

imp = {""}
coef ={}


max_range = 5 
 
for i = 1,numb do
	enum[i] = {}
	denom[i] = {}
	ch[i] = {}
	for j = 1,2 do	   
		ch[i][j] = math.random(2) - 1
		enum[i][j] = max_range - math.random(2*max_range)
		if (j == 1 and enum[i][j] == 0) then
			enum[i][j] = math.random(max_range)
		end		
		if (ch[i][j] == 0) then
			denom[i][j] = 1 
		else
			denom[i][j] = 1 + math.random(max_range)
			qq = lib.math.gcd(enum[i][j], denom[i][j])
			enum[i][j] = math.floor(enum[i][j]/qq)
			denom[i][j] = math.floor(denom[i][j]/qq)
			if (denom[i][j] == 1) then
			    ch[i][j] = 0
			else
				tmp = enum[i][j]/denom[i][j]
				rest = 10*tmp - math.floor(10*tmp)				
				if (rest == 0) then
					enum[i][j] = 10 * tmp
					denom[i][j] = 10
					ch[i][j] = 1
				else
					ch[i][j] = 2			
				end	
            end				
		end
	end
 end
  
for i = 1,numb do	
  	fun[i] = ""
	if (enum[i][1] < 0 and enum[i][2] > 0) then
		op = 2
	else
		op = 1
    end		
	termx = "x"
	sgx = ""				
	if (enum[i][1] < 0) then
		sgx = " - "	
	end
	if (math.abs(enum[i][1]/denom[i][1]) ~= 1) then
		tmp = math.abs(enum[i][1])	
		if (ch[i][1] < 2) then
			termx = lib.dec_to_str(lib.math.round_dec(tmp/denom[i][1],1)) .. termx 
		else
			if (tmp == 1) then
				termx = "\(\frac{" .. termx .. "}{" .. tostring(denom[i][1]) .. "}\)"  		
			else		
				termx = "\(\frac{" .. tostring(tmp) .. "}{" .. tostring(denom[i][1]) .. "}\)" .. termx 	
			end			
		end
	end
	termf = ""
	sgf = ""
    if (enum[i][2] ~= 0) then	
		if (enum[i][2] < 0) then
			sgf = " - "	
		else
			if (op == 1) then
				sgf = " + "
			end
		end
		tmp = math.abs(enum[i][2])	
		if (ch[i][2] < 2) then
			termf = lib.dec_to_str(lib.math.round_dec(tmp/denom[i][2],1)) .. termf 
		else
			termf = "\(\frac{" .. tostring(tmp) .. "}{" .. tostring(denom[i][2]) .. "}\)" .. termf 					
		end
	end	
	if (op == 2) then
		fun[i] = sgf .. termf .. sgx .. termx
	else
		fun[i] = sgx .. termx .. sgf .. termf	
	end	
end	

for i = 1,numb do	
  	imp[i] = ""
	coef[i] = {}
    coef[i][1] = enum[i][1] * denom[i][2]
    coef[i][2] = -denom[i][1] * denom[i][2]	
    coef[i][3] = enum[i][2] * denom[i][1]	
	if (coef[i][1] < 0) then
	    for j = 1,3 do
			coef[i][j] = -coef[i][j]
		end	
	end	
	q1 = lib.math.gcd(coef[i][1], coef[i][2])
	q2 = lib.math.gcd(coef[i][2], coef[i][3])
	qq = lib.math.gcd(q1, q2)
	for j = 1,3 do
		coef[i][j] = math.floor(coef[i][j]/qq)
	end	
	imp[i] = lib.check_number(coef[i][1],20) .. lib.check_string("x",15)	
	if (coef[i][2] < 0) then
	    imp[i] = imp[i] .. lib.check_string("-",10)
    else	
	    imp[i] = imp[i] .. lib.check_string("+",10)	
	end
	imp[i] = imp[i] .. lib.check_number(math.abs(coef[i][2]),20) .. lib.check_string("y",15)	
    if (coef[i][3] ~= 0) then	
		if (coef[i][3] < 0) then
			imp[i] = imp[i] .. lib.check_string("-",10)
		else
			imp[i] = imp[i] .. lib.check_string("+",10)			
		end
		imp[i] = imp[i] .. lib.check_number(math.abs(coef[i][3]),20)
	end
end	
            