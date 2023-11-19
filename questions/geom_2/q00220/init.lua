
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
        ["line_width"] = "0.3"};	

dark_style = {["off_color"] = "aaf",
        ["on_color"] = "aaf",
        ["line_color"] = "000",
        ["line_width"] = "1"};

text_style = {["font_size"] = "16"}	

edge = {"a", "b", "H", "d", "s", "Q"} 
meas = {"cm", "cm²"} 

numb = {}  
px = {}
py = {}

ch = math.random(2)	

min_range = 5
max_range = 8

numb[1] = min_range + math.random(max_range)
numb[2] = min_range + math.random(max_range)
if (ch == 1) then
	numb[3] = numb[1]
	numb[4] = 2 * numb[2]	
else	
	numb[3] = numb[2]
	numb[4] = 2 * numb[1]	
end	
numb[5] = math.sqrt(numb[1]^2 + numb[2]^2)	
numb[5] = lib.math.round_dec(numb[5],2)
numb[6] = numb[1] * numb[2]	

mycanvas = function(no)

  lib.start_canvas(300, 160, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130
	rt = 2
if (ch == 2) then
	px[1] = w  + ov/2
	py[1] = 2*ow
	px[2] = w
	py[2] = ov-ow 
	px[3] = px[2] + ov
	py[3] = py[2] 	
	px[4] = px[2] + ov/2
	py[4] = py[2] 	
	f1 = ov/2
	f2 = 3*ow
	lib.add_ellipse(px[4], py[4], f1, f2, style,  false, false) 
	lib.add_straight_path(px[3]+2,py[3], {{px[1]-px[3]-2, py[1]-py[3]}, {px[4]-px[1], py[4]-py[1]}}, dig_style,  false, false) 	
	lib.add_straight_path(px[2]-2,py[2], {{px[1]-px[2]+2, py[1]-py[2]}, {px[4]-px[1], py[4]-py[1]}}, dark_style,  false, false) 
	
	lib.add_straight_path(px[2],py[2]-2, {{px[1]-px[2], py[1]-py[2]+2}, {px[3]-px[1], py[3]-py[1]-2}}, style,  false, false)
	lib.add_straight_path(px[2],py[2], {{px[3]-px[2], py[3]-py[2]}}, dig_style,  false, false)
	lib.add_ellipse(px[4], py[4], f1, f2, line_style,  false, false) 

else	
	px[1] = 4 * ow
	py[1] = 2*ow + ov/2
	px[2] = w  + ov/2
	py[2] = 2*ow 
	px[3] = px[2]
	py[3] = py[2] + ov	
	px[4] = px[2]
	py[4] = py[2] + ov/2	
	f1 = 3*ow
	f2 = ov/2	
	lib.add_ellipse(px[4], py[4], f1, f2, style,  false, false) 
	lib.add_straight_path(px[3],py[3]+2, {{px[1]-px[3], py[1]-py[3]-2}, {px[4]-px[1], py[4]-py[1]}}, dig_style,  false, false) 	
	lib.add_straight_path(px[2],py[2]-2, {{px[1]-px[2], py[1]-py[2]+2}, {px[4]-px[1], py[4]-py[1]}}, dark_style,  false, false) 
	lib.add_straight_path(px[2],py[2]-2, {{px[1]-px[2], py[1]-py[2]+2}, {px[3]-px[1], py[3]-py[1]+2}}, style,  false, false)
	lib.add_straight_path(px[2],py[2], {{px[3]-px[2], py[3]-py[2]}}, dig_style,  false, false)
	lib.add_ellipse(px[4], py[4], f1, f2, line_style,  false, false) 
end	

if (ch == 2) then		
	lib.add_text(ov-ow, ov, "a", text_style, false, false) 
	lib.add_text(w+v+5, v, "b", text_style, false, false) 
	lib.add_text(2*(w+ow), w+2*ow, "Q", text_style, false, false)
else
	lib.add_text(w+ow+5, w+ow, "a", text_style, false, false) 
	lib.add_text(2*w-5, 5*ow, "b", text_style, false, false) 
	lib.add_text(ov, ov-ow, "Q", text_style, false, false) 
end	

--[[
	for i = 1,4 do	
		lib.add_circle (px[i], py[i], rt, point_style, true, false)	
		lib.add_text(px[i], py[i]-ow, i, text_style, false, false)	
	end		
]]--
 
  lib.end_canvas()
end                               
      