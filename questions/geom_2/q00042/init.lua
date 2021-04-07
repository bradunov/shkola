
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};
		
line_style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};

diff_style = 
	{["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "1"};
				
dot_style = {["font_size"] = "40"}

text_style = {["font_size"] = "16"}	

grid = 12
w = 100
ow = 25
v = 10

ind = math.random(3)

if (ind == 1) then
     x = 1 + math.random(4)
     y = 12 - 2*x + math.random(2*x-3)
	 xa = v+x*ow
	 ya = y*ow-v
	 xb = v+(11-x)*ow 
	 yb = y*ow-v 
end  	 

if (ind == 2) then
     rr = 5 
	 rw = rr * ow
     x1 = math.random(rr-1) 
     bound = math.floor((rr^2 - x1^2)^0.5)
	 y1 = math.random(bound) 
     xa = v+(rr+1-x1)*ow
     sign = math.random(2)
     if (sign == 1) then
        ya = v+(rr+y1)*ow
     else
        ya = v+(rr+1-y1)*ow
     end
	 ch1 = (xa-rw)^2 + (ya-rw)^2
	 if (ch1*ch1 >= rw*rw-ow) then
	     if (ya < rw) then         
             ya = ya + 3*ow	
         else
             ya = ya - 3*ow	
         end			 
     end		 
     x2 = math.random(rr-1) 
     bound = math.floor((rr^2 - x2^2)^0.5)
	 y2 = math.random(bound) 
        xb = v+(rr+1+x2)*ow
     sign = math.random(2)
     if (sign == 1) then
        yb = v+(rr+1-y2)*ow
     else
        yb = v+(rr+1+y2)*ow
     end
	 ch2 = (xb-rw)^2 + (yb-rw)^2
	 if (ch2*ch2 >= rw*rw-ow) then
	     if (yb < rw) then         
             ya = yb + 3*ow	
         else
             ya = yb - 3*ow	
         end			 		
     end		 
end	 

if (ind == 3) then
     rx = 5 
	 ry = 8
     x1 = math.random(rx-1)      
	 y1 = 1 + math.random(ry) 
     xa = v+x1*ow
     ya = y1*ow 	 
     x2 = rx + math.random(rx-1) 
	 y2 = 1 + math.random(ry)  
     xb = v+x2*ow
     yb = y2*ow 
end	 

mycanvas = function()

  lib.start_canvas(320, 320, "center", "result[0] == 0 && result[1] == 0 && result[2] == 1")

  if(ind == 1) then
     lib.add_triangle (2*ow+w-2, 2*ow+w-3, 2*w+ow, 2*w+ow, diff_style, false, false)
     lib.add_line(v+ow, w+v, 2*w+ow+v, w+2*ow+v-2, line_style, false, true)	
     lib.add_line(ow, v+ya+2, 2*(w+ow), 0, line_style, false, true)
     lib.add_line(6*ow-2, ow/2, 0, 2*(w+ow)+v, line_style, false, true)	 
     lib.add_text(xa, ya, ".", dot_style, false, false) 
     lib.add_text(xa, ya, "A", text_style, false, false) 
     lib.add_text(xb, yb, ".", dot_style, false, false) 
     lib.add_text(xb, yb, "B", text_style, false, false) 	  
  end

  if(ind == 2) then
     lib.add_circle (v+(rr+1)*ow, v+(rr+1)*ow, rr*ow+v, diff_style, false, false )	
     lib.add_line(v+(rr+1)*ow, v, 0, 2*(rr+1)*ow, line_style, false, true)	 
	 kk = (yb-ya)/(xb-xa) 	 
     lib.add_line(ow, v+ya-kk*(xa-ow), xb-xa+2*w, yb-ya+kk*2*w, line_style, false, true)	 
	 if (kk ~= 0) then
	     kn = -1/kk
         lib.add_line(v, v+(yb+ya)/2-kn*((xb+xa)/2-v), xb+xa+ow, kn*(xb+xa+ow), line_style, false, true) 		 
     else		 
         lib.add_line((xb+xa)/2, v+ow, 0, 2*rr*ow, line_style, false, true) 
	 end
     lib.add_text(xa, ya, ".", dot_style, false, false) 
     lib.add_text(xa, ya, "A", text_style, false, false) 
     lib.add_text(xb, yb, ".", dot_style, false, false) 
     lib.add_text(xb, yb, "B", text_style, false, false) 	  
 end
 
  if(ind == 3) then  
     lib.add_rectangle (v+ow, v+2*ow, 2*(w+ow), 2*w, diff_style, false, false)  
     lib.add_line(v+(rx+1)*ow, v+ow, 0, (ry+2)*ow, line_style, false, true)
	 kk = (yb-ya)/(xb-xa) 	 
     lib.add_line(v+ow, v+ya-kk*(xa-ow-v), xb-xa+6*ow, yb-ya+kk*6*ow, line_style, false, true)	 
	 if (kk ~= 0) then
	     kn = -1/kk
         lib.add_line(v+ow, v+(yb+ya)/2-kn*((xb+xa)/2-ow-v), xb+xa+ow, kn*(xb+xa+ow), line_style, false, true) 		 
     else		 
         lib.add_line((xb+xa)/2, v+ow, 0, (ry+2)*ow, line_style, false, true) 
	 end	 
     lib.add_text(xa, ya, ".", dot_style, false, false) 
     lib.add_text(xa, ya, "A", text_style, false, false) 
     lib.add_text(xb, yb, ".", dot_style, false, false) 
     lib.add_text(xb, yb, "B", text_style, false, false) 	 	 
  end
  
   for i = 1,grid+1 do
    lib.add_line(v, v+(i-1)*ow, grid*ow, 0, style, false, false)
  end

  for i = 1,grid+1 do
    lib.add_line(v+(i-1)*ow, v, 0, grid*ow, style, false, false)
  end
  
  lib.end_canvas()
end
    
        
            
 
                 
          
                    
           
     