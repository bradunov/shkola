array_triangle = {0,0,0,0,0,0};
array_triangle[math.random(6)] = 1;
style_triangle = {["width"] = 100,
        ["height"] = 70,
        ["ratio"] = 0.3,
	["select"] = false,
	["initial_state"] = array_triangle, 
	["color"] = "66ff66"};             

array_circle = {0,0,0,0,0,0};
array_circle[math.random(6)] = 1;
style_circle = {["width"] = 70,
        ["height"] = 100,
        ["ratio"] = 0.3,
	["select"] = false,
	["initial_state"] = array_circle, 
	["color"] = "ff9900"};

array_square = {0,0,0,0,0,0};
array_square[math.random(6)] = 1;
style_square = {["width"] = 100,
        ["height"] = 70,
        ["ratio"] = 0.3,
	["select"] = false,
	["initial_state"] = array_square, 
	["color"] = "00ccff"};


--[[ Table border ]]--
border = {["border-collapse"] = "collapse"};