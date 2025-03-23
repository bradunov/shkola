
style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "16"}	

meas = {"°", "'"}

numb = {}
ang_g = {}
ang_m = {}
index = {}
fact = {}
qq = {}

answ = {}

index = {3, 4, 5, 5, 6, 8, 10}
fact = {1, 1, 1, 2, 1, 3, 3}
dim  = 7

numb = {"α", "β", "γ", "δ"}

dat = ""
ind = math.random(2)
if (ind == 1) then
    sign = math.random(3)
    angle_g = 60 +(2 - sign) * math.random(9)
    angle_m = 2 * (math.random(30) - 1)
	angle = angle_g * 60 + angle_m
    if (angle_g ~= 0) then
        dat= dat .. angle_g .. meas[1]
    end	
    if (angle_m ~= 0) then
        dat = dat .. " " .. angle_m .. meas[2]
    end	
else
    sign = math.random(dim)
    tmp = math.floor(10800/index[sign])
    angle = tmp * fact[sign]
	enum = index[sign] - fact[sign]
	denom = fact[sign]
	factor = math.floor(enum/denom)
    rest = enum - factor * denom
	if (rest == 0) then
        dat = factor 
	else
        dat = "\(\frac{" .. enum .. "}{" .. denom .. "}\)"
    end		
end

if (ind == 1) then
    temp = 90 * 60 - math.floor(angle/2) 
    ang_g[1] = math.floor(temp/60) 
    ang_m[1] = temp - 60 * ang_g[1]   
    ang_g[2] = math.floor((angle + temp)/60)
    ang_m[2] = angle + temp - 60 * ang_g[2] 
else
    ang_g[1] = math.floor(angle/60) 
    ang_m[1] = angle - 60 * ang_g[1]
    temp = tmp * (index[sign] - fact[sign])	
    ang_g[2] = math.floor(temp/60)
    ang_m[2] = temp - 60 * ang_g[2] 
end
ang_g[3] = ang_g[1] 
ang_m[3] = ang_m[1] 
ang_g[4] = ang_g[2] 
ang_m[4] = ang_m[2] 

for i = 1,4 do
    answ[i] = ""
    if (ang_g[i] ~= 0) then
        answ[i] = answ[i] .. lib.check_number(ang_g[i],30) .. meas[1] .. " "
    end	
    if (ang_m[i] ~= 0) then
        answ[i] = answ[i] .. lib.check_number(ang_m[i],20) .. meas[2] .. " "
    end	
end	


mycanvas = function(no)

  lib.start_canvas(220, 130, "center")
  
    ow = 10
    w = 120
    ov = 100
    v = 30
  
    lib.add_straight_path(2*v, 2*ow, {{w, 0}, {-2*v+ow, ov-2*ow}, {-w, 0}, {2*v-ow, -ov+2*ow}}, style, true, false) 
   
    lib.add_text(ow, ov+ow, "A", text_style)   
    lib.add_text(ow+w, ov+ow, "B", text_style)   
    lib.add_text(2*v+w, ow, "C", text_style)
    lib.add_text(2*v, ow, "D", text_style)
  
    lib.add_text(2*ow+5, ov-ow, numb[1], text_style) 
    lib.add_text(w, ov-ow, numb[2], text_style)   
    lib.add_text(2*v+w-2*ow, 3*ow, numb[3], text_style)
    lib.add_text(2*v+5, 3*ow, numb[4], text_style)  
 
  lib.end_canvas()
end  
