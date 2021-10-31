
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
		
text_style = {["font_size"] = "16"}

index = {}
ind = {}
xp = {}
yp = {}
x = {}
y = {}
answ = {" "}

name = {"A", "B", "C", "D", "E", "F"}

dim = 8
dim2 = 2 * dim

stampa = 6

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
for j = 1, math.floor(stampa/2) do

answ[j] = " "
    for i = 1, 2 do
        answ[j] = answ[j] .. name[2*(j-1)+i] .. " = (" .. lib.check_number(x[2*(j-1)+i], 20) .. "," .. lib.check_number(y[2*(j-1)+i], 20) .. ") ," .. "\(\ \ \ \ \)"
	end
end

mycanvas = function()

  lib.start_canvas(300, 290, "center")

  w = math.floor(280/dim2) 
  ow = 10
  
  for i = 1,dim2+1 do
     lib.add_line(ow+(i-1)*w, ow, 0, dim2*w, style, false, false)
  end
  
  for i = 1,dim2+1 do
      lib.add_line(ow, ow+(i-1)*w, dim2*w, 0, style, false, false)
  end

  lib.add_line(ow, ow+dim*w, dim2*w, 0, diff_style, false, false)
  lib.add_line(ow+dim*w, ow, 0, dim2*w, diff_style, false, false)

 
  lib.add_straight_path(ow+(dim2-1)*w, ow+dim*w-3, {{ow, ow/4}, {-ow, ow/4}}, diff_style, false, false)
  lib.add_text(ow+(dim2-1)*w+5, ow+(dim+1)*w-3, "x", text_style) 
  lib.add_straight_path(ow+dim*w-3, 2*ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(dim+1)*w-3, 2*ow, "y", text_style) 
  
  for i = 1,stampa do
      lib.add_text(xp[i]*w, yp[i]*w, name[i], text_style)  
      lib.add_circle (ow+xp[i]*w, ow+yp[i]*w, 3, diff_style, false, false ) 
  end  
 
  lib.end_canvas()
end           