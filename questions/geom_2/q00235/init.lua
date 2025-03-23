
orange_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
				

yelow_style = {["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

dark_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "none",
        ["line_width"] = "0.3"};

line_style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

text_style = {["font_size"] = "16"}	

 
meas = {"mm", "cm²", "cm³", "g"} 

numb = {}  
px = {}
py = {}

pi = 22/7	
dens = 0.01 * (60 + math.random(30))
min_range = 15
max_range = 25

numb[1] = min_range + math.random(max_range)
numb[2] = min_range + math.random(max_range)
numb[3] = math.sqrt(numb[1]^2 + numb[2]^2)	

area = pi * numb[1] * (2*numb[1] + numb[3]) / 100
vol = pi * numb[1]^2 * (2*numb[1] + numb[2]) /3000
mass = vol * dens  
area = lib.math.round_dec(area,1)
vol = lib.math.round_dec(vol,1)
mass = lib.math.round_dec(mass,1)	

mycanvas = function(no)

  lib.start_canvas(240, 130, "center")

	w = 64
	ow = 8
	v = 56
	ov =  104
	rt = 2

	px[1] = 5 * ow
	py[1] = w
	px[2] = 2*w
	py[2] = ow 
	px[3] = px[2]
	py[3] = py[1] + v	
	px[4] = px[2]
	py[4] = py[1] 	

	f1 = 3*ow
	f2 = v

	lib.add_circle (px[4], py[4], f2, orange_style, true, false)
	lib.add_ellipse(px[4], py[4], f1, f2, yelow_style,  false, false) 
	lib.add_rectangle (px[1],py[2]-2, px[2]-px[1], py[3]-py[2]+4,  dark_style,  false, false) 
	lib.add_straight_path(px[2],py[2], {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, yelow_style,  false, false)
	lib.add_straight_path(px[2],py[2], {{px[3]-px[2], py[3]-py[2]}}, line_style,  false, false)
	lib.add_straight_path(px[1],py[1], {{px[4]-px[1], py[4]-py[1]}}, line_style,  false, false)
	lib.add_ellipse(px[4], py[4], f1, f2, line_style,  false, false) 

	lib.add_text(2*w+ow, ov-2*ow, "R", text_style, false, false) 
	lib.add_text(ov-ow, v, "H", text_style, false, false) 
	lib.add_circle (px[4], py[4], rt, point_style, true, false)
	
--[[
	for i = 1,4 do	
		lib.add_circle (px[i], py[i], rt, point_style, true, false)	
		lib.add_text(px[i], py[i]-ow, i, text_style, false, false)	
	end		
]]--
 
  lib.end_canvas()
end        
         