
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

orange_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "1"};

green_style = 
	{["off_color"] = "3c3",
        ["on_color"] = "3c3",
        ["line_color"] = "000",
        ["line_width"] = "1"};
					
text_style = {["font_size"] = "14"}	

numb = {}
edge = {}
edge[1] = {"OB", "OC"}
edge[2] = {"OA", "OD"}
ang = "α"
meas = "cm"
space = "\( \ \ \ \ \) "

for i = 1,2 do
    numb[i] = {}	
    numb[i][1] = 3 + math.random(7)
    numb[i][2] = numb[i][1] + math.random(7)
end
for j = 1,2 do
    if (numb[1][j] == numb[2][j]) then
	    numb[2][j] = numb[2][j] + math.random(3)
	end
end	

ind = math.random(2)	
ch = math.random(2)
val = numb[ind][3-ch] * numb[3-ind][ch] / numb[3-ind][3-ch]
val = lib.math.round_dec(val, 1)
reply = edge[ind][ch]
quest = edge[3-ind][1] .. " = " .. numb[3-ind][1] .. meas .. "," .. space .. edge[3-ind][2] .. " = " .. numb[3-ind][2] .. meas .. "," .. space .. edge[ind][3-ch] .. " = " .. numb[ind][3-ch] .. meas .. ","  
ans = reply .. " = " .. lib.check_number(val) .. meas	

mycanvas = function(no)

  w = 250
  ov = 150
  v = 40
  ow = 10

  lib.start_canvas(300, 160, "center")

  lib.add_straight_path (3*v-2*ow, ov-v-ow, {{v-2, -2*ow-2}, {v+2*ow+2, 2*v-3}, {-2*(v+ow), -v-ow-5} }, orange_style, true, false)
  lib.add_straight_path (2*(v+ow-2), 2*ow+4, {{v+2, v+ow+4}, {3*v-ow+2, -2*v+ow+4}, {-ov-4, ow+2} }, green_style, true, false)
  lib.add_input(3*(v-ow), 2*v+ow, 50, 30, "α")
  lib.add_input(3*(v-ow), 2*ow, 50, 30,"α")
  lib.add_circle (2*(v+ow-2), 2*ow+4, 2, style, false, false)
  lib.add_text(2*v+5, 2*ow+5, "B", text_style, false, false)
  lib.add_circle (w, ow+2, 2, style, false, false) 
  lib.add_text(w, 2*ow+5, "C", text_style, false, false)
  lib.add_circle (ov-ow-2, 2*v-2, 2, style, false, false) 
  lib.add_text(ov, 2*v, "O", text_style, false, false)
  lib.add_circle (3*v-2*ow, ov-v-ow, 2, style, false, false) 
  lib.add_text(2*v+5, w-ov, "A", text_style, false, false)
  lib.add_circle (ov+v+ow, ov+5, 2, style, false, false) 
  lib.add_text(w-v, ov, "D", text_style, false, false)
    
  lib.end_canvas()
end         