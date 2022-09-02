
array_boja = {"66ff66", "ff9900", "00ccff", "ff99cc"} 
array_table = {}
fct = 1 + math.random(4)
for i = 1,4*fct do
    array_table[i] = 0;
end	
style_table = {["width"] = 200,
        ["height"] = 40,
        ["ratio"] = 0.3,
	["select"] = false,
	["initial_state"] = array_table, 
        ["color"] = "ff9900",
	["text-align"] = "inline"};

--[[ Table border ]]--
border = {["border-collapse"] = "collapse"};
     