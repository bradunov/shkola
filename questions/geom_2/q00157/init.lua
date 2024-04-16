
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
		
colour_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "1"};
			
letter_style = {["font_size"] = "14"}	

edge = {"AB", "AC", "BD", "CF"}
meas = "cm"
space = "\( \ \ \ \ \) " 

numb = {}
quest = ""

ind = math.random(2)

numb[2] = 5 + math.random(7)
numb[1] = 2 + math.random(numb[2] - 4)

if (ind == 1) then
	ch1 = 1	
	ch2 = 2
	sol = numb[1] * numb[2] / (numb[1] + numb[2])
else
	ch1 = 3		
	ch2 = 4
	sol = math.sqrt (numb[1] * numb[2])   	
end
quest = edge[ch1] .. " = " .. numb[1] .. meas .. ", " .. space .. edge[ch2] .. " = " .. numb[2] .. meas .. ". "
sol = lib.math.round_dec(sol, 1)


mycanvas = function(no)

  ow = 8
  w = 200
  ov = 120
  v = 32

lib.start_canvas(260, 140, "center")

  lib.add_straight_path(2*(ow+v)+3, 3*ow-2, {{w-2*v+ow-2, ov-v+2}}, style, true, false)  
  lib.add_straight_path(ov-v-3, 2*ow+6, {{-2*v+2*ow-4, ov-3*ow-3}}, style, true, false)  
  lib.add_straight_path(v, ov-ow, {{w-ow, 0}}, style, true, false) 

lib.add_straight_path (v+ow-5, ov-ow, {{v-2, 2*v-ov}, {2*v+7, 0}, {-v+2, ov-2*v}}, colour_style, true, false)  

lib.add_circle (v+ow-5, ov-ow, 3, dif_style)  
  lib.add_text(v+ow-5, ov+5, "A", letter_style) 
lib.add_circle (w-ov+5, 3*ow, 3, dif_style)     
  lib.add_text(w-ov+5, ow+3, "B", letter_style) 
lib.add_circle (w+3*ow, ov-ow, 3, dif_style)
  lib.add_text(w+3*ow, ov+5, "C", letter_style)
lib.add_circle (2*v+3, 2*v-ow, 3, dif_style)
  lib.add_text(2*v-ow, 2*v-ow-5, "D", letter_style)
lib.add_circle (ov+2*ow, 2*v-ow, 3, dif_style)
  lib.add_text(ov+v-ow, 2*v-ow-5, "E", letter_style)
lib.add_circle (ov-2*ow+3, ov-ow, 3, dif_style)  
  lib.add_text(ov-ow-8, ov+5, "F", letter_style) 
  
  lib.end_canvas()
end 
       