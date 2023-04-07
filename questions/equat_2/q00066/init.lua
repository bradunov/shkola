
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
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

text_style = {["font_size"] = "14"}

enum = {}
denom = {}

dim = 16
dim2 = 8

ch = math.random(2)
if (ch == 2) then
	xf = math.random(dim2-1)
	if (xf > 1) then
        yf = 1
    else		
	    yf = math.random(dim2 - 1)
    end	
	xs = dim2 + math.random(dim2-1)
	if (xs < dim-1) then
        ys = dim-1 
    else		
	    ys = dim2 + math.random(dim2 - 1)
    end			
else
	xf = dim2 + math.random(dim2-1)
	if (xf < dim-1) then
        yf = 1
    else		
	    yf = math.random(dim2 - 1)
    end	
	xs = math.random(dim2-1)
	if (xs > 1) then
        ys = dim-1 
    else		
	    ys = dim2 + math.random(dim2 - 1)
    end			
end
		
difx = xs - xf
dify = ys - yf

coef = ""
enum[1] = -dify
denom[1] = difx
if (denom[1] < 0) then
    enum[1] = - enum[1]
	denom[1] = - denom[1]
end	
qq = lib.math.gcd(enum[1], denom[1])
enum[1] = math.floor(enum[1]/qq)
denom[1] = math.floor(denom[1]/qq)
if (denom[1] == 1) then
	ch = 0
else
	tmp = enum[1]/denom[1]
	rest = 10*tmp - math.floor(10*tmp)				
	if (rest == 0) then
		enum[1] = 10 * tmp
		denom[1] = 10
		ch = 1
	else
		ch = 2			
	end
end	
if (ch < 2) then
	coef = lib.check_number(lib.math.round_dec(enum[1]/denom[1],1))
else
	coef = lib.check_fraction_simple(enum[1], denom[1])					
end

min_range = 2
max_range = dim - 4 - min_range
xaxis = min_range + math.random(max_range - min_range)
yaxis = min_range + math.random(max_range - min_range)
ax = xf - 2 - yaxis
ay = xaxis - yf + 2
bx = xs - 2 - yaxis
by = xaxis - ys + 2

zero = ""
enum[2] = ax*dify + ay*difx
denom[2] = dify
if (denom[2] < 0) then
    enum[2] = - enum[2]
	denom[2] = - denom[2]
end	
qq = lib.math.gcd(enum[2], denom[2])
enum[2] = math.floor(enum[2]/qq)
denom[2] = math.floor(denom[2]/qq)
if (denom[2] == 1) then
	ch = 0
else
	tmp = enum[2]/denom[2]
	rest = 10*tmp - math.floor(10*tmp)				
	if (rest == 0) then
		enum[2] = 10 * tmp
		denom[2] = 10
		ch = 1
	else
		ch = 2			
	end
end	
if (ch < 2) then
	zero = lib.check_number(lib.math.round_dec(enum[2]/denom[2],1))
else
	zero = lib.check_fraction_simple(enum[2], denom[2])					
end

free = ""
enum[3] = ay*difx + ax*dify
denom[3] = difx
if (denom[3] < 0) then
    enum[3] = - enum[3]
	denom[3] = - denom[3]
end	
qq = lib.math.gcd(enum[3], denom[3])
enum[3] = math.floor(enum[3]/qq)
denom[3] = math.floor(denom[3]/qq)
if (denom[3] == 1) then
	ch = 0
else
	tmp = enum[3]/denom[3]
	rest = 10*tmp - math.floor(10*tmp)				
	if (rest == 0) then
		enum[3] = 10 * tmp
		denom[3] = 10
		ch = 1
	else
		ch = 2			
	end
end	
if (enum[3] ~= 0) then
    if (enum[3] < 0) then
		sign = "-"
		tmp = - enum[3]
	else
		sign = "+"	
		tmp = enum[3]		
	end	
    free = free .. lib.check_string(sign, 10)	
	if (ch < 2) then
		free = free .. lib.check_number(lib.math.round_dec(tmp/denom[3],1))
	else
		free = free .. lib.check_fraction_simple(tmp, denom[3])					
	end
end


mycanvas = function()

  lib.start_canvas(220, 200, "center")

  w = math.floor(190/dim) 
  ow = 10
  
  for i = 2,dim do
     lib.add_line(ow+(i-1)*w, ow, 0, dim*w, style, false, false)
  end
  
  for i = 2,dim do
    lib.add_line(ow, ow+(i-1)*w, dim*w, 0, style, false, false)
  end
--[[x osa ]]--
  lib.add_line(ow, ow+(xaxis+2)*w, dim*w, 0, diff_style, false, false)
  lib.add_straight_path(ow+dim*w, ow+(xaxis+2)*w-3, {{ow, ow/4}, {-ow, ow/4}}, diff_style, false, false)
  lib.add_text(ow+dim*w+5, ow+(xaxis+3)*w-3, "x", text_style)   
--[[y osa ]]--  
  lib.add_line(ow+(yaxis+2)*w, ow, 0, dim*w, diff_style, false, false)
  lib.add_straight_path(ow+(yaxis+2)*w-3, 2*ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(yaxis+3)*w, 2*ow, "y", text_style) 

--[[linija ]]--
  dx = difx/dify
  xx = xf - dx
  lib.add_line(ow+xx*w, ow+(yf-1)*w, (difx+2*dx)*w, (dify+2)*w, red_style, false, false)
  lib.add_text(xf*w, yf*w, "A", text_style)  
  lib.add_circle (ow+xf*w, ow+yf*w, 2, blue_style, false, false )    
  lib.add_text(xs*w, ys*w, "B", text_style) 
  lib.add_circle (ow+xs*w, ow+ys*w, 2, blue_style, false, false )   

  lib.end_canvas()
end      