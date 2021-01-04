
set = {2, 2, 2, 3, 3, 5}
dim = 6

enum = {}
denom = {}
brojilac = {}
qq = {}

for i = 1,2 do
    qq = lib.math.random_shuffle(set)
    ind = 1 + math.random(3)
	denom[i] = 1
	for j = 1,ind do
        denom[i] = denom[i] * qq[j];
	end	
	max = math.floor(denom[i]/2) 
    enum[i] = math.random(max-1);	  
end	

q = lib.math.gcd(denom[1], denom[2])
imenilac = denom[1] * denom[2] / q

brojilac[1] = enum[1] * denom[2]/q
brojilac[2] = enum[2] * denom[1]/q

ind = math.random(2)
if (ind == 1 or brojilac[1] == brojilac[2]) then
    sign = "+"
	summ = brojilac[1] + brojilac[2]
else 
    sign = "-"
	if (brojilac[1] - brojilac[2] < 0) then
	    temp = brojilac[1]
		brojilac[1] = brojilac[2]
		brojilac[2] = temp
	    temp = enum[1]
		enum[1] = enum[2]
		enum[2] = temp	
	    temp = denom[1]
		denom[1] = denom[2]
		denom[2] = temp	
	end
	summ = brojilac[1] - brojilac[2]	
end

value = summ / imenilac

q = lib.math.gcd(imenilac, summ)

broj = summ / q
imen = imenilac / q
	          
                                  
                  

