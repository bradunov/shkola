
set = {2, 2, 2, 3, 3, 5, 7}
dim = 7

enum = {}
denom = {}
qq = {}
brojilac = {}

qq = lib.math.random_shuffle(set)
index = 1 + math.random(4)
imenilac = 1
for j = 1,index do
    imenilac = imenilac * qq[j];
end	 

    max = math.floor(imenilac/3)
for i = 1,2 do
    brojilac[i] = math.random(max)
end	       
if (brojilac[2]- 2* math.floor(brojilac[2]/2) ~= 0) then 
    brojilac[2] = brojilac[2] + 1
end	
brojilac[3] = brojilac[2]/2	
brojilac[4] = imenilac
for i = 1,3 do
     brojilac[4] = brojilac[4] - brojilac[i]
end	 
    
for i = 1,4 do
    q = lib.math.gcd(brojilac[i], imenilac)
    enum[i] = brojilac[i]/ q
    denom[i] = imenilac / q
end
