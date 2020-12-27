include("terms")

rect_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
		
line_style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};	

text_style = {["font_size"] = "16"}		

ind_name = math.random(2)
ind = ind_name - 1

knot = {"A", "B", "C", "D", "E", "F", "G", "H"}
ind_knot = math.random(8)

edge = {"AB", "BC", "CD", "AD", "EF", "FG", "GH", "EH", "BF", "CG", "DH", "AE"}
ind_edge = math.random(12)

side = {"ABCD", "ABFE", "EFGH", "GHDC", "AEHD", "BFGC"}
ind_side = math.random(6)



ow = 10
v = 70
ov = 100


mycanvas = function(no)

  lib.start_canvas(350, 140, "center")

  if (ind_name == 2) then  
     lib.add_straight_path(2*(ov-ow)+v, ov+2*ow, {{4*ow, -2*ow}, {0, -v}, {-(ov+ow), 0}, {-4*ow, 2*ow}}, rect_style,  false, false)
     lib.add_straight_path(2*(ov-ow)+v, ov/2, {{4*ow, -2*ow}}, rect_style,  false, false) 
     lib.add_rectangle (2*v, ov/2, ov+ow, v, rect_style, true, false) 
     lib.add_straight_path(2*v, ov+2*ow, {{4*ow, -2*ow}}, line_style,  false, false) 
     lib.add_rectangle (ov+ow+v, 3*ow, ov+ow, v, line_style, true, false)

     lib.add_text(2*v, ov+3*ow, "A", text_style, false, false) 
     lib.add_text(2*(ov-ow)+v, ov+3*ow, "B", text_style, false, false) 
     lib.add_text(2*(ov-ow)+v, 4*ow, "C", text_style, false, false)    
     lib.add_text(2*v, 4*ow, "D", text_style, false, false)
     lib.add_text(ov+ow+v, ov+ow, "E", text_style, false, false) 
     lib.add_text(2*(ov+ow)+v, ov+ow, "F", text_style, false, false) 
     lib.add_text(2*(ov+ow)+v, 2*ow, "G", text_style, false, false)    
     lib.add_text(ov+ow+v, 2*ow, "H", text_style, false, false)
  else  
     lib.add_straight_path(3*v, ov+2*ow, {{4*ow, -2*ow}, {0, -v}, {-v, 0}, {-4*ow, 2*ow}}, rect_style,  false, false)
     lib.add_straight_path(3*v, ov/2, {{4*ow, -2*ow}}, rect_style,  false, false) 
     lib.add_rectangle (2*v, ov/2, v, v, rect_style, true, false) 
     lib.add_straight_path(2*v, ov+2*ow, {{4*ow, -2*ow}}, line_style,  false, false) 
     lib.add_rectangle (ov+ow+v, 3*ow, v, v, line_style, true, false)

     lib.add_text(2*v, ov+3*ow, "A", text_style, false, false) 
     lib.add_text(3*v, ov+3*ow, "B", text_style, false, false) 
     lib.add_text(3*v, 4*ow, "C", text_style, false, false)    
     lib.add_text(2*v, 4*ow, "D", text_style, false, false)
     lib.add_text(ov+ow+v, ov+ow, "E", text_style, false, false) 
     lib.add_text(2*(ov-ow)+v, ov+ow, "F", text_style, false, false) 
     lib.add_text(2*(ov-ow)+v, 2*ow, "G", text_style, false, false)    
     lib.add_text(ov+ow+v, 2*ow, "H", text_style, false, false)
  end
 
  lib.add_input(ow, v-ow, 80, 30, lib.check_string(name[ind_name], 50))	
  lib.end_canvas()
end
            