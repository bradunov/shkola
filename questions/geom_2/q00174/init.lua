
include("terms")

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

text_style = {["font_size"] = "14"}		

px = {}
py = {}
dim = {8, 8, 12, 12, 4, 5, 6, 7}

top = {6, 8, 10, 12, 4, 5, 6, 7}
edge = {9, 12, 15, 18, 6, 8, 10, 12} 
plane = {5, 6, 7, 8, 4, 5, 6, 7}

ind = math.random(8)

if (plane[ind] == 4) then
    name = msg[2]
else
    name = msg[1]
end	

mycanvas = function(no)

  lib.start_canvas(320, 160, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130
    rt = 2

	if (ind < 5) then
		px[1] = v +2*ow
		py[1] = v
		px[2] = v+ov 
		py[2] = v
		px[3] = v+ov 
		py[3] = ov+2*ow
		px[4] = v+2*ow 
		py[4] = ov+2*ow		
		if (ind < 3) then
			if (ind == 2) then	
				px[5] = ov
				py[5] = 4*ow
				px[6] = 3*w 
				py[6] = 4*ow
				px[7] = 3*w 
				py[7] = ov-ow		
				px[8] = ov
				py[8] = ov-ow	
				view = style
			else
				px[5] = v+w
				py[5] = 4*ow
				px[6] = px[5] 
				py[6] = py[5]
				px[7] = px[5] 
				py[7] = ov-ow		
				px[8] = px[5]
				py[8] = py[7]
				view = line_style	
			end		
			lib.add_rectangle (px[5], py[5], px[6]-px[5], py[8]-py[5], line_style, true, false)	
			lib.add_rectangle (px[1], py[1], px[2]-px[1], py[4]-py[1], style, true, false)
			lib.add_straight_path(px[1], py[1], {{px[5]-px[1], py[5]-py[1]}, {px[6]-px[5], py[6]-py[5]}, {px[2]-px[6], py[2]-py[6]}, {px[1]-px[2], py[1]-py[2]}}, style,  false, false)
			lib.add_straight_path(px[6], py[6], {{px[7]-px[6], py[7]-py[6]}, {px[3]-px[7], py[3]-py[7]}}, view,  false, false)	
			lib.add_straight_path(px[4], py[4], {{px[8]-px[4], py[8]-py[4]}}, line_style,  false, false) 	
		else
			px[9] = v-ow 
			py[9] = v-2*ow
			px[10] = 3*w-ow 
			py[10] = v-2*ow
			px[11] = 3*w-ow 
			py[11] = ov
			px[12] = v-ow 
			py[12] = ov			
			if (ind == 4) then	
				px[5] = ov-2*ow 
				py[5] = 2*ow
				px[6] = 2*w+2*ow 
				py[6] = 2*ow	
				px[7] = 2*w+2*ow 
				py[7] = w+2*ow
				px[8] = ov-2*ow 
				py[8] = w+2*ow		
			else
				px[5] = v+w
				py[5] = 2*ow
				px[6] = px[5] 
				py[6] = py[5]
				px[7] = px[5] 
				py[7] = w+2*ow		
				px[8] = px[5]
				py[8] = py[7]	
			end	
			lib.add_straight_path (px[6], py[6], {{px[7]-px[6], py[7]-py[6]}, {px[8]-px[7], py[8]-py[7]}, {px[5]-px[8], py[5]-py[8]}}, line_style, true, false)	
			lib.add_rectangle (px[1], py[1], px[2]-px[1], py[4]-py[1], style, true, false)
			lib.add_straight_path(px[1], py[1], {{px[9]-px[1], py[9]-py[1]}, {px[5]-px[9], py[5]-py[9]}, {px[6]-px[5], py[6]-py[5]}, {px[10]-px[6], py[10]-py[6]},{px[2]-px[10], py[2]-py[10]}}, style,  false, false) 
			lib.add_straight_path(px[4], py[4], {{px[12]-px[4], py[12]-py[4]}, {px[9]-px[12], py[9]-py[12]}}, style,  false, false)
			lib.add_straight_path(px[3], py[3], {{px[11]-px[3], py[11]-py[3]}, {px[10]-px[11], py[10]-py[11]}}, view,  false, false)
			lib.add_straight_path(px[12], py[12], {{px[8]-px[12], py[8]-py[12]}}, line_style,  false, false) 
			lib.add_straight_path(px[11], py[11], {{px[7]-px[11], py[7]-py[11]}}, line_style,  false, false) 
		end
	else
		if (ind < 7) then
			px[1] = v+2*ow 
			py[1] = ov+2*ow			
			px[2] = v+ov 
			py[2] = ov+2*ow
			if (ind == 6) then	
				px[3] = 3*w 
				py[3] = ov-ow		
				px[4] = ov
				py[4] = ov-ow	
				px[5] = v+w
				py[5] = 4*ow			
				lib.add_straight_path(px[1], py[1], {{px[2]-px[1], py[2]-py[1]}, {px[3]-px[2], py[3]-py[2]}}, style,  false, false)
				lib.add_straight_path(px[1], py[1], {{px[4]-px[1], py[4]-py[1]}, {px[3]-px[4], py[3]-py[4]}}, line_style,  false, false)				
			else
				px[3] = ov
				py[3] = ov-ow
				px[4] = v+w
				py[4] = 4*ow					
				lib.add_straight_path(px[1], py[1], {{px[2]-px[1], py[2]-py[1]}}, style,  false, false)
				lib.add_straight_path(px[1], py[1], {{px[3]-px[1], py[3]-py[1]}, {px[2]-px[3], py[2]-py[3]}}, line_style,  false, false)
			end		
			for i = 1,dim[ind]-2 do
				lib.add_straight_path(px[dim[ind]], py[dim[ind]], {{px[i]-px[dim[ind]], py[i]-py[dim[ind]]}}, style,  false, false) 	
			end	
			lib.add_straight_path(px[dim[ind]], py[dim[ind]], {{px[dim[ind]-1]-px[dim[ind]], py[dim[ind]-1]-py[dim[ind]]}}, line_style,  false, false) 		
		else
			if (ind == 8) then
				px[1] = ov-2*ow 
				py[1] = ov+2*ow
				px[2] = 2*w+2*ow 
				py[2] = ov+2*ow	
				px[3] = 2*w+2*ow 
				py[3] = w+2*ow
				px[4] = ov-2*ow 
				py[4] = w+2*ow	
				px[5] = v-ow 
				py[5] = ov			
				px[6] = 3*w-ow 
				py[6] = ov	
				px[7] = v+w
				py[7] = 4*ow
				lib.add_straight_path(px[5], py[5], {{px[1]-px[5], py[1]-py[5]}, {px[2]-px[1], py[2]-py[1]}, {px[6]-px[2], py[6]-py[2]}}, style,  false, false)
				lib.add_straight_path(px[5], py[5], {{px[4]-px[5], py[4]-py[5]}, {px[3]-px[4], py[3]-py[4]}, {px[6]-px[3], py[6]-py[3]}}, line_style,  false, false)	
				for i = 1,dim[ind] do
					if (i == 3 or i == 4) then
						view = line_style
					else
						view = style	
					end
					lib.add_straight_path(px[i], py[i], {{px[7]-px[i], py[7]-py[i]}}, view,  false, false) 	
				end
			else
				px[1] = v-ow 
				py[1] = w+2*ow				
				px[2] = v +2*ow
				py[2] = ov
				px[3] = v+ov 
				py[3] = ov
				px[4] = 3*w-ow 
				py[4] = w+2*ow					
				px[5] = v+w 
				py[5] = v			
				px[6] = v+w
				py[6] = 2*ow		
				lib.add_straight_path(px[1], py[1], {{px[2]-px[1], py[2]-py[1]}, {px[3]-px[2], py[3]-py[2]}, {px[4]-px[3], py[4]-py[3]}}, style,  false, false)
				lib.add_straight_path(px[1], py[1], {{px[5]-px[1], py[5]-py[1]}, {px[4]-px[5], py[4]-py[5]}}, line_style,  false, false)	
				for i = 1,dim[ind]-2 do
					lib.add_straight_path(px[dim[ind]], py[dim[ind]], {{px[i]-px[dim[ind]], py[i]-py[dim[ind]]}}, style,  false, false) 	
				end	
				lib.add_straight_path(px[dim[ind]], py[dim[ind]], {{px[dim[ind]-1]-px[dim[ind]], py[dim[ind]-1]-py[dim[ind]]}}, line_style,  false, false) 				
			end
		end
	end

	for i = 1,dim[ind] do	
		lib.add_circle (px[i], py[i], rt, point_style, true, false)
	end	
 
  lib.end_canvas()
end   
    