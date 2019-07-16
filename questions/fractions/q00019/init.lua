style = {["width"] = 150,
        ["height"] = 50,
        ["ratio"] = 0.3,
	["color"] = "ff99cc"};


array_enum = {}
array_denom = {}
array_value = {}
array_boja = {}


for i=1, 3 do
    factor = math.random(3);
    imenilac = 3 * factor;
    brojilac = i;
    boja = brojilac * 6/factor;

    array_boja[i] = boja;
    array_enum[i] = brojilac;
    array_denom[i] = imenilac;
    array_value[i] = brojilac / imenilac;
end


indices = lib.math.argsort(array_value);
