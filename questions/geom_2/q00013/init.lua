
dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "3"};

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "0cf",
        ["off_line_color"] = "000",
        ["line_width"] = "3"}; 
		
dot_style = {["font_size"] = "35"}	
text_style = {["font_size"] = "16"}	

name = {"K\(\small_1\)(O\(\small_1\),r)", "K\(\small_2\)(O\(\small_2\),r)", "K\(\small_3\)(O\(\small_3\),r)", "K\(\small_4\)(O\(\small_4\),r)"} 
circ = {"K\(\small_1\)", "K\(\small_2\)", "K\(\small_3\)", "K\(\small_4\)"}  	

ind = math.random(6)

mycanvas = function()
  
if (ind == 1) then
   first = circ[1]
   second = circ[2]   
   simc = "A"
   results = "result[0] == 1 && result[1] == 1 && result[2] == 0 && result[3] == 0 && result[4] == 1 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0" 
end
if (ind == 2) then
   simc = "D"
   first = circ[1]
   second = circ[3]   
   results = "result[0] == 1 && result[1] == 0 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 1 && result[7] == 0 && result[8] == 0 && result[9] == 0" 
end
if (ind == 3) then
   simc = "E"
   first = circ[1]
   second = circ[4]   
   results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 1 && result[9] == 0" 
end
if (ind == 4) then
   simc = "E"
   first = circ[2]
   second = circ[3]   
   results = "result[0] == 0 && result[1] == 1 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 1" 
end
if (ind == 5) then
   simc = "B"
   first = circ[2]
   second = circ[4]   
   results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 1 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 1 && result[8] == 0 && result[9] == 0" 
end
if (ind == 6) then
   simc = "C"
   first = circ[3]
   second = circ[4]   
   results = "result[0] == 0 && result[1] == 0 && result[2] == 1 && result[3] == 1 && result[4] == 0 && result[5] == 1 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0" 
end

  lib.start_canvas(350, 250, "center", results)

  ow = 10
  w = 40
  v = 150

  lib.add_circle(2*w, 2*ow+w, w, dif_style, false, true)
  lib.add_circle(v+2*w, 2*ow+w, w, dif_style, false, true)	
  lib.add_circle(2*w, v+w+ow, w, dif_style, false, true)	  
  lib.add_circle(v+2*w, v+w+ow, w, dif_style, false, true)	

  lib.add_straight_path (2*w, 2*ow+w, {{v, 0}}, line_style, false, true)
  lib.add_straight_path (2*w, v+w+ow, {{v, 0}}, line_style, false, true)
  lib.add_straight_path (2*w, 2*ow+w, {{0, v-ow}}, line_style, false, true)
  lib.add_straight_path (v+2*w, 2*ow+w, {{0, v-ow}}, line_style, false, true)
  lib.add_straight_path (2*w, 2*ow+w, {{v, v-ow}}, line_style, false, true)
  lib.add_straight_path (v+2*w, 2*ow+w, {{-v, v-ow}}, line_style, false, true)

  lib.add_input(0, 0, 50, 30, circ[1])
  lib.add_input(2*(v-2*ow), 0, 50, 30, circ[2])
  lib.add_input(0, v-ow, 50, 30, circ[3])
  lib.add_input(2*(v-2*ow), v-ow, 50, 30, circ[4])  
  
  lib.add_text(v+ow/2, ow+w, ".", dot_style, false, false)
  lib.add_text(v+ow/2, w+5, "A", text_style)
  lib.add_text(v+2*w, 3*w, ".", dot_style, false, false)
  lib.add_text(v+2*w+ow, v-2*ow, "B", text_style)
  lib.add_text(v+ow/2, v+w, ".", dot_style, false, false)
  lib.add_text(v+ow/2, v+w+2*ow, "C", text_style)
  lib.add_text(2*w, 3*w, ".", dot_style, false, false)
  lib.add_text(2*w-ow, v-2*ow, "D", text_style)
  lib.add_text(v+ow/2, 3*w, ".", dot_style, false, false)
  lib.add_text(v+ow/2, 3*w-ow, "E", text_style)
 
  lib.end_canvas()
end        