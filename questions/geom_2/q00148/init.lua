
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


name = {""}
coef = {}
part = {}
dim = {}

out = {}

meas = "cm"
space = "\( \ \ \ \ \)"

ind = math.random(3)
ch = math.random(8) 

mycanvas = function(no)

	ow = 8
	w = 200
	ov = 120
	v = 32
	scale = 5*(1 + math.random(4))

	lib.start_canvas(260, 140, "center") 
	
		xa = v+4
		ya = ov-ow		
		lib.add_text(xa, ya+ow, "A", text_style)  
		xb = 2*(ov-ow)
		yb = ov-ow			
		lib.add_text(xb, yb+ow, "B", text_style)
		xc = ov-v-5
		yc = 3*ow-2				
		lib.add_text(xc, yc-ow-2, "C", text_style)  
		if (ind == 1 and ch < 4) then
			lib.add_straight_path(xa-1, ya, {{xb-xa+2, 0}}, blue_style, true, false)  
		else
			lib.add_straight_path(xa-1, ya, {{xb-xa+2, 0}}, style, true, false) 
		end
		coef[1] =  0
		if (ind == 2 and ch < 4) then
			lib.add_straight_path(xc-2, yc, {{xb-xc+3, yb-yc}}, blue_style, true, false) 
		else
			lib.add_straight_path(xc-2, yc, {{xb-xc+3, yb-yc}}, style, true, false) 
		end
		coef[2] =  (yb-yc)/(xb-xc+3)  
		if (ind == 3 and ch < 4) then
			lib.add_straight_path(xc, yc, {{xa-xc-1, ov-3*ow-6}}, blue_style, true, false)
		else
			lib.add_straight_path(xc, yc, {{xa-xc-1, ov-3*ow-6}}, style, true, false)
		end
		coef[3] =  (ya-yc+2)/(xa-xc-1)
		lib.add_circle (xa, ya, 3, style, true, false)
		lib.add_circle (xb, yb, 3, style, true, false) 	
		lib.add_circle (xc, yc, 3, style, true, false) 		

		if (ind < 3) then
			xx = v+ow
			if (ind == 1) then
			  yy = v+ow + math.random(2*v-ow)  	  
			  dx = w - v 	  		    
			else
			  yy = v + math.random(2*v)  	  
			  dx = w	  
			end
		else	  
			xx = w+2*ow
			yy = 2*ow + math.random(3*(v-ow)) 	  
			dx = -w
		end
		lib.add_straight_path(xx, yy, {{dx, coef[ind]*dx}}, style, true, false) 

		if (ind == 1) then
		  y1 = yy      
		  x1 = xc+(y1-yc)/coef[3]
		  y2 = yy
		  x2 = xb + (y2-yb)/coef[2]	  
		  lib.add_text(x1-ow, y1-ow, "D", text_style)
		  lib.add_text(x2+ow, y2-ow, "E", text_style)  	
		  part[1] = xb-xa	
		  part[2] = math.sqrt((xb-xc)^2+(yb-yc)^2)	  
		  part[3] = math.sqrt((xc-xa)^2+(yc-ya)^2)		  
		  part[4] = x2 - x1
		  part[5] = math.sqrt((xb-x2)^2+(yb-y2)^2)
		  part[6] = part[2] - part[5]
		  part[7] = math.sqrt((xa-x1)^2+(ya-y1)^2)
		  part[8] = part[3] - part[7]	
 		  name[1] = "AB" 
		  name[2] = "BC" 
		  name[3] = "AC"          		  
		  name[4] = "DE" 
		  name[5] = "BE" 
		  name[6] = "CE" 
		  name[7] = "AD" 
		  name[8] = "CD"  
		  if (ch == 5 or ch == 6) then
			  px2 = x2
			  py2 = y2	
			  if (ch == 5) then
				  px1 = xb
				  py1 = yb
			  else
				  px1 = xc	
				  py1 = yc
			  end
		  end		  		  
		  if (ch == 7 or ch == 8) then
			  px2 = x1
			  py2 = y1	
			  if (ch == 7) then
				  px1 = xa
				  py1 = ya
			  else
				  px1 = xc	
				  py1 = yc
			  end
		  end		  
		end 
		if (ind == 2) then
		  x1 = ((yy-coef[2]*xx) - (yc-coef[3]*xc))/(coef[3]-coef[2])
		  y1 = yy + coef[2]*(x1-xx)
		  y2 = yb	  
		  x2 = xx + (y2 - yy)/coef[2]
		  lib.add_text(x1-ow, y1, "D", text_style)
		  lib.add_text(x2-ow, y2+ow, "F", text_style)  	
		  part[1] = math.sqrt((xb-xc)^2+(yb-yc)^2)	  
		  part[2] = math.sqrt((xc-xa)^2+(yc-ya)^2)		
		  part[3] = xb-xa		  
		  part[4] = math.sqrt((x1-x2)^2+(y1 - y2)^2)
		  part[5] = math.sqrt((xc-x1)^2+(yc-y1)^2)
		  part[6] = part[2] - part[5] 
		  part[7] = xb-x2
		  part[8] = part[3] - part[7]	
 		  name[1] = "BC" 
		  name[2] = "AC" 
		  name[3] = "AB"    		  
		  name[4] = "DF" 
		  name[5] = "CD" 
		  name[6] = "AD" 
		  name[7] = "BF" 
		  name[8] = "AF" 
		  if (ch == 5 or ch == 6) then
			  px2 = x1
			  py2 = y1	
			  if (ch == 5) then 
				  px1 = xc
				  py1 = yc
			  else    
				  px1 = xa	
				  py1 = ya
			  end
		  end		  		  
		  if (ch == 7 or ch == 8) then
			  px2 = x2
			  py2 = y2	
			  if (ch == 7) then
				  px1 = xb
				  py1 = yb
			  else   
			      px1 = xa	
				  py1 = ya
			  end
		  end			  	  
		end  
		if (ind == 3) then
		  x1 = ((yy-coef[3]*xx) - (yc-coef[2]*xc))/(coef[2]-coef[3])
		  y1 = yy + coef[3]*(x1-xx)
		  y2 = ov-ow	  
		  x2 = xx + (y2 - yy)/coef[3]
		  lib.add_text(x1+ow, y1, "E", text_style)
		  lib.add_text(x2, y2+ow, "F", text_style)
		  part[1] = math.sqrt((xa-xc)^2+(ya-yc)^2)		  
		  part[2] = xb-xa	
		  part[3] = math.sqrt((xb-xc)^2+(yb-yc)^2)	  			  
		  part[4] = math.sqrt((x1-x2)^2+(y1-y2)^2)
		  part[5] = x2-xa
		  part[6] = part[2] - part[5]
		  part[7] = math.sqrt((xc-x1)^2+(yc-y1)^2)
		  part[8] = part[3] - part[7]
 		  name[1] = "AC" 
		  name[2] = "AB" 
		  name[3] = "BC"    		  
		  name[4] = "EF" 
		  name[5] = "AF" 
		  name[6] = "BF" 
		  name[7] = "CE" 
		  name[8] = "BE" 	
		  if (ch == 5 or ch == 6) then
			  px2 = x2
			  py2 = y2	
			  if (ch == 5) then 
				  px1 = xa
				  py1 = ya
			  else 
				  px1 = xb	
				  py1 = yb
			  end
		  end		  		  
		  if (ch == 7 or ch == 8) then
			  px2 = x1
			  py2 = y1	
			  if (ch == 7) then  
				  px1 = xc
				  py1 = yc
			  else   
			      px1 = xb	
				  py1 = yb
			  end
		  end  	  	  
		end  
		lib.add_circle (x1, y1, 3, style, true, false)
		lib.add_circle (x2, y2, 3, style, true, false)
		if (ch == 4) then	  
			px1 = x1
			px2 = x2
			py1 = y1
			py2 = y2
		end	
		if (ch > 3) then			
		    lib.add_straight_path(px1, py1, {{px2-px1, py2-py1}}, blue_style, true, false) 
		end
		
		for i = 1,8 do	
		    dim[i] = lib.math.round(part[i]/scale)				  
		end 		

	lib.end_canvas()

    fin = ch
	if (ch > 4) then 
        nr = 0		
		for i = 5,8 do
		    if (i ~= ch) then
			    nr = nr + 1				
			    out[nr] = i		  
		    end
		end
		if (ch == 6 or ch == 7) then
		    result = (dim[out[1]] * dim[out[3]])/dim[out[2]]
		else
		    if (ch == 5) then
				result = (dim[out[1]] * dim[out[2]])/dim[out[3]]	
			else
				result = (dim[out[2]] * dim[out[3]])/dim[out[1]]		
            end				
        end		
 		ed = math.random(2)
		if (ed == 2) then
		    if (ch < 7) then
			    tmp = dim[out[2]] + dim[out[3]]
                result = dim[2]/tmp
				if (ch == 5) then
				    result = result * dim[out[2]]
				else
				    result = result * dim[out[3]]				
				end
				out[1] = 2
            else
  			    tmp = dim[out[1]] + dim[out[2]]
                result = dim[3]/tmp
				if (ch == 7) then
				    result = result * dim[out[1]]
				else
				    result = result * dim[out[2]]				
				end
				out[3] = 3				
            end
		end
	else
		ed = math.random(2)	- 1
		for i = 1,2 do
			out[i] = i+4+2*ed
		end	
        tmp = (dim[out[1]] + dim[out[2]]) / dim[out[2]]		
        if (ch == 4) then	
            out[3] = 1
			result =  dim[out[3]] / tmp
 		else
            out[3] = 4
			fin = 1
			result =  dim[out[3]] * tmp			
        end			   		
    end
	
	quest = ""  
	for j = 1,3 do
	  quest = quest .. space .. name[out[j]] .. " = " .. tostring(dim[out[j]]) .. " " .. meas .. ", "
	end
    result = lib.math.round_dec(result,1)	
	sol = name[fin] .. " = " .. lib.check_number(result) .. meas	  	  
	
end   
