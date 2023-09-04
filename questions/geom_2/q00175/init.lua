
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


dim = {8, 8, 12, 12, 3, 4, 5, 6}

top = {6, 8, 10, 12, 4, 5, 6, 7}
edge = {9, 12, 15, 18, 6, 8, 10, 12} 
plane = {5, 6, 7, 8, 4, 5, 6, 7}

px = {}
py = {}
numx = {}
numy = {}

ind = math.random(8)
ch = math.random(2)

point = top[ind]
side = plane[ind]
line = edge[ind]

mycanvas = function(no)

  lib.start_canvas(320, 170, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130
    rt = 2

  if (ind < 5) then
	if (ind < 3) then
		px[1] = v +2*ow
		py[1] = 4*ow
		px[2] = ov + 4*ow 
		py[2] = 4*ow
		px[3] = ov + 4*ow 
		py[3] = ov+2*ow
		px[4] = v+2*ow 
		py[4] = ov+2*ow	
		if (ind == 2) then	
			px[5] = ov
			py[5] = ow
			px[6] = ov+w 
			py[6] = ow
			px[7] = ov+w 
			py[7] = ov-ow		
			px[8] = ov
			py[8] = ov-ow			
			lib.add_straight_path(px[1], py[1], {{px[5]-px[1], py[5]-py[1]}, {px[6]-px[5], py[6]-py[5]}, {px[2]-px[6], py[2]-py[6]}, {px[1]-px[2], py[1]-py[2]}}, style,  false, false)
			lib.add_straight_path(px[7], py[7], {{px[3]-px[7], py[3]-py[7]}}, style,  false, false)	
			if (ch == 1) then
				view = style
			else
				view = line_style
			end	
			lib.add_straight_path(px[6], py[6], {{px[7]-px[6], py[7]-py[6]}}, view,  false, false)				
		else
			px[5] = v+2*w
			py[5] = ov-ow
			px[6] = px[5] 
			py[6] = py[5]
			px[7] = v+w 
			py[7] = ov-ow		
			px[8] = px[7]
			py[8] = py[7]
			if (ch == 1) then
				view = style
			else
				view = line_style
			end						
			lib.add_straight_path(px[2], py[2], {{px[6]-px[2], py[6]-py[2]}}, view,  false, false)	
			lib.add_straight_path(px[6], py[6], {{px[3]-px[6], py[3]-py[6]}}, style,  false, false)				
			lib.add_straight_path(px[6], py[6], {{px[7]-px[6], py[7]-py[6]}, {px[1]-px[7], py[1]-py[7]}}, line_style,  false, false)	
		end
		lib.add_straight_path(px[5], py[5], {{px[8]-px[5], py[8]-py[5]}, {px[7]-px[8], py[7]-py[8]}},  line_style, true, false)		
		lib.add_rectangle (px[1], py[1], px[2]-px[1], py[4]-py[1], style, true, false)
		lib.add_straight_path(px[4], py[4], {{px[8]-px[4], py[8]-py[4]}}, line_style,  false, false) 
		if (ch == 2) then
			vrhx = 3*w
			numx[1] = ov + 4*ow 
			numy[1] = 4*ow
			numx[2] = ov + 4*ow 
			numy[2] = ov+2*ow			
			if (ind == 2) then
				numx[3] = ov+w 
				numy[3] = ow
				numx[4] = ov+w 
				numy[4] = ov-ow
			        vrhy = v-2*ow
				point = 9
				side = 9
				line = 16
			else
				numx[3] = v+2*w 
				numy[3] = ov-ow	
			        vrhy = v
				point = 7
				side = 7
				line = 12				
			end
			for i = 1, dim[4+ind]	do	
				lib.add_straight_path(vrhx, vrhy, {{numx[i]-vrhx, numy[i]-vrhy}}, style,  false, false)		
			end
		end
	else	
		px[1] = v - 2*ow
		py[1] = v - 2*ow
		px[2] = ov - ow
		py[2] = v-2*ow
		px[3] = ov - ow
		py[3] = ov
		px[4] = v - 2*ow
		py[4] = ov
		if (ind == 4) then					
			px[5] = v + w 
			py[5] = v-ow
			px[6] = 3*v + ow
			py[6] = v-ow
			px[7] = 3*v + ow 
			py[7] = 2*v
			px[8] = v + w
			py[8] = 2*v			
			px[9] = v + 3*ow
			py[9] = 3*ow
			px[10] = 2*w + ow
			py[10] = 3*ow
			px[11] = 2*w + ow
			py[11] = 2*w
			px[12] = v+3*ow
			py[12] = 2*w
			if (ch == 1) then
				view = style
			else
				view = line_style
			end
			lib.add_straight_path(px[6], py[6], {{px[7]-px[6], py[7]-py[6]}}, view,  false, false)
			lib.add_straight_path(px[10], py[10], {{px[6]-px[10], py[6]-py[10]}}, style,  false, false) 
			lib.add_straight_path(px[11], py[11], {{px[7]-px[11], py[7]-py[11]}}, style,  false, false) 
		else
			px[5] = v + w 
			py[5] = w+ow
			px[6] = 3*v + ow
			py[6] = w+ow
			px[7] = px[6] 
			py[7] = py[6]
			px[8] = px[5]
			py[8] = py[5]			
			px[9] = v + 4*ow
			py[9] = 2*ow
			px[10] = 2*w + 2*ow
			py[10] = 2*ow
			px[11] = 2*w + 2*ow
			py[11] = 2*w
			px[12] = v+4*ow
			py[12] = 2*w	
			lib.add_straight_path(px[5], py[5], {{px[6]-px[5], py[6]-py[5]}}, line_style,  false, false)
			if (ch == 1) then
				view = style
			else
				view = line_style
			end
			lib.add_straight_path(px[10], py[10], {{px[6]-px[10], py[6]-py[10]}, {px[11]-px[6], py[11]-py[6]}}, view,  false, false) 
		end				
		lib.add_rectangle (px[1], py[1], px[2]-px[1], py[4]-py[1], style, true, false)
		lib.add_rectangle (px[5], py[5], px[6]-px[5], py[8]-py[5], line_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[9]-px[1], py[9]-py[1]}, {px[10]-px[9], py[10]-py[9]}}, style,  false, false) 
		lib.add_straight_path(px[4], py[4], {{px[12]-px[4], py[12]-py[4]}, {px[11]-px[12], py[11]-py[12]}}, style,  false, false) 
		lib.add_straight_path(px[10], py[10], {{px[2]-px[10], py[2]-py[10]}, {px[3]-px[2], py[3]-py[2]}, {px[11]-px[3], py[11]-py[3]}}, style,  false, false)	
		lib.add_straight_path(px[9], py[9], {{px[5]-px[9], py[5]-py[9]}, {px[8]-px[5], py[8]-py[5]}, {px[12]-px[8], py[12]-py[8]}}, line_style,  false, false)			      
		if (ch == 2) then
			vrhx = 2*ov
			numx[1] = ov - ow
			numy[1] = v-2*ow
			numx[2] = ov - ow
			numy[2] = ov
			if (ind == 4) then
				vrhy = w+2*ow+5
				numx[3] = 3*v + ow
				numy[3] = v-ow
				numx[4] = 3*v + ow 
				numy[4] = 2*v
				numx[5] = 2*w + ow
				numy[5] = 3*ow
				numx[6] = 2*w + ow
				numy[6] = 2*w		
				point = 13
				side = 13
				line = 18
			else
				vrhy = w + ow
				numx[3] = 3*v + ow
				numy[3] = w+ow
				numx[4] = 2*w + 2*ow
				numy[4] = 2*ow
				numx[5] = 2*w + 2*ow
				numy[5] = 2*w				
				point = 11
				side = 11
				line = 20				
			end
			for i = 1, dim[4+ind] do
				view = style
				if (ind == 3 and i == 3) then
					view = line_style
				end					
				lib.add_straight_path(vrhx, vrhy, {{numx[i]-vrhx, numy[i]-vrhy}}, view,  false, false)		
			end
		end
	end	
  else	
	if (ind < 7) then
		px[1] = v + w 
		px[2] = v + w 
		py[2] = v + w
        topx = 5*ow
		topy = 5*ow
		if (ind == 6) then
			py[1] = 4*ow	
			px[3] = ov+w -2*ow
			py[3] = ow
			px[4] = ov+w -2*ow
			py[4] = ov-ow			
			lib.add_straight_path(px[3], py[3], {{px[4]-px[3], py[4]-py[3]}, {px[2]-px[4], py[2]-py[4]}}, style,  false, false)
			lib.add_straight_path(px[3], py[3], {{px[1]-px[3], py[1]-py[3]}, {px[2]-px[1], py[2]-py[1]}}, line_style,  false, false)	
			for i = 1,dim[ind] do
				if (i == 1) then	
					view = line_style
				else
					view = style
				end				
				lib.add_straight_path(topx, topy, {{px[i]-topx, py[i]-topy}}, view,  false, false)
			end	
			if (ch == 2) then
				vrhx = 2*ov
				vrhy = ov	
				point = 6
				side = 8
				line = 12
			end
		else
			py[1] = 2*ow
			px[3] = ov+w 
			py[3] = ov-ow	
			lib.add_straight_path(px[1], py[1], {{px[3]-px[1], py[3]-py[1]}, {px[2]-px[3], py[2]-py[3]} }, style,  false, false)
			lib.add_straight_path(px[1], py[1], {{px[2]-px[1], py[2]-py[1]}}, line_style,  false, false)
			for i = 1,dim[ind] do			
				lib.add_straight_path(topx, topy, {{px[i]-topx, py[i]-topy}}, style,  false, false)
			end	
			if (ch == 2) then
				vrhx = 3*w
				vrhy = 	5*ow	
				point = 5
				side = 6
				line = 9
			end			
        end	
		if (ch == 2) then
			for i = 1,dim[ind] do	
			if ((ind == 5 and i == 2) or (ind == 6 and i == 1)) then
					view = line_style
				else
					view = style
				end					
				lib.add_straight_path(vrhx, vrhy, {{px[i]-vrhx, py[i]-vrhy}}, view,  false, false)
            end 
		end				
	else
		px[1] = ov - 3*ow
		py[1] = v-2*ow
		px[2] = ov - 3*ow
		py[2] = ov
        topx = v-2*ow	
		if (ind == 8) then					
			px[3] = 3*v - ow
			py[3] = v-ow
			px[4] = 3*v - ow 
			py[4] = 2*v			
			px[5] = 2*w - ow
			py[5] = 2*ow
			px[6] = 2*w - ow
			py[6] = 2*w
			topy = 2*ow
			lib.add_straight_path(px[5], py[5], {{px[3]-px[5], py[3]-py[5]}, {px[4]-px[3], py[4]-py[3]}, {px[6]-px[4], py[6]-py[4]},  {px[2]-px[6], py[2]-py[6]},}, style,  false, false)	
			lib.add_straight_path(px[5], py[5], {{px[1]-px[5], py[1]-py[5]}, {px[2]-px[1], py[2]-py[1]}}, line_style,  false, false)	
			if (ch == 2) then
				vrhx = 2*ov+2*ow
				vrhy = w	
				point = 8
				side = 12
				line = 18				
			end
		else
			px[3] = 2*w + 2*ow
			py[3] = 2*ow
			px[4] = 2*w + 2*ow
			py[4] = 2*w			
			px[5] = 3*v + ow
			py[5] = w+ow			
			topy = ow
			lib.add_straight_path(px[3], py[3], {{px[5]-px[3], py[5]-py[3]}, {px[4]-px[5], py[4]-py[5]}, {px[2]-px[4], py[2]-py[4]}}, style,  false, false)	
			lib.add_straight_path(px[3], py[3], {{px[1]-px[3], py[1]-py[3]}, {px[2]-px[1], py[2]-py[1]}}, line_style,  false, false)			      		
			if (ch == 2) then
				vrhx = 2*ov+2*ow
				vrhy = w
				point = 7
				side = 10
				line = 15
			end			
		end			
		for i = 1,dim[ind] do
			if (i == 1) then	
				view = line_style
			else
				view = style
			end				
			lib.add_straight_path(topx, topy, {{px[i]-topx, py[i]-topy}}, view,  false, false)
		end	
		if (ch == 2) then
			for i = 1,dim[ind] do	
				if (i < 3 or i == 6) then	
					view = line_style
				else
					view = style
				end				
				lib.add_straight_path(vrhx, vrhy, {{px[i]-vrhx, py[i]-vrhy}}, view,  false, false)
			end	 
        end			
	end		
	lib.add_circle (topx, topy, rt, point_style, true, false)		
  end

  for i = 1,dim[ind] do	
	  lib.add_circle (px[i], py[i], rt, point_style, true, false)
  end	
  if (ch == 2) then
	  lib.add_circle (vrhx, vrhy, rt, point_style, true, false)
  end	
 
  lib.end_canvas()
  
if (side < 5) then
    name = msg[2]
else
    name = msg[1]
end	
  
end       
            