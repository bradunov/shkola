
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
		
letter_style = {["font_size"] = "14"}	

edge = {"p", "q", "a", "b", "h"}
meas = "cm"
space = "\( \ \ \ \ \) " 

numb = {}
quest = ""
ans = ""

numb[1] = 2 + math.random(10)
numb[2] = numb[1] + 2 + math.random(10)
quest = edge[1] .. " = " .. numb[1] .. meas .. ", " .. space .. edge[2] .. " = " .. numb[2] .. meas

numb[3] = math.sqrt((numb[1] + numb[2]) * numb[1])
numb[4] = math.sqrt((numb[1] + numb[2]) * numb[2]) 
numb[5] = math.sqrt(numb[1] * numb[2])
for i = 3,5 do
	numb[i] = lib.math.round_dec(numb[i], 1)
end	
ans = edge[3] .. " = " .. lib.check_number(numb[3]) .. meas .. ", " .. space .. edge[4] .. " = " .. lib.check_number(numb[4]) .. meas .. space .. edge[5] .. " = " .. lib.check_number(numb[5]) .. meas

mycanvas = function(no)

  ow = 8
  w = 200
  ov = 120
  v = 32

lib.start_canvas(260, 140, "center")

  lib.add_straight_path(2*(ow+v)+3, 3*ow-2, {{w-2*v+ow-2, ov-v+2}}, style, true, false)  
  lib.add_straight_path(ov-v-3, 3*ow-2, {{-2*v+ow, ov-v}}, style, true, false)  
  lib.add_straight_path(v-5, ov-ow, {{w, 0}}, style, true, false) 

  lib.add_line(w-ov+6, 3*ow, 0, ov-v, dif_style, false, false)

  lib.add_circle (v-3, ov-ow, 3, dif_style)  
  lib.add_text(v, ov+5, "B", letter_style) 
  lib.add_circle (w+3*ow, ov-ow, 3, dif_style)
  lib.add_text(w+3*ow+3, ov+5, "A", letter_style)
  lib.add_circle (w-ov+5, 3*ow, 3, dif_style)     
  lib.add_text(w-ov+5, ow+3, "C", letter_style) 
  lib.add_circle (w-ov+6, ov-ow, 3, dif_style) 

  lib.add_text(3*v-5, 2*v+ow, "h", letter_style) 
  lib.add_text(2*v-ow+2, ov, "p", letter_style)
  lib.add_text(ov+v-ow-5, ov, "q", letter_style)
  lib.add_text(2*v-ow+2, 2*v-2*ow, "a", letter_style)
  lib.add_text(ov+v-ow-5, 2*v-2*ow, "b", letter_style)
   
  lib.end_canvas()
end      
        