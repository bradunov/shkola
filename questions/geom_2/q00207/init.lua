
style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};				
		
line_style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

point_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};		

text_style = {["font_size"] = "16"}		

numb = {}
px = {}
py = {}
numx = {}
numy = {}

meas = {"m", "m²", "m³"} 
dimp = {3, 4, 6}
dim = {8, 8, 12}

ind = math.random(3)

numb[1] = 4 + math.random(11)
numb[2] = 0.5 *(3 + math.random(7))
numb[3] = numb[1] + 0.5 * math.random(6)

area_b = numb[1] * numb[1]
if (ind ~= 2) then
    area_b = 0.25 * area_b * math.sqrt(3)
	if (ind == 3) then
	    area_b = 6 * area_b
	end
end	

if (ind < 3) then
	coef = ind + 2
else
	coef = ind + 3
end	
area1 = coef * numb[1] * numb[2]
tmp = math.sqrt(numb[3]^2 - 0.25*numb[1]^2)
area2 = 0.5 * coef * numb[1] * tmp
area = area_b + area1 + area2
area = lib.math.round_dec(area, 1)
hp = math.sqrt(numb[3]^2 - numb[1]^2/(4-ind))
vol = (numb[2] + hp/3) * area_b
vol = lib.math.round_dec(vol, 1)


