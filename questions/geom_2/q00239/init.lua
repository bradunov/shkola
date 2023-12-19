
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
diff_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

red_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f30",
        ["line_width"] = "2"};			

blue_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "0cf",
        ["line_width"] = "1"};			

text_style = {["font_size"] = "16"}

x = {}
y = {}
ptx = {}
pty = {}

dim = 16
dim2 = 8
ang = {90, 180}

sg = math.random(2)
ch = math.random(2)

ind = math.random(3)

angle = tostring(ang[ch]) .. "°"

x[1] = 2 + math.random(dim2-5)
y[1] = dim2 + 2 + math.random(4)
x[2] = dim - x[1]
y[2] = dim2
x[3] = dim2
y[3] = dim - y[1]

xaxis = dim2 - 2
yaxis = dim2 - 2

for i = 1,3 do
	ptx[i] = x[i] - 2 - yaxis
	pty[i] = xaxis - y[i] + 2
end

if (ind == 1) then
	ptx[6] = ptx[3]	
	pty[6] = pty[3]	
	ptx[7] = ptx[3]	
	pty[7] = pty[3]	
	if (ch == 1) then		
		if (sg == 1) then
			ptx[4] = pty[3] - pty[1]
			pty[4] = pty[3]	+ ptx[1]			
			ptx[5] = pty[3]
			pty[5] = pty[3]	+ ptx[2]		
		else
			ptx[4] = - pty[3] + pty[1] 
			pty[4] = pty[3]	- ptx[1]
			ptx[5] =  -pty[3]	
			pty[5] = pty[3]	- ptx[2]			
		end 
	else	
		for i = 1,2 do		
			ptx[i+3] = - ptx[i]
			pty[i+3] = 2*pty[3] - pty[i]			
		end 
	end	
end
if (ind == 2) then
	ptx[7] = 0	
	pty[7] = 0				
	for i = 1,3 do
		if (ch == 1) then
			if (sg == 1) then
				ptx[i+3] = - pty[i]
				pty[i+3] =  ptx[i]	
			else   
				ptx[i+3] = pty[i]
				pty[i+3] = - ptx[i]	
			end			
		else		
			ptx[i+3] = - ptx[i]
			pty[i+3] = - pty[i]			
		end
	end	
end
if (ind == 3) then
	ptx[7] = (ptx[2] + ptx[3])/2
	pty[7] = (pty[2] + pty[3])/2		
	if (ch == 1) then
		if (sg == 1) then
			ptx[4] = ptx[7] - pty[1] + pty[7]
			pty[4] = pty[7] + ptx[1] - ptx[7]				
			ptx[5] = ptx[7] + pty[7]
			pty[5] = pty[7] + ptx[2] - ptx[7]	
			ptx[6] = ptx[7] - pty[7]
			pty[6] = pty[7] - ptx[2] + ptx[7]					
		else  
			ptx[4] = ptx[7] - pty[7] + pty[1]
			pty[4] = pty[7] + ptx[7] - ptx[1]			
			ptx[5] = ptx[7] - pty[7]
			pty[5] = pty[7] - ptx[2] + ptx[7]	
			ptx[6] = ptx[7] + pty[7]
			pty[6] = pty[7] + ptx[2] - ptx[7]					
		end			
	else	
		ptx[4] = 2*ptx[7] - ptx[1]
		pty[4] = 2*pty[7] - pty[1]			
		ptx[5] = ptx[3]
		pty[5] = pty[3]			
		ptx[6] = ptx[2]		
		pty[6] = pty[2]				
	end	
end

for i = 4,7 do
	x[i] = ptx[i] + 2 + yaxis
	y[i] = xaxis - pty[i] + 2	
	ptx[i] = lib.math.round_dec(ptx[i],1)
	pty[i] = lib.math.round_dec(pty[i],1)	
end		


