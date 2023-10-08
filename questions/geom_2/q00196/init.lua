
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


edge = {"a", "H", "s", "Q", "d"} 
meas = {"cm", "cm²"} 
space = "\( \ \ \ \ \ \ \) " 
numb = {}
area = {}
px = {}
py = {}

quest = ""
ans = ""

min_range = 2
for i = 1,4 do
    if (i < 3) then
		numb[i] = 2 + math.random(10)	
	else
	    if (i == 3) then
			min_range = numb[2] + math.abs(numb[2]-numb[1])
		else
			min_range = numb[1] * numb[3]
        end			
		numb[i] = min_range + math.random(7)		    
	end
end   
numb[5] = 2 * numb[1]
   
ind = math.random(5)
ch = math.random(2)

if (ind < 4) then  
	s = numb[1]^2 
	if (ch == 1) then
		quest = edge[1] .. " = " .. numb[1] .. meas[1] .. "," 
    else
		quest = edge[5] .. " = " .. numb[5] .. meas[1] .. "," 
    end	
	quest = quest .. space .. edge[ind+1] .. " = " .. numb[ind+1]  
else
	quest = edge[2] .. " = " .. numb[2] .. meas[1] .. "," .. space .. edge[ind-1] .. " = " .. numb[ind-1] 
end
if (ind == 3 or ind == 5) then
	quest = quest .. meas[2] .. ","
else
	quest = quest .. meas[1] .. ","
end		
	
if (ind < 3) then
    if (ind == 1) then
		numb[3] = math.sqrt (numb[1]^2 + numb[2]^2)		
    else
		numb[2] = math.sqrt (numb[3]^2 - numb[1]^2)
    end	
	numb[4] = numb[1] * numb[2]	
else
	if (ind == 3 or ind == 5) then
	    if (ind == 3) then		    
			numb[2] = numb[4] / numb[1]
        else
			numb[1] = numb[4] / numb[2]	
        end			
		numb[3] = math.sqrt (numb[1]^2 + numb[2]^2)
	else
		numb[1] = math.sqrt (numb[3]^2 - numb[2]^2)	
		numb[4] = numb[1] * numb[2]			
	end
end
for i = 1,4 do 
	numb[i] = lib.math.round_dec(numb[i],1)	
end	

if (ind < 3) then
    ans = meas[1] .. "," .. space ..edge[4] .. " = " .. lib.check_number(numb[4]) .. meas[2] 
	if (ind == 1) then 
		ans = edge[3] .. " = " .. lib.check_number(numb[3]) .. ans
	else
		ans = edge[2] .. " = " .. lib.check_number(numb[2]) .. ans		
	end 		
else			
	if (ind == 3 or ind == 5) then
		ans = meas[1] .. "," .. space ..edge[3] .. " = " .. lib.check_number(numb[3]) .. meas[1] 
		if (ind == 3) then 
			ans = edge[2] .. " = " .. lib.check_number(numb[2]) .. ans
		else
			ans = edge[1] .. " = " .. lib.check_number(numb[1]) .. ans		
		end 
	else
		ans = edge[1] .. " = " .. lib.check_number(numb[1]) .. meas[1] .. "," .. space ..edge[4] .. " = " .. lib.check_number(numb[4]) .. meas[2] 	
	end
end
  
mycanvas = function(no)

  lib.start_canvas(350, 160, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130	

	px[1] = w 
	py[1] = ov-ow	
	px[2] = ov 
	py[2] = ov+2*ow	
	px[3] = v+ov 
	py[3] = ov+2*ow	
	px[4] = 3*w-ow 
	py[4] = ov
	px[5] = 2*w+2*ow 
	py[5] = w+2*ow
	px[6] = ov-2*ow 
	py[6] = w+2*ow		
	px[7] = ov+2*ow +5
	py[7] = ow
		
	lib.add_straight_path(px[2], py[2], {{px[5]-px[2], py[5]-py[2]}, {px[7]-px[5], py[7]-py[5]}, {px[2]-px[7], py[2]-py[7]}}, dig_style,  false, false) 
	lib.add_straight_path(px[1], py[1], {{px[2]-px[1], py[2]-py[1]}, {px[3]-px[2], py[3]-py[2]}, {px[4]-px[3], py[4]-py[3]}}, style,  false, false) 
	lib.add_straight_path(px[1], py[1], {{px[6]-px[1], py[6]-py[1]}, {px[5]-px[6], py[5]-py[6]}, {px[4]-px[5], py[4]-py[5]}}, line_style,  false, false) 
    for i = 1,6 do
		if (i < 5) then
		    view = style
		else
		    view = line_style
		end
		lib.add_straight_path (px[7], py[7], {{px[i]-px[7], py[i]-py[7]}}, view,  false, false) 	
    end
	lib.add_straight_path (px[7], py[7], {{0, py[1]-py[7]+5}}, dig_style,  false, false) 

    lib.add_text(2*w, ov+2*ow+5, "a", text_style, false, false) 
    lib.add_text(w+ow, ov+ow, "a", text_style, false, false) 
    lib.add_text(3*v+ow, ov+ow+5, "a", text_style, false, false) 
	lib.add_text(2*w+3, v+5, "H", text_style, false, false) 
	lib.add_text(ov-ow-5, v-2*ow, "s", text_style, false, false) 
	lib.add_text(2*(w+ow)-5, w+3*ow+5, "d", text_style, false, false) 
	lib.add_text(2*v+5, ov-ow, "Q", text_style, false, false)   
	
  lib.end_canvas()
end         
            