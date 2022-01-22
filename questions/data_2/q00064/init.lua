
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
		
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "2"};		
		
text_style = {["font_size"] = "16"}

index = {}
ind = {}
xp = {}
yp = {}
x = {}
y = {}

meas = {"dim", "dim\(\small^2\)"}
name = {"A", "B", "C"}

dim = 8
dim2 = 2 * dim

stampa = 3

for i = 1,dim2 do
    index[i] = i
end

ind = lib.math.random_shuffle(index)	
xp[1] = ind[1]
xp[2] = ind[2]
xp[3] = xp[1]

ind = lib.math.random_shuffle(index)
yp[1] = ind[1]
yp[2] = yp[1]
yp[3] = ind[2]	

for i = 1,stampa do
    x[i] = xp[i] - dim
    y[i] = dim - yp[i]
end	

area = 0.5 * (x[2]-x[1]) * (y[3]-y[1]) 
if (area < 0) then
    area = - area
end
	
tmp = math.sqrt ((x[2]-x[1])^2 + (y[3]-y[1])^2)
circ = math.abs(x[2]-x[1]) + math.abs(y[3]-y[1]) + tmp
circ = lib.math.round_dec(circ, 2)


mycanvas = function()

  lib.start_canvas(260, 260, "center")

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
      lib.add_text(xp[i]*w, yp[i]*w, name[i], text_style)  
      lib.add_circle (ow+xp[i]*w, ow+yp[i]*w, 2, diff_style, false, false ) 
  end  
  
  lib.add_line(ow+xp[1]*w, ow+yp[1]*w, (xp[2]-xp[1])*w, 0, line_style, false, false) 
  lib.add_line(ow+xp[1]*w, ow+yp[1]*w, 0, (yp[3]-yp[1])*w, line_style, false, false)   
  lib.add_line(ow+xp[2]*w, ow+yp[2]*w, (xp[3]-xp[2])*w, (yp[3]-yp[2])*w, line_style, false, false)   
 
  lib.end_canvas()
end          
            