
style = {["width"] = 200,
        ["height"] = 100,
        ["ratio"] = 0.3,
	["color"] = "c60"};

include("names")

rz = math.random(#zensko_ime_nom);
rm = math.random(#musko_ime_nom)

imez = zensko_ime_nom[rz];
imem = musko_ime_nom[rm] 
imeg = musko_ime_gen[rm]

set = {2, 2, 2, 3}

enum = {}
denom = {}
factor = {}

for i = 1,2 do
    q = lib.math.random_shuffle(set)
    ind = 1 + math.random(3)
	denom[i] = 1
	for j = 1,ind do
        denom[i] = denom[i] * q[j];
	end	
	max = math.floor(denom[i]/2) 
    enum[i] = math.random(max-1);	
	factor[i] = 1
	if(ind ~= 4) then
	   for j = ind+1, 4 do
	       factor[i] = factor[i] * q[j]
       end	
     end	   
end	

boja = enum[1] * factor[1] + enum[2] * factor[2];

sln = ""
for i=0,24 do
  sln = sln.."solution["..i.."]="
  if (i < boja) then
    sln = sln.."1;"
  else
    sln = sln.."0;"
  end
end

brojilac = 24 - boja
imenilac = 24
value = brojilac/imenilac

gcd = lib.math.gcd(imenilac, brojilac)
broj = brojilac/gcd
imen = imenilac/gcd

condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
    
            