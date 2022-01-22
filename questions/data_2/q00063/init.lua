
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
text_style = {["font_size"] = "16"}

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
small_style = {["font_size"] = "14"}	
colour_style = {["off_line_color"] = "f30",
               ["font_size"] = "16"}


index = {}
ind = {}
xp = {}
yp = {}
x = {}
y = {}
out = {}
left = {}
right = {}
title = {}
dist = {}
med_x = {}
med_y = {}


name = {"A", "B", "C", "D", "E", "F"}
nr_name = 6
--[[
pair = {"AB", "AC", "AD", "AE", "AF","BC", "BD","BE","BF","CD", "CE", "CF","DE", "DF","EF"}
]]--
pair_co = {12, 13, 14, 15, 16, 23, 24, 25, 26, 34, 35, 36, 45, 46, 56}
nr_pair = 15
pair = {}
pair[1] = {"", "AB", "AC", "AD", "AE", "AF"}
pair[2] = {"", "", "BC", "BD","BE","BF"}
pair[3] = {"", "", "", "CD", "CE", "CF"}
pair[4] = {"", "", "", "", "DE", "DF"}
pair[5] = {"", "", "", "", "", "EF"}

dim = 8
dim2 = 2 * dim

stampa = 4
stamp2 = math.floor(stampa/2)

for i = 1,dim2 do
    index[i] = i
end

ind = lib.math.random_shuffle(index)	
for i = 1,nr_name do
    xp[i] = ind[i]
end	
ind = lib.math.random_shuffle(index)
for i = 1,nr_name do
    yp[i] = ind[dim2 + 1 - i]
end	

for i = 1,nr_name do
    x[i] = xp[i] - dim
    y[i] = dim - yp[i]
end	

out = lib.math.random_shuffle(pair_co)
for i = 1,stampa do
    whole = math.floor(out[i]*0.1)
	rest = out[i] - 10*whole
	for wh = 1, nr_name-1 do
	    if (wh == whole) then
	        left[i] = wh
		    for rst = wh+1, nr_name do
		        if (rst == rest) then
	                right[i] = rst
				    title[i] = pair[wh][rst]
	                dist[i] = lib.math.round_dec(math.sqrt((x[left[i]]-x[right[i]])^2 + (y[left[i]]-y[right[i]])^2),2)
	                med_x[i] = lib.math.round_dec((x[left[i]]+x[right[i]])/2, 1)
	                med_y[i] = lib.math.round_dec((y[left[i]]+y[right[i]])/2, 1)						
			    end
            end
    	end
    end
end


mycanvas = function()

  lib.start_canvas(350, 385, "center")

  ws = math.floor(230/dim2) 
  ow = 10
  w = 50
  ov = 15
  v = 5
  
  for i = 1,dim2+1 do
     lib.add_line(w+(i-1)*ws, ow, 0, dim2*ws, style, false, false)
  end
  
  for i = 1,dim2+1 do
      lib.add_line(w, ow+(i-1)*ws, dim2*ws, 0, style, false, false)
  end

  lib.add_line(w, ow+dim*ws, dim2*ws, 0, line_style, false, false)
  lib.add_line(w+dim*ws, ow, 0, dim2*ws, line_style, false, false)

 
  lib.add_straight_path(w+(dim2-1)*ws, ow+dim*ws-3, {{ow, ow/4}, {-ow, ow/4}}, line_style, false, false)
  lib.add_text(w+(dim2-1)*ws+ov, ow+(dim+1)*ws-3, "x", text_style) 
  lib.add_straight_path(w+dim*ws-3, 2*ow, {{ow/4, -ow}, {ow/4, ow}}, line_style, false, false)
  lib.add_text(w+(dim+1)*ws-3, v, "y", text_style) 
  
  for i = 1,nr_name do
      lib.add_text(4*ow+2+xp[i]*ws, yp[i]*ws, name[i], text_style)  
      lib.add_circle (w+xp[i]*ws, ow+yp[i]*ws, 2, line_style, false, false ) 
  end  
 
 scale = (dim2+2)*ws 

  for i = 1,6 do
    lib.add_line((i-1)*(4*ov+v)+ow, scale+ow, 0, 8*ov, line_style, false, false)
  end

  for i = 1,3 do
    lib.add_line(ow, scale+ow+2*(i-1)*ov, 22*ov-v, 0, line_style, false, false)
  end
  lib.add_line(ow, scale+ow+8*ov, 22*ov-v, 0, line_style, false, false)

  for i = 1,3 do
      lib.add_text(2*ov+ow, scale+ow+(2*i-1)*ov, msg[i], small_style, false, false) 	  	    	  
  end 
  lib.add_text(2*ov+ow, scale+v+7*ov, msg[4], small_style, false, false) 	
  
  for i = 1,stampa do
      lib.add_text(2*ov+ow+i*(4*ov+v), scale+ow+ov, title[i], colour_style, false, false) 	  	    	  
  end 
 
  for i = 1,stampa do 
      lib.add_input(ow+i*(5*ov-v-3) , scale+3*ov-3, 55,30, lib.check_number(dist[i],35))	   
  end 
 
  for i = 1,stampa do
      lib.add_text(2*ow+i*(4*ov+v)-3, scale+ow+5*ov, "(", text_style, false, false)
      lib.add_input(2*ow+i*(4*ov+v)-v, scale+5*ov-3, 50,30, lib.check_number(med_x[i],25))	 
      lib.add_text(7*ow+i*(4*ov+v)-v, scale+ow+5*ov, ",", text_style, false, false) 

      lib.add_input(2*ow+i*(4*ov+v)+3, scale+7*ov-3, 50,30, lib.check_number(med_y[i],25))

      lib.add_text(7*ow+i*(4*ov+v), scale+ow+7*ov, ")", text_style, false, false)	

   end 
 
  lib.end_canvas()
end         