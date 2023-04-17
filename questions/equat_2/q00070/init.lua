
numb = 5

enum = {}
denom = {}
ch = {}

coef = {}
	
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
	enum[i+numb] = {}
	denom[i+numb] = {}
	ch[i+numb] = {}
	enum[i+numb][1] = -enum[i][1]
	enum[i+numb][2] = enum[i][2]
	for j=1,2 do	
		denom[i+numb][j] = denom[i][j]
		ch[i+numb][j] = ch[i][j]
	end
	enum[i+2*numb] = {}
	denom[i+2*numb] = {}
	ch[i+2*numb] = {}
	enum[i+2*numb][1] = enum[i][1]
	enum[i+2*numb][2] = -enum[i][2]
	for j=1,2 do
		denom[i+2*numb][j] = denom[i][j]
		ch[i+2*numb][j] = ch[i][j]
	end
end

perm = {}
for i = 1,3*numb do
	perm[i] = i
end
perm = lib.math.random_shuffle(perm)






