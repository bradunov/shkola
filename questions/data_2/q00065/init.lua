
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

index = {}
ind = {}
xp = {}
yp = {}
x = {}
y = {}

qx = {}
qy = {}
trg = {}
hyp = {}

meas = {"dim", "dim\(\small^2\)"}
name = {"A", "B", "C"}

dim = 8
dim2 = 2 * dim

stampa = 3

for i = 1,dim2 do
    index[i] = i
end

ind = lib.math.random_shuffle(index)	
for i = 1,stampa do
    xp[i] = ind[i]
end	
ind = lib.math.random_shuffle(index)
for i = 1,stampa do
    yp[i] = ind[dim2 + 1 - i]
end	

for i = 1,stampa do
    x[i] = xp[i] - dim
    y[i] = dim - yp[i]
end	

comp = 20
tmp = math.abs((y[3]-y[1])*(x[2]-x[1]) - (y[2]-y[1])*(x[3]-x[1]))
if (tmp < comp) then
    for i = 1,5 do
		if (yp[3] < dim) then
			yy = yp[3] + math.random(dim - 2)
		else
			yy = yp[3] - math.random(dim - 2)
		end	
		yy = dim - yy
	    tmp = math.abs((yy-y[1])*(x[2]-x[1]) - (y[2]-y[1])*(x[3]-x[1]))	
        if (tmp > comp) then		
		    y[3] = yy 
			yp[3] = dim - y[3]
	        comp = tmp
		end	
	end	
end

qx = lib.math.argsort(xp)
qy = lib.math.argsort(yp)
		
area = (xp[qx[3]]-xp[qx[1]]) * (yp[qy[3]]-yp[qy[1]])
circ = 0
	
if (qx[2] == qy[2]) then
	coef = (y[qx[3]]-y[qx[1]])/(x[qx[3]]-x[qx[1]])
	check = y[qx[1]] +  coef * (x[qx[2]]-x[qx[1]])           
	if (coef > 0) then	
		trg[1] = math.abs( (xp[qx[2]]-xp[qx[1]]) * (yp[qy[3]]-yp[qy[2]]) )
		hyp[1] = math.sqrt( (xp[qx[2]]-xp[qx[1]])^2 + (yp[qy[3]]-yp[qy[2]])^2 )
		trg[2] = math.abs( (xp[qx[3]]-xp[qx[2]]) * (yp[qy[2]]-yp[qy[1]]) )
		hyp[2] = math.sqrt( (xp[qx[3]]-xp[qx[2]])^2 + (yp[qy[2]]-yp[qy[1]])^2 )	
		hyp[3] = math.sqrt( (xp[qx[3]]-xp[qx[1]])^2 + (yp[qy[3]]-yp[qy[1]])^2 )				
		if (y[qx[2]] > check) then					
			trg[3] = math.abs( (xp[qx[2]]-xp[qx[1]]) * (yp[qy[2]]-yp[qy[1]]) )
		else
			trg[3] = math.abs( (xp[qx[3]]-xp[qx[2]]) * (yp[qy[3]]-yp[qy[2]]) )
		end
	else
		trg[1] = math.abs( (xp[qx[2]]-xp[qx[1]]) * (yp[qy[2]]-yp[qy[1]]) )
		hyp[1] = math.sqrt( (xp[qx[2]]-xp[qx[1]])^2 + (yp[qy[2]]-yp[qy[1]])^2 )
		trg[2] = math.abs( (xp[qx[3]]-xp[qx[2]]) * (yp[qy[3]]-yp[qy[2]]) )
		hyp[2] = math.sqrt( (xp[qx[3]]-xp[qx[2]])^2 + (yp[qy[3]]-yp[qy[2]])^2 )	
		hyp[3] = math.sqrt( (xp[qx[3]]-xp[qx[1]])^2 + (yp[qy[3]]-yp[qy[1]])^2 )				
		if (y[qx[2]] > check) then					
			trg[3] = math.abs( (xp[qx[3]]-xp[qx[2]]) * (yp[qy[2]]-yp[qy[1]]) )
		else
			trg[3] = math.abs( (xp[qx[2]]-xp[qx[1]]) * (yp[qy[3]]-yp[qy[2]]) )
		end
	end	
	area = 0.5 * (area - trg[1]- trg[2]) - trg[3]	

