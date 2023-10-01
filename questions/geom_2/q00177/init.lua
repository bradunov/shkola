
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
				
line_style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

dig_style = {["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

text_style = {["font_size"] = "14"}		


edge = {"a", "b", "H", "d"} 
numb = {}
meas = {"cm", "cm²"} 
space = "\( \ \ \ \ \) " 

quest = ""

min_range = 2
for i = 1,4 do
    if (i < 4) then
		numb[i] = 2 + math.random(10)	
	    min_range = min_range + numb[i]
	else
		numb[i] = min_range + math.random(10)		    
	end
end   
   
ind = math.random(4)

if (ind < 4) then  
	s = numb[4]^2 
	quest = edge[4] .. " = " .. numb[4] .. meas[1]
	if (ind == 1) then
		s = s - numb[2]^2 - numb[3]^2
		quest = edge[2] .. " = " .. numb[2] .. meas[1] .. "," .. space .. edge[3] .. " = " .. numb[3] .. meas[1] .. "," .. space .. quest
	else
		if (ind == 2) then
			s = s - numb[1]^2 - numb[3]^2
			quest = edge[1] .. " = " .. numb[1] .. meas[1] .. "," .. space .. edge[3] .. " = " .. numb[3] .. meas[1] .. "," .. space .. quest			
		else
			s = s - numb[1]^2 - numb[2]^2
			quest = edge[1] .. " = " .. numb[1] .. meas[1] .. "," .. space .. edge[2] .. " = " .. numb[2] .. meas[1] .. "," .. space .. quest			
		end	
	end
else
	s = numb[1]^2 + numb[2]^2 + numb[3]^2	
	quest = edge[1] .. " = " .. numb[1] .. meas[1] .. "," .. space .. edge[2] .. " = " .. numb[2] .. meas[1] .. "," .. space .. edge[3] .. " = " .. numb[3] .. meas[1]	
end	
numb[ind] = math.sqrt (s)

tmp = math.sqrt (numb[1]^2 + numb[2]^2)
area = lib.math.round_dec(numb[3] * tmp, 1)	
numb[ind] = lib.math.round_dec(numb[ind],1)
   

mycanvas = function(no)

  lib.start_canvas(350, 150, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130

    lib.add_straight_path(ov-2*ow, 2*ow, {{w+ow, 3*ow}, {0, w},{-w-ow, -3*ow}, {0, -w}}, dig_style,  true, false) 
    lib.add_rectangle (v, v-2*ow, ov, w, style, true, false)
    lib.add_straight_path(v, v-2*ow, {{4*ow, -3*ow}, {ov, 0}, {-4*ow, 3*ow}, {-ov, 0}}, style,  false, false)
    lib.add_straight_path(ov+v, v-2*ow, {{4*ow, -3*ow}, {0, w}, {-4*ow, 3*ow}, {0, -w}}, style,  false, false)
    lib.add_rectangle (ov-2*ow, 2*ow, ov, w, line_style, true, false)
    lib.add_straight_path(v, ov, {{4*ow, -3*ow}}, line_style,  false, false) 
    lib.add_straight_path(ov-2*ow, 2*ow, {{w+ow, w+3*ow}}, style,  true, false) 

    lib.add_text(2*v, ov+5, "a", text_style, false, false) 
    lib.add_text(2*ov-3*ow, ov-ow, "b", text_style, false, false) 
	lib.add_text(3*w+7, v-5, "H", text_style, false, false) 
	lib.add_text(2*w, v, "d", text_style, false, false) 
	lib.add_text(2*v, w+2*ow, "P", text_style, false, false)   

  lib.end_canvas()
end