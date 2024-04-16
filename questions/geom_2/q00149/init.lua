
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
	
blue_style = 
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "0cf",
        ["line_width"] = "2.5"};	
				
text_style = {["font_size"] = "14"}	

name = {"AB", "BO", "AO", "CD",  "DO", "CO"}
coef = {}
part = {}
dim = {}

out = {}

meas = "cm"
space = "\( \ \ \ \ \)"

ch = math.random(6) 

mycanvas = function(no)

	ow = 8
	w = 200
	ov = 120
	v = 32
	scale = 5*(1 + math.random(4))

	lib.start_canvas(260, 150, "center") 
	
		xa = v+2*ow+5
		ya = ov+ow		
		lib.add_text(xa+ow-5, ya+ow, "A", text_style)  
		xb = w-2*ow+5
		yb = ov+ow		
		lib.add_text(xb, yb+ow, "B", text_style)
		xo = ov-ow+2
		yo = 2*(v+ow)-2
		lib.add_text(xo, yo+ow+2, "O", text_style) 		 
		coef[1] =  0
		lib.add_straight_path(v, ov+ow, {{w-v, 0}}, style, true, false) 
		coef[2] =  ov/(ov+2*v)
		lib.add_straight_path(2*ow, 2*ow, {{ov+2*v, ov}}, style, true, false) 
		coef[3] =  (-ov-ow)/(2*(w-ov))
		lib.add_straight_path(v, ov+3*ow, {{2*(w-ov), -ov-ow}}, style, true, false)
		lib.add_circle (xa, ya, 3, style, true, false)
		lib.add_circle (xb, yb, 3, style, true, false) 	
		lib.add_circle (xo, yo, 3, style, true, false) 		

		xx = 3*ow
		yy = 2*ow + math.random(2*(v-ow))  	  
		dx = w - v 	  		    
		lib.add_straight_path(xx, yy, {{dx, 0}}, style, true, false) 
		yc = yy      
		xc = xo+(yc-yo)/coef[3]
		yd = yy
		xd = xo + (yd-yo)/coef[2]	  
		lib.add_text(xc-ow+5, yc-ow, "C", text_style)
		lib.add_text(xd+ow-5, yd-ow, "D", text_style)  	
		lib.add_circle (xc, yc, 3, style, true, false)
		lib.add_circle (xd, yd, 3, style, true, false)		
		part[1] = math.abs(xb-xa)	
		part[2] = math.sqrt((xb-xo)^2+(yb-yo)^2)	  
		part[3] = math.sqrt((xo-xa)^2+(yo-ya)^2)		  
		part[4] = math.abs(xd - xc)
		part[5] = math.sqrt((xd-xo)^2+(yd-yo)^2)
		part[6] = math.sqrt((xc-xo)^2+(yc-yo)^2)		
		
		if ((ch>1 and ch<4) or ch>4) then
			px2 = xo
			py2 = yo	
			if (ch == 2) then
			    px1 = xb
			    py1 = yb
			end
			if (ch == 3) then
			    px1 = xa
			    py1 = ya
			end
			if (ch == 5) then
			    px1 = xd
			    py1 = yd
			end	
			if (ch == 6) then
			    px1 = xc
			    py1 = yc
			end						
		else
		    if (ch == 1) then
			    px1 = xa
			    py1 = ya	
			    px2 = xb
			    py2 = yb
            else				
			    px1 = xc
			    py1 = yc	
			    px2 = xd
			    py2 = yd
            end					
		end		  		  		
	    lib.add_straight_path(px1, py1, {{px2-px1, py2-py1}}, blue_style, true, false) 
		
		for i = 1,6 do	
		    dim[i] = lib.math.round(part[i]/scale)				  
		end 		

	lib.end_canvas()

    if (ch == 1 or ch == 4) then
       if (ch == 1) then
			out[3] = 4	
			sg = 1
        else
			out[3] = 1
			sg = 2
        end		
 	    ed = math.random(2)
		out[sg] = ed + 1		  
		out[3-sg] = ed + 4	
		result = (dim[out[1]] * dim[out[3]])/dim[out[2]]		
    else
	    if (ch > 4) then
            tmp = ch - 3
			sg = 2
        else 
            tmp = ch + 3	
			sg = 1			
        end			
	    out[3] = tmp
	 	ed = math.random(2)
		if (ed == 1) then
			out[sg] = 1		  
			out[3-sg] = 4
			result = (dim[out[1]] * dim[out[3]])/dim[out[2]]			
		else
			if (tmp == 2 or tmp == 5) then
				out[sg] = 3		  
				out[3-sg] = 6
			else
				out[sg] = 2		  
				out[3-sg] = 5
			end	
			result = (dim[out[1]] * dim[out[3]])/dim[out[2]]			
        end		
    end
	
	quest = ""  
	for j = 1,3 do
	  quest = quest .. space .. name[out[j]] .. " = " .. tostring(dim[out[j]]) .. " " .. meas .. ", "
	end
    result = lib.math.round_dec(result,1)	
	sol = name[ch] .. " = " .. lib.check_number(result) .. meas	  	  
	
end            
          
            