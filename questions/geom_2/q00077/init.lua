 
include("terms")
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
sold_style = 
	{["off_color"] = "cc0",
        ["on_color"] = "cc0",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

blue_style = 
	{["off_color"] = "aaf",
        ["on_color"] = "aff",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

brown_style = 
	{["off_color"] = "fc0",
        ["on_color"] = "fc0",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

pink_style = 
	{["off_color"] = "f9c",
        ["on_color"] = "f9c",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

red_style = 
	{["off_color"] = "f00",
        ["on_color"] = "f00",
        ["line_color"] = "fff",
        ["line_width"] = "1"};
		
orange_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

green_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

yelow_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "fff",
        ["line_width"] = "1"};	
	
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};	

line_style = 
	{["off_line_color"] = "fff",
        ["on_line_color"] = "000",
        ["line_width"] = "3"};	
						
text_style = {["font_size"] = "14"}		


            
mycanvas = function(no)

  ow = 5
  w = 125
  ov = 75
  v = 20

 results = ""

  for i = 1, 32 do
      if i > 1 then
         results = results .. " && "
      end
      results = results .. "result[" .. tostring(i-1) .. "] == "
	  if (i > 8 ) then
		  results = results .. "0"
	  else
		  results = results .. "1"
	  end
  end
	
  lib.start_canvas(350, 250, "center", results) 
           
    lib.add_straight_path(2*(v+ow), v+2*ow, {{v, 2*v}, {2*v, 0}, {v, -2*v}, {-4*v, 0} }, brown_style, true, false) 
    lib.add_straight_path(2*ov, v+2*ow, {{-v, 2*v}, {2*v, 0}, {0, -2*v}, {-v, 0} }, green_style, true, false) 
    lib.add_straight_path(2*(w-v), v+2*ow, {{-v, 2*v}, {5*v, 0}, {-2*v, -2*v}, {-2*v, 0} }, orange_style, true, false) 

    lib.add_straight_path(2*(v+ow), ov+3*ow, {{0, 4*v}, {2*v, -v}, {0, -2*v}, {-2*v, -v} }, sold_style, true, false) 
    lib.add_straight_path(w-3*ow, w+v+ow, {{5*v, 0}, {v, -3*v}, {-4*v, 0}, {-2*v, 3*v}}, yelow_style, true, false) 
    lib.add_straight_path(w+ov+2*(v+ow), w+ow, {{2*v, 2*v}, {0, -4*v}, {-2*v, 0}, {0, 2*v}}, pink_style, true, false) 

    lib.add_straight_path(2*(v+ow), 2*w-3*v, {{0, 2*v}, {4*v, 0}, {0, -3*v}, {-4*v, v} }, red_style, true, false)
    lib.add_straight_path(2*(ov+v),  2*ov+v, {{-2*v, 3*v}, {7*v, 0}, {-2*v, -3*v}, {-3*v, 0} }, blue_style, true, false) 

    lib.add_line(2*(v+ow), v+2*ow, 4*v, 0, line_style, false, true)
    lib.add_line(2*ov-v, 3*v+2*ow, 2*v, 0, line_style, false, true)
    lib.add_line(2*w-3*v, 3*v+2*ow, 5*v, 0, line_style, false, true)
    lib.add_line(2*(v+ow), ov+3*ow, 0, 4*v, line_style, false, true)
    lib.add_line(w-3*ow, w+v+ow, 5*v, 0, line_style, false, true)
    lib.add_line(w+2*ov+v-ow, w+ow-2*v, 0, 4*v, line_style, false, true)
    lib.add_line(6*v+2*ow, 2*w-4*v, 0, 3*v, line_style, false, true)
    lib.add_line(2*ov,  2*ov+4*v, 7*v, 0, line_style, false, true)
	
	    lib.add_line(2*(v+ow), v+2*ow, v, 2*v, line_style, false, true)
	    lib.add_line(2*(3*v+ow), v+2*ow, -v, 2*v, line_style, false, true)
	    lib.add_line(2*(v+ow)+v, 3*v+2*ow, 2*v, 0, line_style, false, true)
		
		lib.add_line(2*ov, v+2*ow, -v, 2*v, line_style, false, true)
	    lib.add_line(2*ov, v+2*ow, v, 0, line_style, false, true)
	    lib.add_line(2*ov+v, v+2*ow, 2*v, 0, line_style, false, true)

		lib.add_line(2*(w-v), v+2*ow, -v, 2*v, line_style, false, true)
	    lib.add_line(2*(w-v), v+2*ow, 2*v, 0, line_style, false, true)
	    lib.add_line(2*(w-v)+2*v, v+2*ow, 2*v, 2*v, line_style, false, true)

        lib.add_line(2*(v+ow), ov+3*ow, 2*v,v, line_style, false, true) 
	    lib.add_line(2*(v+ow)+2*v, ov+3*ow+v, 0, 2*v, line_style, false, true) 
		lib.add_line(2*(v+ow), ov+3*ow+4*v, 2*v,-v, line_style, false, true) 

		lib.add_line(w-3*ow, w+v+ow, 2*v, -3*v, line_style, false, true) 
	    lib.add_line(w-3*ow+2*v, w-2*v+ow, 4*v, 0, line_style, false, true) 
		lib.add_line(w-3*ow+5*v, w+v+ow, v, -3*v, line_style, false, true) 

		lib.add_line(w+ov+2*(v+ow), w+ow, 2*v, 2*v, line_style, false, true) 
	    lib.add_line(w+ov+2*(v+ow), w+ow, 0, -2*v, line_style, false, true) 
		lib.add_line(w+ov+2*(v+ow), w+ow-2*v, 2*v, 0, line_style, false, true) 

		lib.add_line(2*(v+ow), 2*w-3*v, 4*v, -v, line_style, false, true) 
	    lib.add_line(2*(v+ow), 2*w-3*v, 0, 2*v, line_style, false, true) 
		lib.add_line(2*(v+ow), 2*w-v, 4*v, 0, line_style, false, true) 

		lib.add_line(2*(ov+v),  2*ov+v, 3*v, 0, line_style, false, true) 
	    lib.add_line(2*(ov+v),  2*ov+v, -2*v, 3*v, line_style, false, true) 
		lib.add_line(2*(ov+v)+3*v,  2*ov+v, 2*v, 3*v, line_style, false, true) 		
		
    lib.add_text(2*(2*v+ow), 2*v+ow, "1", text_style) 
    lib.add_text(8*v, 2*v+ow, "2", text_style)
    lib.add_text(11*v+2*ow, 2*v+ow, "3", text_style) 
    lib.add_text(3*v+2*ow, 6*v, "4", text_style) 
    lib.add_text(9*v, 6*v, "5", text_style) 
    lib.add_text(14*v-2*ow, 6*v, "6", text_style)
    lib.add_text(4*v+2*ow, 10*v, "7", text_style) 	
    lib.add_text(11*v, 10*v, "8", text_style) 
	
    for i = 1,13 do
        lib.add_line(v+2*ow, 2*ow+(i-1)*v, 14*v, 0, grid_style, false, false)
    end
    for i = 1,15 do
        lib.add_line(2*ow+i*v, 2*ow, 0, 12*v, grid_style, false, false)
    end
     
  lib.end_canvas()
end    


        