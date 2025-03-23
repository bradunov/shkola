
include("terms")

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
        ["line_width"] = "2"};	
		
text_style = {["font_size"] = "14"}		


edge = {"r", "H", "s", "Ob", "Oq", "Q"} 
meas = {"cm", "cm²", "cm³"} 
space = "\( \ \ \ \ \) " 

numb = {}  
fct = {}
px = {}
py = {}

ind = math.random(6)	

r2 = math.sqrt(2)
r3 = math.sqrt(3)
min_range = 2
max_range = 8
numb[1] = min_range + math.random(max_range)
fct[1] =  1
fct[4] =  44 / 7
ch = math.random(3)
if (ch == 1) then
	fct[2] = r3
	fct[3] = 2 	
	fct[5] = 6 	
	fct[6] = r3	
else	
	if (ch == 3) then
		fct[2] = 1 / r3
		fct[3] = 2 / r3	
		fct[5] = 2 * (1 + 2/r3)	
		fct[6] = 1 / r3		
	else
		fct[2] = 1 
		fct[3] = r2	
		fct[5] = 2 * (1 + r2)	
		fct[6] = 1 		
	end
end	
for i = 2,6 do
	numb[i] = fct[i] * numb[1]
end
numb[6] = numb[6] * numb[1]	

if (ind > 1) then
	numb[ind] = math.ceil(numb[ind])
	if (ind < 6) then
		numb[1] = numb[ind] / fct[ind]
    else
		numb[1] = math.sqrt(numb[ind] / fct[ind])
    end
	for i = 2,6 do
		if (i ~= ind) then
			numb[i] = fct[i] * numb[1]
		end
	end	
	if (ind ~= 6) then	
		numb[6] = numb[6] * numb[1]	
	end
end

quest = elem[ind] .. space .. edge[ind] .. " = " .. numb[ind]
if (ind == 6) then
    quest = quest .. meas[2]
else
    quest = quest .. meas[1]
end	

area = numb[1] * (numb[1]+numb[3]) * 22/7
vol = numb[1]^2 * numb[2] * 22/21
area = lib.math.round_dec(area,1)
vol = lib.math.round_dec(vol,1)		
  
mycanvas = function(no)

  lib.start_canvas(240, 130, "center")

	w = 64
	ow = 8
	v = 56
	ov =  104
	rt = 2

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
	lib.add_straight_path(px[3]+2,py[3], {{px[1]-px[3]-2, py[1]-py[3]}, {px[2]-px[1]-2, py[2]-py[1]}}, dig_style,  false, false) 
	lib.add_straight_path(px[2],py[2], {{px[3]-px[2], py[3]-py[2]}}, line_style,  false, false)
	lib.add_straight_path(px[1],py[1], {{px[4]-px[1], py[4]-py[1]}}, line_style,  false, false)
	lib.add_ellipse(px[4], py[4], f1, f2, line_style,  false, false) 

	lib.add_text(ov-ow, ov, "r", text_style, false, false) 
	lib.add_text(w+ow+5, v, "s", text_style, false, false) 
	lib.add_text(w+v+5, v, "H", text_style, false, false) 

--[[
	for i = 1,4 do	
		lib.add_circle (px[i], py[i], rt, point_style, true, false)	
		lib.add_text(px[i], py[i]-ow, i, text_style, false, false)	
	end		
]]--
 
  lib.end_canvas()
end                        
     