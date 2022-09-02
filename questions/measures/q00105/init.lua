
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

colour_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "1"};

brown_style = 
	{["off_color"] = "c90",
        ["on_color"] = "c90",
        ["line_color"] = "000",
        ["line_width"] = "1"};

orange_line = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "f90",
        ["line_width"] = "6"};

green_line = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "6f6",
        ["line_width"] = "3"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "14"}

step = math.pi/30

w = 5 
ow = 10
ov = 15
wy = 100
oc = 150
  
index = math.random(2)

ind_h = math.random(12) - 1

numb_h = ind_h 
if (index == 2) then
    numb_h = numb_h + 12
end

hour = name[3]
if (numb_h == 1 or numb_h == 21) then
    hour = name[1] 
end
if (numb_h > 1 and numb_h < 5) then
    hour = name[2] 
end
if (numb_h == 22 or numb_h == 23) then
    hour = name[2] 
end	

ind_m = math.random(15) - 1 

cosmin = wy * math.cos(ind_m * step)
sinmin = wy * math.sin(ind_m * step)

sgx = math.random(2)
sgy = math.random(2)
if (sgx ==1) then
    if (sgy == 1) then    
       numb_m = ind_m 
       xm = sinmin	   
	   ym = -cosmin
  	else  
       numb_m = ind_m + 15
	   xm = cosmin
	   ym = sinmin	   
	end
else	
    if (sgy == 1) then  
       numb_m = ind_m + 30
	   xm = -sinmin
	   ym = cosmin		
  	else  
       numb_m = ind_m + 45
       xm = -cosmin	   
	   ym = -sinmin	      
	end
end	

cor = 0.02 * (wy - ow)
ad = cor * numb_m  * 0.25	
if (ind_h>2 and ind_h < 9) then
 xad = -ad
else
 xad = ad
end
if (ind_h < 6) then
 yad = ad
else
 yad = -ad
end
  
cos0 =  wy - ow
cos60 = (wy - ow) * 0.5
cos30 = cos60 * math.sqrt (3)

if (ind_h == 0 or ind_h == 6) then
    xh = 0
	if (ind_h == 0) then
	    yh = - cos0
	else
	    yh = cos0
	end	
end
if (ind_h == 3 or ind_h == 9) then
    yh = 0
	if (ind_h == 3) then
	    xh = cos0
	else
	    xh = -cos0	
	end	
end

if (ind_h == 1 or ind_h == 5) then
	xh = cos60
	if (ind_h == 1) then
	    yh = -cos30
	else
	    yh = cos30	
	end	
end

if (ind_h == 7 or ind_h == 11) then
	xh = -cos60
	if (ind_h == 7) then
	    yh = cos30
	else
	    yh = -cos30	
	end	
end

if (ind_h == 2 or ind_h == 4) then
	xh = cos30
	if (ind_h == 2) then
	    yh = -cos60
	else
	    yh = cos60	
	end	
end

if (ind_h == 8 or ind_h == 10) then
	xh = -cos30
	if (ind_h == 8) then
	    yh = cos60
	else
	    yh = -cos60	
	end	
end
	
mycanvas = function()

  lib.start_canvas(300, 300, "center")

  lib.add_circle (oc, 2*ow, ow, brown_style, true, false )
  lib.add_ellipse(oc, 2*ov+ow, 2*ov, ov, colour_style, true, false )

  lib.add_circle (oc, oc, wy+ow, colour_style, true, false )
  lib.add_circle (oc, oc, wy, style, true, false )

  lib.add_circle (oc-3*ov, 2*(oc-ov)-ow, ow, brown_style, true, false )
  lib.add_circle (oc+3*ov, 2*(oc-ov)-ow, ow, brown_style, true, false )
 
  lib.add_straight_path(oc, wy/2, {{0, ov}}, style,  false, false)
  lib.add_text(oc, wy/2+2*ow, "12", text_style, false, false)  
  lib.add_straight_path(oc+wy/2, 2*wy/3, {{-w, ow}}, style,  false, false)
  lib.add_text(oc+wy/2-ow, 2*wy/3+2*ow-w, "1", text_style, false, false)   
  lib.add_straight_path(oc+2*wy/3+2*ow, wy, {{-ow, ow}}, style,  false, false)
  lib.add_text(oc+2*wy/3, wy+w, "2", text_style, false, false)

  lib.add_straight_path(oc+wy-ov, oc, {{ ov, 0}}, style,  false, false)
  lib.add_text(oc+wy-2*ow, oc, "3", text_style, false, false)   
  lib.add_straight_path(oc+2*wy/3+2*ow, oc+2*wy/3-ov-2, {{-ow, -ow}}, style,  false, false)
  lib.add_text(oc+2*wy/3, oc+wy/2-ov, "4", text_style, false, false)  
  lib.add_straight_path(oc+wy/2, oc+wy-ov, {{-w, -ow}}, style,  false, false) 
  lib.add_text(oc+wy/2-ow, oc+2*wy/3, "5", text_style, false, false)   
  
  lib.add_straight_path(oc, oc+wy-ov, {{0, ov}}, style,  false, false)
  lib.add_text(oc, oc+wy-ov-ow, "6", text_style, false, false) 
  lib.add_straight_path(2*wy/3+3*ow+3, oc+wy-ov, {{w, -ow}}, style,  false, false)
  lib.add_text(wy+w, oc+2*wy/3, "7", text_style, false, false)  
  lib.add_straight_path(wy/2+ov+1, oc+2*wy/3-ov-w+1, {{ow, -ow}}, style,  false, false)  
  lib.add_text(2*wy/3+ov, oc+wy/2-ow, "8", text_style, false, false)   

  lib.add_straight_path(oc-wy, oc, {{ ov, 0}}, style,  false, false)
  lib.add_text(wy-2*ov, oc, "9", text_style, false, false)  
  lib.add_straight_path(wy/2+ov-2, wy, {{ow, ow}}, style,  false, false)
  lib.add_text(2*wy/3+ov, wy+ow, "10", text_style, false, false) 

  lib.add_straight_path(2*wy/3+3*ow+w, 2*wy/3, {{3, ow}}, style,  false, false)    
  lib.add_text(wy+w, 2*wy/3+ov, "11", text_style, false, false) 
  
  scal = (wy - ow)/math.sqrt((xh+xad)^2+(yh+yad)^2)
  xx = (xh+xad) * scal
  yy = (yh+yad) * scal
  lib.add_straight_path(oc, oc, {{xx, yy}}, orange_line,  false, false)
  
  lib.add_straight_path(oc, oc, {{xm, ym}}, green_line,  false, false)
  lib.add_text(oc, oc-ow, ".", dot_style, false, false)
 
for i = 1,15 do
  x = math.cos(i * step)
  y = math.sin(i * step)
  lib.add_straight_path(oc+wy*x, oc+wy*y, {{-w*x, -ow*y}}, style,  false, false)
  lib.add_straight_path(oc-wy*x, oc+wy*y, {{w*x, -ow*y}}, style,  false, false) 
  lib.add_straight_path(oc-wy*x, oc-wy*y, {{w*x, ow*y}}, style,  false, false)

  lib.add_straight_path(oc+wy*x, oc-wy*y, {{-w*x, ow*y}}, style,  false, false)
end 
       
  lib.end_canvas()
end      