
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

dark_style = {["off_color"] = "aaf",
        ["on_color"] = "aaf",
        ["line_color"] = "000",
        ["line_width"] = "1"};

text_style = {["font_size"] = "16"}		


edge = {"a", "b", "H", "d", "Q"} 
meas = {"cm", "cm²", "cm³"} 
space = "\( \ \ \ \ \) " 
numb = {}
px = {}
py = {}
index = {1,2,3,4,5}
out = {}
out = lib.math.random_shuffle(index)

pi = 22/7
quest = ""
ans = ""
       
ind = math.random(2)

numb[1] = 2 + math.random(10)	
numb[2] = 2 + math.random(10)	
if (ind == 1) then
    numb[3] = numb[1]
	numb[4] = 2 * numb[2]
else
    numb[3] = numb[2]
	numb[4] = 2 * numb[1]
end
numb[5] = 2 * numb[1] * numb[2]

check = 0
if (ind == 1) then
	if ((out[1] == 1 and out[2] == 3) or (out[1] == 3 and out[2] == 1)) then
	    check = 1
	else
		if ((out[1] == 2 and out[2] == 4) or (out[1] == 4 and out[2] == 2)) then
			check = 1
		end	
	end	
else
	if ((out[1] == 1 and out[2] == 4) or (out[1] == 4 and out[2] == 1)) then
	    check = 1
	else
		if ((out[1] == 2 and out[2] == 3) or (out[1] == 3 and out[2] == 2)) then
			check = 1
		end	
	end	
end	
if (check == 1) then
	tmp = out[2] 
	out[2] = out[3]	
	out[3] = tmp
end	

quest = edge[out[1]] .. " = "
if (out[1] == 5) then  
	quest = quest .. numb[out[1]] .. meas[2]
else	
	quest = quest .. numb[out[1]] .. meas[1] 
end
quest = quest .. "," .. space .. edge[out[2]] .. " = " 
if (out[2] == 5) then
	quest = quest .. numb[out[2]] .. meas[2]
else
	quest = quest .. numb[out[2]] .. meas[1]	
end

area_b = pi * (0.5 * numb[4])^2
area = area_b + numb[3] * numb[4] * pi
vol = area_b * numb[3]
area = lib.math.round_dec(area, 1)
vol = lib.math.round_dec(vol, 1)

mycanvas = function(no)

  lib.start_canvas(300, 140, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130
	rt = 2
	
	px[1] = w 
	py[1] = 3*ow
	if (ind == 1) then
		px[2] = px[1]
		py[2] = py[1] + 4*ow
        px[3] = px[1] + ov
		py[3] = py[2]		
		f1 = 2*ow
		f2 = w/2
		lib.add_ellipse(px[2], py[2], f1, f2, style,  false, false )
	else
		px[2] = px[1] + ov/2
		py[2] = py[1] 
        px[3] = px[2]
		py[3] = py[2] + w		
		f1 = ov/2
		f2 = 2*ow
		lib.add_ellipse(px[3], py[3], f1, f2, style,  false, false )
    end		
    lib.add_rectangle (px[1], py[1], ov, w, dig_style, true, false)
    if (ind == 1) then
		lib.add_rectangle (px[1], py[1]+w/2, ov, w/2, dark_style, true, false)
	else
		lib.add_rectangle (px[1], py[1], ov/2, w, dark_style, true, false)
	end
	for i = 1,2 do
		if (i == ind) then
			view = line_style
		else
			view = style
		end
		lib.add_ellipse(px[i+1], py[i+1], f1, f2, view,  false, false )
	end
	if (ind == 1) then
		lib.add_straight_path(px[1],py[1], {{ov, 0}}, style,  false, false) 
		lib.add_straight_path(px[1],py[1]+w, {{ov, 0}}, style,  false, false) 
	    lib.add_text(2*v+ow, ov-ow, "a", text_style, false, false) 
		lib.add_text(2*ov-4*ow, w+ow, "b", text_style, false, false) 
		lib.add_text(2*v+ow, v-ow, "H", text_style, false, false) 
		lib.add_text(v, v, "d", text_style, false, false) 
		lib.add_text(w+2*ow, 4*ow, "Q", text_style, false, false)	
	else
		lib.add_straight_path(px[1],py[1], {{0, w}}, style,  false, false) 
		lib.add_straight_path(px[1]+ov,py[1], {{0, w}}, style,  false, false)
		lib.add_text(ov-ow, ov-ow-5, "a", text_style, false, false) 
		lib.add_text(v, v, "b", text_style, false, false) 
		lib.add_text(2*v, 2*ow, "d", text_style, false, false) 
		lib.add_text(2*w, v, "H", text_style, false, false) 
		lib.add_text(ov+v, w+ow, "Q", text_style, false, false)
	end

--[[
	for i = 1,3 do	
		lib.add_circle (px[i], py[i], rt, point_style, true, false)	
		lib.add_text(px[i], py[i]-ow, i, text_style, false, false)	
	end		
]]--
 
  lib.end_canvas()
end            
    