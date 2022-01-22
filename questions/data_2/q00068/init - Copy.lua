
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};
		
diff_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
		
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "2"};		
		
text_style = {["font_size"] = "16"}

xp = {}
yp = {}
x = {}
y = {}

meas = {"dim", "dim\(\small^2\)"}
name = {"A", "B", "C", "D"}
coef = {0, 1, 2, 4, 5}

dim = 8
dim2 = 2 * dim

stampa = 4

 
xp[1] = math.random(dim2-1)
yp[1] = math.random(dim2-1)

x[1] = xp[1] - dim
y[1] = dim - yp[1]


if (xp[1] < dim) then
    difx = 2 + math.random(4)
else
    difx = -2 - math.random(4)	
end	

if (yp[1] < dim) then
    dify = 2 + math.random(4)
else
    dify = -2 - math.random(4)	
end	

ind = 2    --[[math.random(5)]]--

if (ind == 1) then
    dify = difx 
    xp[2] = xp[1] + difx
    yp[2] = yp[1] + dify
    xp[3] = xp[2] + dify
    yp[3] = yp[2] - difx
    xp[4] = xp[3] - difx
    yp[4] = yp[3] - dify
end

if (ind == 2) then
    difx = 0
    dify = 2 * dify 
    xp[2] = xp[1] + difx
    yp[2] = yp[1] + dify
    xp[3] = xp[2] + dify
    yp[3] = yp[2] - difx
    xp[4] = xp[3] - difx
    yp[4] = yp[3] - dify
end

if (ind == 3) then
    difx = 2 * difx
    dify = 0.5 * dify  
    xp[2] = xp[1] + difx
    yp[2] = yp[1] + dify
    xp[3] = xp[2] + dify
    yp[3] = yp[2] - difx
    xp[4] = xp[3] - difx
    yp[4] = yp[3] - dify
end
for i = 1,4 do
    x[i] = xp[i] - dim
    y[i] = dim - yp[i]
end    


min_x = -dim
max_x = dim
min_y = -dim
max_y = dim
for i = 1,4 do
    x[i] = xp[i] - dim
    y[i] = dim - yp[i]	
	if (x[i] < min_x) then
	    min_x = x[i]
	end
	if (x[i] > max_x) then
	    max_x = x[i]
	end	
	if (y[i] < min_y) then
	    min_y = y[i]
	end
	if (y[i] > max_y) then
	    max_y = y[i]
	end	
end	

cor_x = 0
cor_y = 0
if (min_x < -dim) then
    cor_x = -min_x - dim + 1
else	
    if (max_x > dim) then
        cor_x = -max_x + dim - 1
	end
end	
if (min_y < -dim) then
    cor_y = -min_y - dim + 1
else	
    if (max_y > dim) then
        cor_y = -max_y + dim - 1
	end
end	
for i = 1,4 do
    x[i] = x[i] + cor_x
	y[i] = y[i] + cor_y
    xp[i] = x[i] + dim		
    yp[i] = dim - y[i]	
end




hyp = math.sqrt( (xp[2]-xp[1])^2 + (yp[2]-yp[1])^2 )

area = lib.math.round_dec(hyp * hyp, 2)
circ = lib.math.round_dec(4 * hyp, 2)


mycanvas = function()

  lib.start_canvas(260, 250, "center")

  w = math.floor(230/dim2) 
  ow = 10
  v = 5
  
  for i = 1,dim2+1 do
     lib.add_line(ow+(i-1)*w, ow, 0, dim2*w, style, false, false)
  end
  
  for i = 1,dim2+1 do
      lib.add_line(ow, ow+(i-1)*w, dim2*w, 0, style, false, false)
  end

  lib.add_line(ow, ow+dim*w, dim2*w, 0, diff_style, false, false)
  lib.add_line(ow+dim*w, ow, 0, dim2*w, diff_style, false, false)
  lib.add_straight_path(ow+(dim2-1)*w, ow+dim*w-3, {{ow, ow/4}, {-ow, ow/4}}, diff_style, false, false)
  lib.add_text(2*ow+v+(dim2-1)*w, ow+(dim+1)*w-3, "x", text_style) 
  lib.add_straight_path(ow+dim*w-3, ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(dim+1)*w-3, v, "y", text_style) 
  
  for i = 1,stampa do
      xcor = xp[i]*w
      ycor = yp[i]*w
      if (xp[i] == 0) then
          xcor = v 
      end
      if (xp[i] == dim2) then
          xcor = xcor - v 
      end	
     if (yp[i] == 0) then
          ycor = v 
      end
      if (yp[i] == dim2) then
          ycor = ycor - v 
      end	  	  
      lib.add_text(xcor, ycor, name[i], text_style)  
      lib.add_circle (ow+xp[i]*w, ow+yp[i]*w, 2, diff_style, false, false ) 
  end  
  
  lib.add_line(ow+xp[1]*w, ow+yp[1]*w, (xp[2]-xp[1])*w, (yp[2]-yp[1])*w, line_style, false, false) 
  lib.add_line(ow+xp[2]*w, ow+yp[2]*w, (xp[3]-xp[2])*w, (yp[3]-yp[2])*w, line_style, false, false)   
  lib.add_line(ow+xp[3]*w, ow+yp[3]*w, (xp[4]-xp[3])*w, (yp[4]-yp[3])*w, line_style, false, false)   
  lib.add_line(ow+xp[4]*w, ow+yp[4]*w, (xp[1]-xp[4])*w, (yp[1]-yp[4])*w, line_style, false, false)    
 
  lib.end_canvas()
end          