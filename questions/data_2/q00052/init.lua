
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
			
small_style = {["font_size"] = "14"}	
			   					
text_style = {["font_size"] = "16"}


ind = {}
price = {}
out = {}

dim = 6
coef = 20 * (30 + math.random(39))

ind[1] = math.random(3)
for i = 2,dim do
    ind[i] = ind[i-1] + math.random(3)
end			
out = lib.math.random_shuffle(ind)

ch = math.random(dim)
for i = 1,dim do
    price[i] = coef * out[i]
end	

min_range = 0
max_range = dim
if (ch == 1) then
    min_range = 1
end	
if (ch == dim) then
    max_range = dim - 1
end	
sig1 = min_range + math.random(max_range - min_range)
if (sig1 == ch) then
    sig1 = sig1 + 1
end	
sig2 = min_range + math.random(max_range - min_range)
if (sig2 == ch) then
    sig2 = sig2 - 1
end	
if (sig2 == sig1) then
    sig2 = sig1 - 1
    if (sig2 < 1) then
	    sig2 = sig1 + 1
    end		
end	 
 
mycanvas = function()

  lib.start_canvas(360, 80, "center")

    wx = 22
    wy = 20	
    ow = 25
    v = 5
	ov = 10

for i = 1,dim+1  do
    lib.add_line(i*2*ow, ov, 0, 3*wy, line_style, false, false)
  end
    lib.add_line(v, ov, 0, 3*wy, line_style, false, false)

  for i = 1,2 do
    lib.add_line(v, i*(wy+ov)+ov, 17*wy+v, 0, line_style, false, false)
  end
    lib.add_line(v, ov, 17*wy+v, 0, line_style, false, false)

  for i = 1,dim do
      lib.add_text(2*i*ow + ow+v, wy+2, out[i], small_style, false, false)
	  if (i == ch) then
          lib.add_text(2*i*ow + ow+v, 2*ow+2, price[i], small_style, false, false)	  
	  else
          lib.add_input(2*i*ow, 2*wy+2, 50, 30, lib.check_number(price[i],35))
	  end
  end
  lib.add_text(ow, wy, "x", text_style, false, false)  
  lib.add_text(ow, 2*wy+ov, "y", text_style, false, false) 

  lib.end_canvas()
end        