mycanvas = function()

  lib.start_canvas(300, 280, "center")

  w = math.floor(270/dim) 
  ow = 10
  
  for i = 2,dim+4 do
     lib.add_line(ow+(i-1)*w, ow, 0, dim*w, style, false, false)
  end
  
  for i = 2,dim do
    lib.add_line(ow, ow+(i-1)*w, (dim+4)*w, 0, style, false, false)
  end

  lib.add_line(ow, ow+(xaxis+2)*w, dim*w, 0, diff_style, false, false)
  lib.add_line(ow+(yaxis+2)*w, ow, 0, dim*w, diff_style, false, false)
  lib.add_straight_path(ow+(dim-1)*w, ow+(xaxis+2)*w-3, {{ow, ow/4}, {-ow, ow/4}}, diff_style, false, false)
  lib.add_text(ow+(dim-1)*w+5, ow+(xaxis+3)*w-3, "x", text_style) 
  lib.add_straight_path(ow+(yaxis+2)*w-3, 2*ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(yaxis+3)*w, 2*ow, "y", text_style) 

  lib.add_straight_path(ow+x[1]*w, ow+y[1]*w, {{(x[2]-x[1])*w, (y[2]-y[1])*w}, {(x[3]-x[2])*w, (y[3]-y[2])*w}, {(x[1]-x[3])*w, (y[1]-y[3])*w}}, red_style, false, false)
  lib.add_text(x[1]*w, y[1]*w, "A", text_style)  
  lib.add_circle (ow+x[1]*w, ow+y[1]*w, 2, red_style, false, false )   
  lib.add_text(ow+x[2]*w, 2*ow+y[2]*w, "B", text_style) 
  lib.add_circle (ow+x[2]*w, ow+y[2]*w,  2, red_style, false, false ) 
  lib.add_text(x[3]*w, ow+y[3]*w, "C", text_style) 
  lib.add_circle (ow+x[3]*w, ow+y[3]*w,  2, red_style, false, false )   
--[[
  lib.add_straight_path(ow+x[4]*w, ow+y[4]*w, {{(x[5]-x[4])*w, (y[5]-y[4])*w}, {(x[6]-x[5])*w, (y[6]-y[5])*w}, {(x[4]-x[6])*w, (y[4]-y[6])*w}}, blue_style, false, false)
  lib.add_text(2*ow+x[4]*w, 2*ow+y[4]*w, "P", text_style) 
  lib.add_circle (ow+x[4]*w, ow+y[4]*w, 3, blue_style, false, false )   
  lib.add_text(2*ow+x[5]*w, y[5]*w, "Q", text_style) 
  lib.add_circle (ow+x[5]*w, ow+y[5]*w, 3, blue_style, false, false ) 
  lib.add_text(2*ow+x[6]*w, y[6]*w, "R", text_style) 
  lib.add_circle (ow+x[6]*w, ow+y[6]*w, 3, blue_style, false, false ) 
]]-- 
	xx = ow+x[7]*w 
	yy = ow+y[7]*w
	ra = w * math.sqrt((ptx[7]-ptx[1])^2+(pty[7]-pty[1])^2) 
	rb = w * math.sqrt((ptx[7]-ptx[2])^2+(pty[7]-pty[2])^2) 
	rc = w * math.sqrt((ptx[7]-ptx[3])^2+(pty[7]-pty[3])^2) 		
	if (ind ~= 1) then	
		if (ind == 2) then
			lib.add_text(ow+x[7]*w, ow+y[7]*w, "O", text_style)
		else
			lib.add_text(ow+x[7]*w, ow+y[7]*w, "S", text_style)		
		end	
	end		
	lib.add_circle (ow+x[7]*w, ow+y[7]*w, 2, diff_style, false, false ) 

	lib.add_circle (ow+x[7]*w, ow+y[7]*w, ra, blue_style, false, false )  
	lib.add_circle (ow+x[7]*w, ow+y[7]*w, rb, blue_style, false, false )
	lib.add_circle (ow+x[7]*w, ow+y[7]*w, rc, blue_style, false, false )  
	  

  lib.end_canvas()
end                                         
             