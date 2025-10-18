
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
red_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f30",
        ["line_width"] = "3"};	

blue_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "0cf",
        ["line_width"] = "2"};			

dim = 16

mycanvas = function()

  lib.start_canvas(300, 230, "center")

    w = math.floor(260/dim) 
    ow = 5
 
	for i = 2,dim+1 do
	 lib.add_line(ow+(i-1)*w, ow, 0, (dim-2)*w, style, false, false)
	end
	for i = 2,dim-2 do
	lib.add_line(ow, ow+(i-1)*w, (dim+1)*w, 0, style, false, false)
	end

	fct = 0.25 * (1 + math.random(11))
	if (fct == 1) then
		fct = 2
	end
	ws = fct*w

    lib.add_straight_path(w+ow, 7*w+ow, {{ws, -2*ws}, {3*ws, 0}, {ws, 2*ws}, {-ws, 2*ws}, {-3*ws, 0}, {-ws, -2*ws}}, blue_style, false, false)
    lib.add_straight_path(w+ow, 7*w+ow, {{w, -2*w}, {3*w, 0}, {w, 2*w}, {-w, 2*w}, {-3*w, 0}, {-w, -2*w}}, red_style, false, false)

  lib.end_canvas()
end     
                   