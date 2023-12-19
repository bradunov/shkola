
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
	{["off_color"] = "f30",
        ["on_color"] = "f30",
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
ang = {30, 45, 60, 90, 120, 150, 180}
angrad = {}
angrad[1] = math.pi / 6
angrad[2] = math.pi / 4
angrad[3] = math.pi / 3
angrad[4] = math.pi / 2
angrad[5] = 2 * angrad[3]
angrad[6] = angrad[3] + angrad[4]
angrad[7] = math.pi 

sg = math.random(2)
ch = math.random(7)
angle = ang[ch]
rotcos = math.cos(angrad[ch])
rotsin = math.sin(angrad[ch])

ind = math.random(4)

x[1] = dim2 + math.random(dim2-6)
if (ind < 3) then
	y[1] = 3 + math.random(dim2-5)
else
	y[1] = math.random(dim2-3)
end
x[2] = x[1]
y[2] = dim - y[1]
x[5] = x[1] 
y[5] = dim2
dif1 = dim - 2 * y[1]

xaxis = dim2 - 2
yaxis = 1
if (ind == 3) then
    yaxis = dim2 - 2
end

ptx[1] = x[1] - 2 - yaxis
pty[1] = xaxis - y[1] + 2
ptx[2] = x[2] - 2 - yaxis
pty[2] = xaxis - y[2] + 2
ptx[5] = x[5] - 2 - yaxis
pty[5] = xaxis - y[5] + 2

if (ind < 3) then
    rotx = 2*pty[1]*rotsin 
	roty = 2*pty[1]*rotcos	
	ptx[ind+2] = ptx[ind]
	pty[ind+2] = pty[ind]
	x[ind+2] = x[ind]
	y[ind+2] = y[ind]	
    if (ind == 1) then
		if (sg == 1) then
		    ptx[4] = ptx[1] + rotx
		else
		    ptx[4] =  ptx[1] - rotx	
        end 			
		pty[4] = pty[1] - roty 	
    else
		if (sg == 1) then
		    ptx[3] = ptx[2] - rotx
		else
		    ptx[3] = ptx[2] + rotx	
        end 			
		pty[3] = roty + pty[2]		
    end	
	x[5-ind] = ptx[5-ind] + 2 + yaxis
	y[5-ind] = xaxis - pty[5-ind] + 2				
else
    if (ind == 3) then
		if (sg == 1) then
		    ptx[3] = ptx[1]*rotcos - pty[1]*rotsin
		    pty[3] = pty[1]*rotcos + ptx[1]*rotsin			
		    ptx[4] = ptx[2]*rotcos - pty[2]*rotsin
		    pty[4] = pty[2]*rotcos + ptx[2]*rotsin					
		else
		    ptx[3] = ptx[1]*rotcos + pty[1]*rotsin	
		    pty[3] = pty[1]*rotcos - ptx[1]*rotsin			
		    ptx[4] = ptx[2]*rotcos + pty[2]*rotsin	
		    pty[4] = pty[2]*rotcos - ptx[2]*rotsin					
        end 	
    else
		if (sg == 1) then
		    ptx[3] = ptx[1] - pty[1]*rotsin
		    pty[3] = pty[1]*rotcos			
		    ptx[4] = ptx[2] - pty[2]*rotsin
		    pty[4] = pty[2]*rotcos					
		else
		    ptx[3] = ptx[1] + pty[1]*rotsin	
		    pty[3] = pty[1]*rotcos			
		    ptx[4] = ptx[2] + pty[2]*rotsin	
		    pty[4] = pty[2]*rotcos					
        end 
	end
	x[3] = ptx[3] + 2 + yaxis
	y[3] = xaxis - pty[3] + 2	
	x[4] = ptx[4] + 2 + yaxis
	y[4] = xaxis - pty[4] + 2			   	
end	
for i = 3,4 do
	ptx[i] = lib.math.round_dec(ptx[i],1)
	pty[i] = lib.math.round_dec(pty[i],1)
end	

mycanvas = function()

  lib.start_canvas(300, 280, "center")

  w = math.floor(270/dim) 
  ow = 10
  
  for i = 2,dim do
     lib.add_line(ow+(i-1)*w, ow, 0, dim*w, style, false, false)
  end
  
  for i = 2,dim do
    lib.add_line(ow, ow+(i-1)*w, dim*w, 0, style, false, false)
  end

  lib.add_line(ow, ow+(xaxis+2)*w, dim*w, 0, diff_style, false, false)
  lib.add_line(ow+(yaxis+2)*w, ow, 0, dim*w, diff_style, false, false)
  lib.add_straight_path(ow+(dim-1)*w, ow+(xaxis+2)*w-3, {{ow, ow/4}, {-ow, ow/4}}, diff_style, false, false)
  lib.add_text(ow+(dim-1)*w+5, ow+(xaxis+3)*w-3, "x", text_style) 
  lib.add_straight_path(ow+(yaxis+2)*w-3, 2*ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(yaxis+3)*w, 2*ow, "y", text_style) 

  lib.add_line(ow+x[1]*w, ow+y[1]*w, 0, dif1*w, red_style, false, false)
  lib.add_text(x[1]*w, y[1]*w, "A", text_style)  
  lib.add_circle (ow+x[1]*w, ow+y[1]*w, 3, red_style, false, false )   
  lib.add_text(x[2]*w, 2*ow+y[2]*w, "B", text_style) 
  lib.add_circle (ow+x[2]*w, ow+y[2]*w,  3, red_style, false, false ) 
  
--[[  slika duzi 
  lib.add_line(ow+x[3]*w, ow+y[3]*w, (x[4]-x[3])*w, (y[4]-y[3])*w, blue_style, false, false)  
  lib.add_text(2*ow+x[3]*w, 2*ow+y[3]*w, "P", text_style) 
  lib.add_circle (ow+x[3]*w, ow+y[3]*w, 3, blue_style, false, false )   
  lib.add_text(2*ow+x[4]*w, y[4]*w, "Q", text_style) 
  lib.add_circle (ow+x[4]*w, ow+y[4]*w, 3, blue_style, false, false ) 
]]-- 
	if (ind < 3) then
		r = 2*pty[1]*w
		if (ind == 1) then
			xx = ow+x[1]*w 
			yy = ow+y[1]*w
		else
			xx = ow+x[2]*w 
			yy = ow+y[2]*w
		end
	else	
		if (ind == 3) then
			xx = ow+(yaxis+2)*w
			yy = ow+(xaxis+2)*w
			lib.add_text(xx-ow, yy-5, "O", text_style)
			lib.add_circle (xx, yy, 3, diff_style, false, false ) 
			r = w*math.sqrt(ptx[1]^2 + pty[1]^2)
		else
			r = pty[1]*w
			xx = ow+x[5]*w
			yy = ow+y[5]*w	
			lib.add_text(x[5]*w+2*ow, y[5]*w-5, "S", text_style)
			lib.add_circle (ow+x[5]*w, ow+y[5]*w, 3, diff_style, false, false )
		end
	end
	lib.add_circle (xx, yy, r, blue_style, false, false )  
	lib.add_circle (xx, yy, 2, dif_style, false, false )   

  lib.end_canvas()
end                                         
     