
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
coef = {0, 0.25, 0.5, 1, 2, 4}

dim = 8
dim2 = 2 * dim

stampa = 4

x[5] = 4 - dim + math.random(dim-1)
y[5] = 4 - dim + math.random(dim-1)

ind = math.random(6)

difx = 3 - math.floor(0.5*ind)  + math.random(3)
dify = coef[ind] * difx

modx = difx + 2 + math.random(3)
mody = coef[ind] * modx

ch = math.random(3)

if (ch == 1) then              --[[kvadrat]]--
	x[1] = x[5] + difx
	y[1] = y[5] + dify
	x[2] = x[5] - dify
	y[2] = y[5] + difx	
	x[3] = x[5] - difx
	y[3] = y[5] - dify	
	x[4] = x[5] + dify
	y[4] = y[5] - difx
end
if (ch == 2) then              --[[romb]]--
	x[1] = x[5] + modx
	y[1] = y[5] + mody
	x[2] = x[5] - dify
	y[2] = y[5] + difx	
	x[3] = x[5] - modx
	y[3] = y[5] - mody	
	x[4] = x[5] + dify
	y[4] = y[5] - difx
end
if (ch == 3) then              --[[deltoid]]--
	x[1] = x[5] + difx
	y[1] = y[5] + dify
	x[2] = x[5] - dify
	y[2] = y[5] + difx	
	x[3] = x[5] - modx
	y[3] = y[5] - mody	
	x[4] = x[5] + dify
	y[4] = y[5] - difx
end

for i = 1,5 do
    xp[i] = x[i] + dim
    yp[i] = dim - y[i]
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
for i = 1,5 do
    x[i] = x[i] + cor_x
	y[i] = y[i] + cor_y
    xp[i] = x[i] + dim		
    yp[i] = dim - y[i]	
end

diag = math.sqrt( difx^2 + dify^2 )
edge = diag * math.sqrt(2)
if (ch == 1) then	
	area = 2 * diag^2
    diag = 2 * diag	
	circ = 4 * edge
else
    diag_mod = math.sqrt( modx^2 + mody^2 )
	edge_mod = math.sqrt(diag^2 + diag_mod^2)	
    if (ch == 2) then	
	    area = 2 * diag * diag_mod
		diag = 2 * diag
        diag_mod = 2 * diag_mod		
	    circ = 4 * edge_mod		
	else			
	    area = diag * (diag + diag_mod)	
		diag_mod = diag + diag_mod
		diag = 2 * diag		
	    circ = 2 * (edge + edge_mod)			
    end
end	
diag = lib.math.round_dec(diag, 2)
area = lib.math.round_dec(area, 2)
circ = lib.math.round_dec(circ, 2)


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