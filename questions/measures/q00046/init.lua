
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

pen_style = 
	{["off_color"] = "fc8",
        ["on_color"] = "fc8",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
rub_style = 
	{["line_color"] = "000",
        ["line_width"] = "2"};	


ow = 10
v = 40

step = 2*ow

ind_rub = math.random(2) + 1
rubber = ind_rub * step
ind_pen = math.random(3) + 2
pencil = ind_pen * rubber

length = "dužine"
if (ind_pen == 5) then
    length = "dužina"
end	

mycanvas = function(no)

  lib.start_canvas(350, 150, "center")

  lib.add_rectangle(ow, v, pencil-20, 20, pen_style, false, true)
  lib.add_straight_path(ow+pencil-20, v+2*ow, {{20, -10}, {-20, -10}}, pen_style, false, true)

  lib.add_rectangle(ow, 2*(v+ow), rubber, 25, rub_style, true, true)

  lib.end_canvas()
end                
               
               
            
                               
                                                
      
            