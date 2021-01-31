
style = {["width"] = 200,
        ["height"] = 100,
        ["ratio"] = 0.3,
	["color"] = "c60"};


set = {8, 6}

enum = {}
denom = {}
factor = {}

for i = 1,2 do
	denom[i] = set[i]
    enum[i] = math.random(denom[i]-1);	
end	

boja = enum[1] * enum[2];

sln = ""
for i=0,48 do
  sln = sln.."solution["..i.."]="
  if (i < boja) then
    sln = sln.."1;"
  else
    sln = sln.."0;"
  end
end


imenilac = denom[1] * denom[2]
value = boja/imenilac

g = lib.math.gcd(imenilac, boja)
broj = boja/g
imen = imenilac/g

condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
    
for i = 1,2 do
    g = lib.math.gcd(denom[i], enum[i])
    enum[i] = enum[i] /g
    denom[i] = denom[i]/g	
end	