mycanvas = function(no)

  lib.start_canvas(260, 140, "center")

	w = 64
	ow = 8
	v = 56
	ov =  104
    rt = 2

	if (ind < 3) then	
		if (ind == 2) then	
			px[1] = ov 
			py[1] = 4*ow	
			px[2] = ov 
			py[2] = ov - ow 		
			px[3] = 3*w 
			py[3] = ov - ow		
			px[4] = 3*w
			py[4] = 4*ow			
			px[5] = 2*ow + w
			py[5] = w 			
			px[6] = 2*ow + w
			py[6] = 2*w			
			px[7] = 3*v 
			py[7] = 2*w			
			px[8] = 3*v	
			py[8] = w			
			lib.add_straight_path(px[1], py[1], {{px[5]-px[1], py[5]-py[1]}, {px[6]-px[5], py[6]-py[5]}, {px[7]-px[6], py[7]-py[6]}, {px[8]-px[7], py[8]-py[7]}, {px[5]-px[8], py[5]-py[8]}}, style,  false, false)
			lib.add_straight_path(px[7], py[7], {{px[3]-px[7], py[3]-py[7]}, {px[4]-px[3], py[4]-py[3]}, {px[8]-px[4], py[8]-py[4]}}, style,  false, false)
			lib.add_straight_path(px[6], py[6], {{px[2]-px[6], py[2]-py[6]}, {px[3]-px[2], py[3]-py[2]}}, line_style,  false, false)
			lib.add_straight_path(px[2], py[2], {{px[1]-px[2], py[1]-py[2]}, {px[4]-px[1], py[4]-py[1]}}, line_style,  false, false)				
		else
			px[1] = ov - ow
			py[1] = 4*ow	
			px[2] = ov - ow
			py[2] = ov - ow 		
			px[3] = 2*ov - ow
			py[3] = ov - ow		
			px[4] = 2*ov - ow
			py[4] = 4*ow			
			px[5] = ov + v
			py[5] = ov+3*ow			
			px[6] = px[5] 
			py[6] = py[5] 			
			px[7] = ov + v
			py[7] = w 
			px[8] = px[7]
			py[8] = py[7]			
			lib.add_straight_path(px[1], py[1], {{px[4]-px[1], py[4]-py[1]}}, line_style,  false, false)
			lib.add_straight_path(px[2], py[2], {{px[3]-px[2], py[3]-py[2]}}, line_style,  false, false)		
			lib.add_straight_path(px[6], py[6], {{px[3]-px[6], py[3]-py[6]}, {px[4]-px[3], py[4]-py[3]}, {px[7]-px[4], py[7]-py[4]}}, style,  false, false)				
			lib.add_straight_path(px[7], py[7], {{px[1]-px[7], py[1]-py[7]}, {px[2]-px[1], py[2]-py[1]}, {px[6]-px[2], py[6]-py[2]}, {px[7]-px[6], py[7]-py[6]}}, style,  false, false)	
		end	
		if (ind == 2) then
			numx[1] = px[1] 
			numy[1] = py[1]		
			numx[2] = px[4]	
			numy[2] = py[4]	
			numx[3] = px[5]
			numy[3] = py[5]			
			numx[4] = px[8]
			numy[4] = py[8]			
			vrhx = 2*(w + ow)	
			vrhy = ow				
		else 
			numx[1] = px[1] 
			numy[1] = py[1]		
			numx[2] = px[4]	
			numy[2] = py[4]	
			numx[3] = px[7]
			numy[3] = py[7] 			
			vrhx = 2*(w + ow)
			vrhy = ow		
		end
		for i = 1, dimp[ind]	do	
			lib.add_straight_path(vrhx, vrhy, {{numx[i]-vrhx, numy[i]-vrhy}}, style,  false, false)		
		end
	else
		px[1] = v + 3*ow 
		py[1] = 3*ow		
		px[2] = v + 3*ow
		py[2] = ov - 3*ow		
		px[3] = 3*v
		py[3] = ov - 2*ow		
		px[4] = 3*v	
		py[4] = 4*ow		
		px[5] = v-ow
		py[5] = w + ow  		
		px[6] = v - ow
		py[6] = 2*w		
		px[7] = 2*w + ow
		py[7] = 2*w+ow  		
		px[8] = 2*w + ow	
		py[8] = w + 2*ow		
		px[9] = 3*ow
		py[9] = v -2*ow
		px[10] = 3*ow
		py[10] = ov - ow		
		px[11] = 3*w 
		py[11] = 2*w - ow
		px[12] = 3*w 
		py[12] = w 		
		lib.add_straight_path (px[5], py[5], {{px[6]-px[5], py[6]-py[5]}, {px[7]-px[6], py[7]-py[6]}, {px[8]-px[7], py[8]-py[7]}, {px[5]-px[8], py[5]-py[8]} }, style, true, false)
		lib.add_straight_path (px[9], py[9], {{px[1]-px[9], py[1]-py[9]}, {px[2]-px[1], py[2]-py[1]}, {px[3]-px[2], py[3]-py[2]}, {px[4]-px[3], py[4]-py[3]}, {px[1]-px[4], py[1]-py[4]} }, line_style, true, false)
		lib.add_straight_path(px[9], py[9], { {px[10]-px[9], py[10]-py[9]}, {px[6]-px[10], py[6]-py[10]} }, style,  false, false) 
		lib.add_straight_path(px[12], py[12], { {px[11]-px[12], py[11]-py[12]}, {px[7]-px[11], py[7]-py[11]}}, style,  false, false) 		
		lib.add_straight_path(px[2], py[2], {{px[10]-px[2], py[10]-py[2]}}, line_style,  false, false)
		lib.add_straight_path(px[5], py[5], {{px[9]-px[5], py[9]-py[5]}}, style,  false, false) 
		lib.add_straight_path(px[11], py[11], {{px[3]-px[11], py[3]-py[11]}}, line_style,  false, false) 				
		lib.add_straight_path(px[8], py[8], {{px[12]-px[8], py[12]-py[8]}}, style,  false, false)	
		lib.add_straight_path(px[4], py[4], {{px[12]-px[4], py[12]-py[4]}}, style,  false, false)	
		vrhx = ov + ow
		vrhy = ow	
		numx[1] = px[1]
		numy[1] = py[1]		
		numx[2] = px[9]
		numy[2] = py[9] 		
		numx[3] = px[5]
		numy[3] = py[5]		
		numx[4] = px[8]
		numy[4] = py[8] 		
		numx[5] = px[12] 
		numy[5] = py[12]		
		numx[6] = px[4]	
		numy[6] = py[4]		
		for i = 1, dimp[ind] do	
			if (i == 1 ) then
				view = line_style
			else
				view = style	
			end	
			lib.add_straight_path(vrhx, vrhy, {{numx[i]-vrhx, numy[i]-vrhy}}, view,  false, false)		
		end
	end
    if (ind == 1) then	
		lib.add_text(2*v, 2*v, "a", text_style, false, false)
		lib.add_text(2*ov, w, "H", text_style, false, false)
		lib.add_text(3*v, ow, "s", text_style, false, false)
	else
	    if (ind == 2) then	
			lib.add_text(3*w, ov+ow, "a", text_style, false, false)
			lib.add_text(w, ov-ow, "H", text_style, false, false)
			lib.add_text(3*v, ow, "s", text_style, false, false)
		else
			lib.add_text(3*ow, 2*v, "a", text_style, false, false)
			lib.add_text(3*w+ow, ov-ow, "H", text_style, false, false)
			lib.add_text(3*v-ow, 2*ow, "s", text_style, false, false)
		end
	end
	
--[[	
	for i = 1,dim[ind] do	
		lib.add_circle (px[i], py[i], rt, point_style, true, false)
		lib.add_text(px[i], py[i]-ow, i, text_style, false, false)
	end		
	lib.add_circle (vrhx, vrhy, rt, point_style, true, false)
]]--
		 
  lib.end_canvas()
   
end     
          
        