
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
dif_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};		
		
line_style = 
	{["line_color"] = "000",
     ["line_width"] = "0.5"};			
		
text_style = {["font_size"] = "14"}		

meas = {"cm", "cm²"}

edge = {}
name_edge = {"PQ", "PS", "FG"}

edge[2] = 2 + math.random(5)
edge[1] = edge[2] + math.random(5)
edge[3] = 1 + math.random(edge[2]-1)

area = 0.5 * edge[1] * (edge[2] + edge[3])

mycanvas = function(no)

  ow = 10
  v = 40
  w = 200
  ov = 60

  lib.start_canvas(260, 170, "center")
     lib.add_rectangle (2*ow, ow+ov, w, 2*v, style, true, false)
     lib.add_straight_path(2*ow, ow+ov, {{2*v,-v}, {w-2*v, v}, {-w, 0}}, style, true, false)    
     lib.add_straight_path(2*ow, ow+ov, {{3*v, 2*v}, {w-3*v, -2*v}, {-w, 0}}, dif_style, true, false)
     lib.add_line(2*ow+2*v, ow+ov, 0, -v, line_style, true, false)

     lib.add_text(ow, w-v, "P", text_style) 
     lib.add_text(3*ow+w, w-v, "Q", text_style)
     lib.add_text(3*ow+w, ow+ov, "R", text_style)
     lib.add_text(ow, ow+ov, "S", text_style)
     lib.add_text(2*ow+3*v, w-v, "T", text_style)
     lib.add_text(ow+2*v, ov, "F", text_style)
     lib.add_text(ow+2*v, 2*ow, "G", text_style)	 

  lib.end_canvas()
end     
    