else	

	if (qx[3] == qy[3]) then
		trg[1] = math.abs( (xp[qx[3]]-xp[qx[2]]) * (yp[qy[3]]-yp[qy[1]]) )
		hyp[1] = math.sqrt( (xp[qx[3]]-xp[qx[2]])^2 + (yp[qy[3]]-yp[qy[1]])^2 )
		trg[2] = math.abs( (xp[qx[2]]-xp[qx[1]]) * (yp[qy[2]]-yp[qy[1]]) )
		hyp[2] = math.sqrt( (xp[qx[2]]-xp[qx[1]])^2 + (yp[qy[2]]-yp[qy[1]])^2 )
		trg[3] = math.abs( (xp[qx[3]]-xp[qx[1]]) * (yp[qy[3]]-yp[qy[2]]) )
		hyp[3] = math.sqrt( (xp[qx[3]]-xp[qx[1]])^2 + (yp[qy[3]]-yp[qy[2]])^2 )	
	end		
	if (qx[1] == qy[1]) then
		trg[1] = math.abs( (xp[qx[2]]-xp[qx[1]]) * (yp[qy[3]]-yp[qy[1]]) )
		hyp[1] = math.sqrt( (xp[qx[2]]-xp[qx[1]])^2 + (yp[qy[3]]-yp[qy[1]])^2 )
		trg[2] = math.abs( (xp[qx[3]]-xp[qx[2]]) * (yp[qy[3]]-yp[qy[2]]) )
		hyp[2] = math.sqrt( (xp[qx[3]]-xp[qx[2]])^2 + (yp[qy[3]]-yp[qy[2]])^2 )
		trg[3] = math.abs( (xp[qx[3]]-xp[qx[1]]) * (yp[qy[2]]-yp[qy[1]]) )
		hyp[3] = math.sqrt( (xp[qx[3]]-xp[qx[1]])^2 + (yp[qy[2]]-yp[qy[1]])^2 )
	end		
	if (qx[3] == qy[1]) then
		trg[1] = math.abs( (xp[qx[3]]-xp[qx[1]]) * (yp[qy[2]]-yp[qy[1]]) )
		hyp[1] = math.sqrt( (xp[qx[3]]-xp[qx[1]])^2 + (yp[qy[2]]-yp[qy[1]])^2 )
		trg[2] = math.abs( (xp[qx[2]]-xp[qx[1]]) * (yp[qy[3]]-yp[qy[2]]) )
		hyp[2] = math.sqrt( (xp[qx[2]]-xp[qx[1]])^2 + (yp[qy[3]]-yp[qy[2]])^2 )
		trg[3] = math.abs( (xp[qx[3]]-xp[qx[2]]) * (yp[qy[3]]-yp[qy[1]]) )
		hyp[3] = math.sqrt( (xp[qx[3]]-xp[qx[2]])^2 + (yp[qy[3]]-yp[qy[1]])^2 )
	end
	if (qx[1] == qy[3]) then
		trg[1] = math.abs( (xp[qx[3]]-xp[qx[1]]) * (yp[qy[3]]-yp[qy[2]]) )
		hyp[1] = math.sqrt( (xp[qx[3]]-xp[qx[1]])^2 + (yp[qy[3]]-yp[qy[2]])^2 )
		trg[2] = math.abs( (xp[qx[3]]-xp[qx[2]]) * (yp[qy[2]]-yp[qy[1]]) )
		hyp[2] = math.sqrt( (xp[qx[3]]-xp[qx[2]])^2 + (yp[qy[2]]-yp[qy[1]])^2 )
		trg[3] = math.abs( (xp[qx[2]]-xp[qx[1]]) * (yp[qy[3]]-yp[qy[1]]) )
		hyp[3] = math.sqrt( (xp[qx[2]]-xp[qx[1]])^2 + (yp[qy[3]]-yp[qy[1]])^2 )
	end
	area = area - 0.5 * (trg[1]+ trg[2]+ trg[3])

end
circ = lib.math.round_dec(hyp[1] + hyp[2] + hyp[3], 2)


mycanvas = function()

  lib.start_canvas(260, 240, "center")

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
  lib.add_text(2*ow+v+(dim2-1)*w, (dim+1)*w-w, "x", text_style) 
  lib.add_straight_path(ow+dim*w-3, ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(dim+1)*w-3, v, "y", text_style) 

  lib.add_line(ow+xp[1]*w, ow+yp[1]*w, (xp[2]-xp[1])*w, (yp[2]-yp[1])*w, line_style, false, false) 
  lib.add_line(ow+xp[1]*w, ow+yp[1]*w, (xp[3]-xp[1])*w, (yp[3]-yp[1])*w, line_style, false, false)   
  lib.add_line(ow+xp[2]*w, ow+yp[2]*w, (xp[3]-xp[2])*w, (yp[3]-yp[2])*w, line_style, false, false)   
   
  for i = 1,stampa do
      lib.add_text(v+xp[i]*w, yp[i]*w, name[i], text_style)  
      lib.add_circle (ow+xp[i]*w, ow+yp[i]*w, 2, diff_style, false, false ) 
  end  
  
  lib.end_canvas()
end    
          