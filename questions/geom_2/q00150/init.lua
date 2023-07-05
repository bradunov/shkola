
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
	
colour_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "1"};
				
text_style = {["font_size"] = "14"}	


name = {""}
coef = {}
part = {}
dim = {}

out = {}

meas = "cm"
space = "\( \ \ \ \ \)"
sym = {"△", "□"}

ch = math.random(6) 
if (ch == 3) then
    ch = 4
end	

mycanvas = function(no)

	ow = 10
	w = 250
	ov = 150
	v = 40
	scale = 5*(1 + math.random(4))

	lib.start_canvas(320, 170, "center") 
	
		xa = v+4
		ya = ov-ow		
		lib.add_text(xa, ya+ow, "A", text_style)  
		xb = 2*(ov-ow)
		yb = ya			
		lib.add_text(xb, yb+ow, "B", text_style)
		xc = xb
		yc = 3*ow-2				
		lib.add_text(xc, yc-ow-2, "C", text_style)  

		lib.add_straight_path(xa-1, ya, {{xb-xa+2, 0}}, style, true, false) 
		lib.add_straight_path(xc, yc, {{0, yb-yc}}, style, true, false) 
		lib.add_straight_path(xa, ya, {{xb-xa-1, yc-yb}}, style, true, false)
		lib.add_circle (xa, ya, 3, style, true, false)
		lib.add_circle (xb, yb, 3, style, true, false) 	
		lib.add_circle (xc, yc, 3, style, true, false) 		

		part[1] = xb - xa	
		part[2] = yb - yc	  
		part[3] = math.sqrt((xb-xa)^2+(yc-yb)^2)	
		part[4] = part[1]*part[2]/(part[1]+part[2])
		part[5] = part[1] - part[4]
		part[6] = part[2] - part[4]
		part[7] = part[3]*part[4]/part[1]
		part[8] = part[3] - part[7]	
		name[1] = "AB" 
		name[2] = "BC" 
		name[3] = "AC"          		  
		name[4] = "BD" 
		name[5] = "AD" 
		name[6] = "CE" 
		name[7] = "CF" 
		name[8] = "AF"  
		
		x1 = xb-part[4]
		y1 = yb 
		x2 = xb		
		y2 = yb-part[4]	  
		lib.add_text(x1-ow, y1+ow, "D", text_style)
		lib.add_text(x2+ow, y2-ow, "E", text_style)  
		lib.add_text(x1-ow, y2-ow, "F", text_style) 
		lib.add_straight_path(x1, y1, {{0, - part[4]}, {part[4], 0}, {0, part[4]}}, colour_style, true, false) 		
		lib.add_circle (x1, y1, 3, style, true, false)
		lib.add_circle (x2, y2, 3, style, true, false)
		lib.add_circle (x1, y2, 3, style, true, false)	
		
		for i = 1,8 do	
		    dim[i] = lib.math.round(part[i]/scale)				  
		end 		

	lib.end_canvas()

	areat = 0.5 * dim[1] * dim[2]
	areas = dim[4] * dim[4]
	if (ch < 4) then 		
		out[1] = 3 - ch		  
		out[2] = 4
		fin = ch
		result = dim[out[2]] + (dim[out[2]] * dim[out[2]])/(dim[out[1]]-dim[out[2]])	       		
        result = lib.math.round_dec(result,1)
	    areat = 0.5 * dim[out[1]] * result
    else		
		if (ch == 4) then
			out[1] = 1		  
			out[2] = 2
			fin = ch
			result = (dim[out[1]] * dim[out[2]])/(dim[out[1]]+dim[out[2]])
			result = lib.math.round_dec(result,1)			
            areas = result * result       		
		else	
			out[1] = 11 - ch	  
			out[2] = 4
			fin = ch - 4
			result = dim[out[2]] + (dim[out[2]] * dim[out[2]])/dim[out[1]]
			result = lib.math.round_dec(result,1)			
	        areat = 0.5 * (dim[out[1]] + dim[out[2]])  * result			
        end	
    end		
 
	quest = ""  
	for j = 1,2 do
	  quest = quest .. space .. name[out[j]] .. " = " .. tostring(dim[out[j]]) .. " " .. meas .. ", "
	end
	sol = name[fin] .. " = " .. lib.check_number(result) .. meas	
	areas = lib.math.round_dec(areas,2)	
	areat = lib.math.round_dec(areat,2)	
	prop = lib.math.round_dec(areas/areat,1)	
	
end   
      