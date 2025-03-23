
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f90",
        ["line_width"] = "2"};	
dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};		
		
text_style = {["font_size"] = "14"}		

meas = {"m", "dm", "cm"}
meas2 = {"m²", "dm²", "cm²"}
area = {}
edge = {}
name_edge = {"AE", "CH"}
name_area = {"ABCD", "AED", "EBCD"}


ed2 = 3 + math.random(14)
edge[1] = 2 * ed2
edge[2] = 3 + math.random(edge[1] - 5)

area[2] = ed2 * edge[2]
area[3] = 3 * ed2 * edge[2]
area[1] = area[2] + area[3]

unit = math.random(3)
ind = math.random(2)
ch = math.random(3)

if (ch == 1) then
    q1 = 2
    q2 = 3
else
    if (ch == 2) then
        q1 = 1
        q2 = 3	
    else
	    q1 = 1
		q2 = 2
	end
end	

mycanvas = function(no)

  ow = 10
  v = 30
  w = 6*v
  ov = 150

  lib.start_canvas(300, 120, "center")
     lib.add_straight_path(2*v+w, v, {{0, 2*v}, {-v, 0} }, dif_style, true, false)    
     lib.add_straight_path(2*v, v, {{w, 0}, {-v, 2*v}, {-w, 0}, {v, -2*v}}, style, true, false)    
     lib.add_straight_path(2*v, v, {{2*v, 2*v}}, style, true, false)

     lib.add_text(v, 3*v+ow, "A", text_style) 
     lib.add_text(w+v, 3*v+ow, "B", text_style)
     lib.add_text(w+2*v, 2*ow, "C", text_style)
     lib.add_text(2*v, 2*ow, "D", text_style)
     lib.add_text(4*v, 3*v+ow, "E", text_style)
     lib.add_text(2*v+w, 3*v+ow, "H", text_style)

  lib.end_canvas()
end     
  