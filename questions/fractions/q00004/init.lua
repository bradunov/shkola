
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};											

red_style =  
	{["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
blue_style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};			
						
				
text_style = {["font_size"] = "16"}	

index = {}
out = {}
stampa = math.random(6)

for i = 1,12 do
	index[i] = i
end
index = lib.math.random_shuffle(index)

for i = 1,12 do
    if (i > stampa) then	   
		out[i] = 0
	else
		out[i] = index[i]
	end
end	
enum = stampa 
denom = 12
qq = lib.math.gcd(enum, denom)
enum = enum/qq
denom = denom/qq

dif = math.random(11 - stampa)
broj = stampa + dif
imen = 12
qq = lib.math.gcd(broj, imen)
broj = broj/qq
imen = imen/qq



mycanvas = function(no)

  lib.start_canvas(260, 210, "center") 
	w = 24
	ow = 8
	
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 1) then
			dif_style = red_style
		end
	end
	lib.add_triangle (ow+5*w, ow+w, 2*w, 2*w, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 2) then
			dif_style = red_style
		end
	end
	lib.add_straight_path (ow+2*w, ow+2*w,{{2*w, 0}, {-w, 2*w}, {-w, -2*w} }, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 3) then
			dif_style = red_style
		end
	end
	lib.add_triangle (ow+4*w, ow+3*w, 2*w, 2*w, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 4) then
			dif_style = red_style
		end
	end
	lib.add_straight_path (ow+4*w, ow+2*w,{{2*w, 0}, {-w, 2*w}, {-w, -2*w} }, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 5) then
			dif_style = red_style
		end
	end
	lib.add_triangle (ow+6*w, ow+3*w, 2*w, 2*w, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 6) then
			dif_style = red_style
		end
	end
	lib.add_straight_path (ow+6*w, ow+2*w,{{2*w, 0}, {-w, 2*w}, {-w, -2*w} }, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 7) then
			dif_style = red_style
		end
	end
	lib.add_triangle (ow+3*w, ow+5*w, 2*w, 2*w, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 8) then
			dif_style = red_style
		end
	end
	lib.add_straight_path (ow+3*w, ow+4*w,{{2*w, 0}, {-w, 2*w}, {-w, -2*w} }, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 9) then
			dif_style = red_style
		end
	end
	lib.add_triangle (ow+5*w, ow+5*w, 2*w, 2*w, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 10) then
			dif_style = red_style
		end
	end
	lib.add_straight_path (ow+5*w, ow+4*w,{{2*w, 0}, {-w, 2*w}, {-w, -2*w} }, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 11) then
			dif_style = red_style
		end
	end
	lib.add_triangle (ow+7*w, ow+5*w, 2*w, 2*w, dif_style, true, false)
	dif_style = blue_style	
	for j = 1,stampa do
		if (out[j] == 12) then
			dif_style = red_style
		end
	end
	lib.add_straight_path (ow+4*w, ow+6*w,{{2*w, 0}, {-w, 2*w}, {-w, -2*w} }, dif_style, true, false)

--[[ mreza
kosa
    lib.add_line(ow+2*w, ow+2*w, 6*w, 0, style, false, false)
    lib.add_line(ow+3*w, ow+4*w, 4*w, 0, style, false, false)
    lib.add_line(ow+2*w, ow+6*w, 6*w, 0, style, false, false)
    lib.add_line(ow+5*w, ow, -3*w, 6*w, style, false, false)
    lib.add_line(ow+6*w, ow+2*w, -2*w, 4*w, style, false, false)
    lib.add_line(ow+8*w, ow+2*w, -3*w, 6*w, style, false, false)
    lib.add_line(ow+2*w, ow+2*w, 3*w, 6*w, style, false, false)
    lib.add_line(ow+4*w, ow+2*w, 2*w, 4*w, style, false, false)
    lib.add_line(ow+5*w, ow, 3*w, 6*w, style, false, false)
koordinatna
  for i = 1,9 do
    lib.add_line(ow, ow+(i-1)*w, 10*w, 0, style, false, false)
  end
  for i = 1,11 do
    lib.add_line(ow+(i-1)*w, ow, 0, 8*w, style, false, false)
  end
]]--  
  
  lib.end_canvas()
end   
 