
brown_style = 
	{["off_color"] = "c90",
        ["on_color"] = "c90",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
				
yelow_style = {["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "2"};

green_style = {["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
		
style = {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

dif_style = {["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "1"};			

px = {}
py = {}
rot = {}
index = {}
out = {}

ang = {60, 60, 120, 120, 180}
ch = math.random(5)
if (ch - 2*math.floor(ch/2) == 1) then
    sign = " + "
else
    sign = " - "
end	
angle = sign .. tostring(ang[ch]) .. "°"

rot0 = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
rot[1] = {12, 10, 11, 8, 9, 7, 3, 5, 1, 6, 2, 4}
rot[2] = {9, 11, 7, 12, 8, 10, 6, 4, 5, 2, 3, 1}
rot[3] = {4, 6, 2, 5, 1, 3, 11, 9, 12, 7, 10, 8}
rot[4] = {5, 3, 6, 1, 4, 2, 10, 12, 8, 11, 7, 9}
rot[5] = {8, 7, 10, 9, 12, 11, 2, 1, 4, 3, 6, 5}

ind = math.random(12)
pct = rot[ch][ind]

nr = 0
for i = 1,12 do
    if (rot0[i] ~= ind and rot0[i] ~= pct) then
	    nr = nr + 1
		index[nr] = rot0[i]
	end
end
out = lib.math.random_shuffle(index)
out[1] = ind
sg = 1 + math.random(5)
out[sg] = pct

results = ""

for i = 1, 5 do
	if i > 1 then
		results = results .. " && "
	end
	results = results .. "result[" .. tostring(i-1) .. "] == "
	if (i == sg-1) then
	  results = results .. "1"
	else
	  results = results .. "0"
	end

end
   
mycanvas = function(no)

  lib.start_canvas(300, 230, "center", results)

	w = 70
	ow = 10
	v = 40
	
	shiftx =  100	
	shifty =  120

	max_range = 6    --[[ crta sve trouglove, i=1,12, out[i]=i]]--
	for i = 1,max_range do 
		level = math.floor((i-1)/3)
		shift_x =  (i-1-3*level)*shiftx	
		shift_y =  level*shifty		
		if (out[i] < 7) then
			px[1] = ow + shift_x
			py[1] = w + shift_y 			
			px[2] = ow + w + shift_x 
			py[2] = w + shift_y
			px[3] = ow +w/2 + shift_x
			py[3] = ow + v + shift_y		
			px[4] = ow +w/2 + shift_x
			py[4] = ow + shift_y	
			yy = py[1] + 2*ow
		else
			px[1] = ow + shift_x
			py[1] = ow + shift_y 			
			px[2] = ow + w + shift_x 
			py[2] = ow + shift_y
			px[3] = ow +w/2 + shift_x
			py[3] = v - ow + shift_y 		
			px[4] = ow +w/2 + shift_x
			py[4] = w + shift_y	
			yy = py[4]+2*ow
		end	
		if (out[i] < 3 or (out[i] > 6 and out[i] < 9)) then
			style1 = brown_style
			if (out[i] == 1 or out[i] == 7) then
				style2 = yelow_style
				style3 = green_style
			else
				style3 = yelow_style
				style2 = green_style
			end		
		else
			if (out[i] < 5 or (out[i] > 8 and out[i] < 11)) then	
				style1 = yelow_style
				if (out[i] == 3 or out[i] == 9) then
					style2 = brown_style
					style3 = green_style
				else
					style3 = brown_style
					style2 = green_style
				end					
			else
				style1 = green_style
				if (out[i] == 5 or out[i] == 11) then
					style2 = brown_style
					style3 = yelow_style
				else
					style3 = brown_style
					style2 = yelow_style
				end					
			end	
		end		
		lib.add_straight_path(px[1], py[1], {{px[2]-px[1], py[2]-py[1]}, {px[3]-px[2], py[3]-py[2]}, {px[1]-px[3], py[1]-py[3]}}, style1,  false, false)		
		lib.add_straight_path(px[1], py[1], {{px[4]-px[1], py[4]-py[1]}, {px[3]-px[4], py[3]-py[4]}, {px[1]-px[3], py[1]-py[3]}}, style2,  false, false)
		lib.add_straight_path(px[2], py[2], {{px[3]-px[2], py[3]-py[2]}, {px[4]-px[3], py[4]-py[3]}, {px[2]-px[4], py[2]-py[4]}}, style3,  false, false)	
		if (i == 1) then
			lib.add_circle (px[1]+w/2, yy, 10, style, false, false)	
		else
			lib.add_circle (px[1]+w/2, yy, 10, dif_style, false, true)	
		end
	end

  lib.end_canvas()
end    
        
                 
            