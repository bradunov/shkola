
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
				
line_style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "1"};

blue_style = {["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

yelow_style = {["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

dif_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "none",
        ["line_width"] = "1"};

text_style = {["font_size"] = "16"}		



numb = {}
px = {}
py = {}  

pi = 22/7
min_range = 2
max_range = 8

numb[1] = 6 + math.random(max_range)
numb[2] = min_range + math.random(numb[1] - 2 - min_range)
numb[3] = min_range + math.random(numb[1] - 2 - min_range)
if (numb[2] == numb[3]) then
    numb[2] = numb[2] + 2
end
x1 = math.sqrt(numb[1]^2 - numb[2]^2)
x2 = math.sqrt(numb[1]^2 - numb[3]^2)
ch = math.random(2)
if (ch == 1) then
	numb[4] = math.abs(x1 - x2)
else
	numb[4] = math.abs(x1 + x2)
end	
numb[4] = math.ceil(numb[4])
x1 = (numb[4]^2 + numb[3]^2 - numb[2]^2) / (2*numb[4])
numb[1] = math.sqrt(x1^2 + numb[2]^2)

circ = 2 * numb[1] * pi
circ = lib.math.round_dec(circ,1)
numb[1] = lib.math.round_dec(numb[1],1)

mycanvas = function(no)

  lib.start_canvas(300, 140, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130
	rt = 2
	scal = 0.75

	px[1] = w 
	py[1] = v	
	px[2] = px[1] + ov/2
	py[2] = py[1]
	px[3] = px[1] + ov
	py[3] = py[1]	 
	px[4] = px[1] + ov/2
	py[4] = 3*ow
	px[5] = px[4] 
	py[5] = py[4]+v  		
	f1 = ov/2
	f2 = 2*ow
	lib.add_circle (px[2], py[2], f1, style, true, false)		
	lib.add_ellipse(px[2], py[2], f1, f2, style,  false, false )
	lib.add_straight_path(px[1],py[1], {{ow, -f2-5}, {ov-2*ow, 0}, {ow, f2+5} }, dif_style,  false, false)
	lib.add_ellipse(px[4], py[4]+v, scal*f1+7, scal*f2, blue_style,  false, false )		
	lib.add_ellipse(px[2], py[2], f1, f2, yelow_style,  false, false )		

	lib.add_ellipse(px[4], py[4], scal*f1, scal*f2-5, blue_style,  false, false )


	lib.add_straight_path(px[2],py[2], {{ov/2, 0}}, line_style,  false, false) 
	lib.add_straight_path(px[4],py[4], {{-scal*f1, 0}}, line_style,  false, false)
	lib.add_straight_path(px[5],py[5], {{-scal*f1-7, 0}}, line_style,  false, false)
	lib.add_straight_path(px[5],py[5], {{px[4]-px[5], py[4]-py[5]}}, line_style,  false, false)

	lib.add_input(ov, 5*ow, 50, 30, "H") 
	lib.add_input(ov-3*ow, ow, 50, 30, "r₁") 
	lib.add_input(ov-3*ow, ov-3*ow-3, 50, 30, "r₂") 
	lib.add_input(2*w, v-2*ow, 50, 30, "R") 

	lib.add_circle (px[2], py[2], rt, point_style, true, false)
	lib.add_circle (px[4], py[4], rt, point_style, true, false)
	lib.add_circle (px[5], py[5], rt, point_style, true, false)

  lib.end_canvas()
end            
