
include("terms")

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f90",
		["off_line_color"] = "000",		
        ["line_width"] = "3"};

style2 = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["off_line_color"] = "000",		
        ["line_color"] = "c90",
        ["line_width"] = "3"};

style3 = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["off_line_color"] = "000",		
        ["line_color"] = "6f6",
        ["line_width"] = "3"};

style4 = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["off_line_color"] = "000",		
        ["line_color"] = "0cf",
        ["line_width"] = "3"};
		
ind = math.random(2)		

mycanvas = function(no)

results = ""
for i = 1,7 do 
	index = i - 1
	if (index > 0) then
	  results = results .. "&& "
	end
	results = results .. "result[" .. tostring(index) .. "] == "	  
	if (i < 3 or i == 4) then
		if (ind == 1) then
			results = results .. "1 "
		else
			results = results .. "0 " 
		end
	else		  
		if (ind == 2 ) then 		  
			results = results .. "1 " 	
		else	
			results = results .. "0 " 
		end  
	end		  
end		  
		
  lib.start_canvas(300, 280, "center", results)
  
  lib.add_straight_path(10, 60, {{0, 150}}, style, false, true)
  lib.add_straight_path(70, 50, {{70, 0}, {10, -10}, {10, 10}, {100, 0}}, style, false, true)  
  lib.add_triangle(70, 130, 40, 60, style, false, true) 
  lib.add_curved_path(250, 90, {{50, 0, 20, 50}, {-50, 0, -10, 50}, {40, 20, 20, 50}}, style, false, true)  
  lib.add_ellipse(160, 220, 50, 30, style, false, true)
  lib.add_circle(150, 130, 20, style, false, true)
  lib.add_circle(175, 107, 15, style, false, true)
 
  lib.end_canvas()
end
        