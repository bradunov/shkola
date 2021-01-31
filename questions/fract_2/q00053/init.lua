
style_table = {["width"] = 200,
        ["height"] = 100,
        ["ratio"] = 0.3,
	    ["select"] = false,
	    ["initial_state"] = array_table, 
        ["color"] = "f90"};

--[[ Table border ]]--
border = {["border-collapse"] = "collapse"};

include("names")

rz = math.random(#zensko_ime_nom);
rm = math.random(#musko_ime_nom)
imez = zensko_ime_nom[rz];
imem = musko_ime_nom[rm] 

array_table = {};
imax = 4 + math.random(4)
jmax = 2 + math.random(imax - 4)
enum = 0;
for i=1,imax do
  for j=1,jmax do
    if math.random() > 0.5 then
      array_table[(i-1)*jmax+j] = 1
      enum = enum + 1
    else
      array_table[(i-1)*jmax+j] = 0
    end
   end
end

denom = imax * jmax

imenilac = denom * 2
q = lib.math.gcd(enum, imenilac)
broj = enum / q
imen = imenilac / q
    
style_table["initial_state"] = array_table           
                