array_boja = {"66ff66", "ff9900", "00ccff", "ff99cc"} 
array_table = {0,0,0,0,0,0,0,0,0};
array_table[math.random(6)] = 1;
style_table = {["width"] = 100,
        ["height"] = 40,
        ["ratio"] = 0.3,
	["select"] = false,
	["initial_state"] = array_table, 
        ["color"] = "ff9900",
	["text-align"] = "inline"};

--[[ Table border ]]--
border = {["border-collapse"] = "collapse"};
