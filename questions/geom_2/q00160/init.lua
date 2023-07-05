
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
		
green_style = 
	{["off_color"] = "3c3",
        ["on_color"] = "3c3",
        ["line_color"] = "000",
        ["line_width"] = "1"};
			
letter_style = {["font_size"] = "14"}	

edge = {"AB", "MN"}
meas = {"cm", "cm²"}
space = "\( \ \ \ \ \) " 

numb = {}
quest = ""

for i = 1,2 do
	numb[i] = 4 + math.random(11)
end
area = 0.5 * numb[1] * numb[2]
if (area - math.floor(area) == 0) then
    area = math.floor(area)
else	
	area = lib.math.round_dec(area, 1)
end	
val = numb[1] * numb[2] / (numb[1] + numb[2])
val = lib.math.round_dec(val, 1)

quest = edge[1] .. " = " .. numb[1] .. meas[1] .. ", " .. space .. "P" .. " = " .. area .. meas[2]

mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40

lib.start_canvas(320, 170, "center")

  lib.add_straight_path(2*(ow+v)+3, 3*ow-2, {{ov-ow, ov-v+2}}, style, true, false)    
  lib.add_straight_path(ov-v-3, 2*ow+6, {{-2*v+2*ow-4, ov-3*ow-3}}, style, true, false)
  lib.add_straight_path(v, ov-ow, {{w-v-ow, 0}}, style, true, false) 
  
  lib.add_straight_path (2*v+2, ov-ow, {{0, -2*v+ow}, {2*v-7, 0}, {0, ov-2*v}, {-2*v+7, 0}}, green_style, true, false) 
  lib.add_line(w-ov+6, 3*ow, 0, ov-v, dif_style, false, false)

  lib.add_circle (v+ow-5, ov-ow, 3, dif_style)  
  lib.add_text(v+ow-5, ov+5, "A", letter_style) 
  lib.add_circle (w-ow, ov-ow, 3, dif_style)
  lib.add_text(w-ow, ov+5, "B", letter_style)
  lib.add_circle (w-ov+5, 3*ow, 3, dif_style)     
  lib.add_text(w-ov+5, ow+3, "C", letter_style) 
  lib.add_circle (2*v+2, ov-ow, 3, dif_style)
  lib.add_text(2*v+2, ov+5, "M", letter_style)
  lib.add_circle (ov+5, ov-ow, 3, dif_style)
  lib.add_text(ov+ow, ov+5, "N", letter_style)
  lib.add_circle (2*v+2, 2*v-ow, 3, dif_style)
  lib.add_text(2*v-ow+2, 2*v-2*ow, "Q", letter_style)
  lib.add_circle (ov+5, 2*v-ow, 3, dif_style)
  lib.add_text(ov+2*ow-5, 2*v-2*ow, "P", letter_style)

  lib.end_canvas()
end 
             