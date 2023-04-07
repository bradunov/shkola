
include("terms")

numb = 4
stampa = 5

fun = {""}
enum = {}
denom = {}
ch = {}
ind = {}
index = {}
out = {}
graph = {}

for i = 1, 2*numb do
    index[i] = i
end	
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
	
  	fun[i+numb] = ""
	enum[i+numb] = {}	
	denom[i+numb] = {}	
	enum[i+numb][1] = enum[i][1] 
	denom[i+numb][1] = denom[i][1]	
	if (enum[i][2] == 0) then
		enum[i+numb][1] = -enum[i][1] 
		sgx = ""
		sgf = ""
		if (enum[i][1] > 0) then
            sgx = " - "	
        end
    else			
		if (enum[i][1]*enum[i][2] < 0) then		
			if (enum[i][1] < 0) then
				sgx = " - "
				sgf = " - "
			else
				sgx = ""
				sgf = " + "			
			end	
		else	
			enum[i+numb][1] = -enum[i][1] 		
			if (enum[i][2] < 0) then
				sgx = ""
				sgf = " - "
			else			
				sgx = " - "
				sgf = " + "			
			end	
		end
	end	
	fun[i+numb] = sgx .. termx .. sgf .. termf		
end	

for i = 1,2*numb do
	if (enum[i][1] < 0) then
	    ind[i] = answ[2]
	else
	    ind[i] = answ[1]
	end	
end

out = lib.math.random_shuffle(index)

for i = 1,stampa do
	nr = 0
	par = 0
	for j = 1,stampa do 
	    if (out[j] ~= out[i]) then
		    if ((enum[out[i]][1]/denom[out[i]][1]) == (enum[out[j]][1]/denom[out[j]][1])) then
				nr = nr+1
				if (nr == 1) then	
				    par = j
				else
					par = 10 * par + j
				end
			end
		end		
	end
	graph[i] = par	
end	
