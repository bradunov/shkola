
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
numb = {}
  
ind = math.random(11)
if (ind < 4) then
    if (ind == 1) then
        numb[1] = 8
	    numb[2] = 8
	    numb[3] = 8
	else
		numb[1] = 0
	    numb[2] = 4
	    numb[3] = 0	
    end
else	
	if (ind < 8) then
		numb[1] = 2
		numb[2] = 0
		numb[3] = 2	
	else
		numb[1] = 4
		numb[2] = 4
		numb[3] = 4
    end
end	
	
mycanvas = function()

  lib.start_canvas(180, 150, "center")
  
	ow = 12
	wy = 72

	if (ind ~=3 and ind ~=6 and ind ~=7 and ind ~=11) then    --[[1,2,4,5,8,9,10]]--
		lib.add_straight_path(ow, ow+wy, {{2*wy, 0}}, style,  false, false)
    end
	if (ind ~=3 and ind ~=4 and ind ~=5 and ind ~=10) then   --[[1,2,6,7,8,9,11]]--
		lib.add_straight_path(ow+wy, ow, {{0, 2*wy}}, style,  false, false)
    end  
	if (ind ~=2 and ind ~=5 and ind ~=7 and ind ~=9) then     --[[1,3,4,6,8,10,11]]-- 
		lib.add_straight_path(ow+wy/2, ow, {{wy, 2*wy}}, style,  false, false)
	end  
	if (ind ~=2 and ind ~=4 and ind ~=6 and ind ~=8) then     --[[1,3,5,7,9,10,11]]--
		lib.add_straight_path(ow, ow+3*wy/2, {{2*wy, -wy}}, style,  false, false)
	end 
       
  lib.end_canvas()
end   