
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
        ["line_color"] = "none",
        ["line_width"] = "1"};	

dark_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "none",
        ["line_width"] = "0.3"};

text_style = {["font_size"] = "16"}	

 
meas = {"cm", "cm²", "cm³", "g"} 

numb = {}  
px = {}
py = {}
	
dens = 0.01 * (60 + math.random(30))
min_range = 4
max_range = 8

numb[1] = min_range + math.random(max_range)
numb[2] = min_range + math.random(max_range)
numb[3] = math.sqrt(numb[1]^2 + numb[2]^2)	
numb[5] = numb[1]^2 / numb[3]                    --[[ H1 ]]--
numb[6] = numb[2]^2 / numb[3]                    --[[ H2 ]]--
numb[4] = numb[1] * numb[2] / numb[3]             --[[ r ]]--

area = numb[4] * (numb[1] + numb[2]) * 22/7
area = lib.math.round_dec(area,1)
vol = numb[4]^2 * numb[3] * 22/21
mass = vol * dens 
mass = lib.math.round_dec(mass,1)	

mycanvas = function(no)

  lib.start_canvas(240, 130, "center")

	w = 64
	ow = 8
	v = 56
	ov =  104
	rt = 2
	ch = 2     --[[ pozicija cigre 1/2]]--
if (ch == 1) then
	px[1] = w  + ov/2
	py[1] = ow
	px[2] = w
	py[2] = w 
	px[3] = px[2] + ov
	py[3] = py[2] 	
	px[4] = px[2] + ov/2
	py[4] = py[2] 
	px[5] = px[1]
	py[5] = py[2] + v	
	f1 = ov/2
	f2 = 3*ow

	lib.add_straight_path(px[2],py[2], {{px[4]-px[2], py[4]-py[2]}, {px[5]-px[4], py[5]-py[4]},{px[5]-px[2], py[5]-py[2]}}, dig_style,  false, false)
	lib.add_ellipse(px[4], py[4], f1, f2, style,  false, false) 
	lib.add_straight_path(px[2],py[2], {{px[4]-px[2], py[4]-py[2]}, {px[1]-px[4], py[1]-py[4]},{px[2]-px[1], py[2]-py[1]}}, dig_style,  false, false)
	lib.add_straight_path(px[3],py[3], {{px[4]-px[3], py[4]-py[3]}, {px[1]-px[4], py[1]-py[4]},{px[3]-px[1], py[3]-py[1]}}, dark_style,  false, false)
	lib.add_straight_path(px[2]-5,py[2], {{px[1]-px[2]+5, py[1]-py[2]}, {px[3]-px[1]+5, py[3]-py[1]}}, style,  false, false)
	lib.add_straight_path(px[2]-5,py[2], {{px[5]-px[2]+5, py[5]-py[2]}, {px[3]-px[5]+5, py[3]-py[5]}}, style,  false, false)
	lib.add_straight_path(px[1],py[1], {{px[5]-px[1], py[5]-py[1]}}, line_style,  false, false)	
	lib.add_ellipse(px[4], py[4], f1, f2, line_style,  false, false) 
		
	lib.add_text(ov-ow-5, ov, "a", text_style, false, false) 
	lib.add_text(ov-ow-5, 2*ow+5, "b", text_style, false, false) 
	lib.add_text(ov+2*ow, v-ow, "c", text_style, false, false) 
else
	px[1] = 5 * ow
	py[1] = w
	px[2] = w  + ov/2
	py[2] = ow 
	px[3] = px[2]
	py[3] = py[1] + v	
	px[4] = px[2]
	py[4] = py[1] 	
	px[5] = w  + ov
	py[5] = py[1] 
	f1 = 3*ow
	f2 = v

	lib.add_straight_path(px[3],py[3]+2, {{px[5]-px[3], py[5]-py[3]-2}, {px[4]-px[5], py[4]-py[5]}}, dig_style,  false, false) 	
	lib.add_ellipse(px[4], py[4], f1, f2, style,  false, false) 
	lib.add_straight_path(px[3],py[3]+2, {{px[1]-px[3], py[1]-py[3]-2}, {px[4]-px[1], py[4]-py[1]}}, dig_style,  false, false) 	
	lib.add_straight_path(px[2],py[2]-2, {{px[1]-px[2], py[1]-py[2]+2}, {px[4]-px[1], py[4]-py[1]}}, dark_style,  false, false) 
	lib.add_straight_path(px[2],py[2]-2, {{px[1]-px[2], py[1]-py[2]+2}, {px[3]-px[1], py[3]-py[1]+2}}, style,  false, false)
	lib.add_straight_path(px[2],py[2], {{px[3]-px[2], py[3]-py[2]}}, line_style,  false, false)
	lib.add_straight_path(px[2]+5,py[2], {{px[5]-px[2]-5, py[5]-py[2]}, {px[3]-px[5]+5, py[3]-py[5]}}, style,  false, false)
	lib.add_straight_path(px[1],py[1], {{px[5]-px[1], py[5]-py[1]}}, line_style,  false, false)
	lib.add_ellipse(px[4], py[4], f1, f2, line_style,  false, false) 

	lib.add_text(2*w+3*ow, ov-ow, "a", text_style, false, false) 
	lib.add_text(w, ov-ow, "b", text_style, false, false) 
	lib.add_text(ov-ow, v, "c", text_style, false, false) 
end

--[[
	for i = 1,5 do	
		lib.add_circle (px[i], py[i], rt, point_style, true, false)	
		lib.add_text(px[i], py[i]-ow, i, text_style, false, false)	
	end		
]]--
 
  lib.end_canvas()
end            