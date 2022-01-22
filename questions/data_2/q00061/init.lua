                           
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

yelow_style = {["off_color"] = "ff0",
               ["on_color"] = "ff0",
               ["line_color"] = "000",
               ["line_width"] = "2"};

green_style = {["off_color"] = "6f6",
                ["on_color"] = "6f6",
                ["line_color"] = "000",
                ["line_width"] = "2"};

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "14"}	
group_style = {["font_size"] = "16"}	
small_style = {["off_line_color"] = "f30",
               ["font_size"] = "14"}	

point = {2, 4, 6, 8, 10, 12, 14, 16, 18}

numb = {}
name = {}
out = {}
tmp = {}
aver = {}
med = {}
modus = {}

dim = 9

for k = 1,2 do
numb[k] = {}
max_numb = 0
ind = 1
for i = 1,dim do
    numb[k][i] = math.random(7)
	if (numb[k][i] > max_numb) then
	    ind = i
		max_numb = numb[k][i]
	end	
end
numb[k][ind] = max_numb + 1

number = 0
for i = 1,dim do
	number = number + numb[k][i]
end

out[k] = number
	
total = 0	
for i = 1,dim do	
	total = total + point[i] * numb[k][i] 	
end	
aver[k] = lib.math.round_dec(total/number,2)	

nr = 0
for i = 1,dim do
    for j = 1,numb[k][i] do
	    nr = nr + 1
        tmp[nr] = point[i]
	end	
end

nr2 = math.floor(nr/2)
if (nr - 2*nr2 == 0) then
    med[k] = (tmp[nr2] + tmp[nr2+1]) * 0.5
else
    med[k] = tmp[nr2+1]
end	

modus[k] = point[ind]  
end            


mycanvas = function()

  lib.start_canvas(360, 110, "center")

  w = 20
  ow = 10
  v = 5
 
  x = w+ow
  for i = 1,dim do
      lib.add_text(w+x, w+v, point[i], small_style, false, false) 	  	    	  
      x = x + 2*w -v
  end 
  lib.add_rectangle (v, 2*w, w+v, w+ow, yelow_style, false, false)
  lib.add_rectangle (v, 3*w+ow, w+v, w+ow, green_style, false, false)  
  lib.add_text(v+ow, 3*w-v, "A", group_style, false, false) 
  lib.add_text(v+ow, 4*w+v, "B", group_style, false, false) 	  

  for i = 1,dim+1 do
    lib.add_line(i*(2*w-v)-v, ow, 0, 5*w-ow, line_style, false, false)
  end
    lib.add_line(v, ow, 0, 5*w-ow, line_style, false, false)

  for i = 1,4 do
    lib.add_line(v, ow+(i-1)*(w+ow), 17*w, 0, line_style, false, false)
  end
    lib.add_line(v, ow, 17*w, 0, line_style, false, false)

  x = w+ow
  for i = 1,dim do
      numb_a = numb[1][i] 
      lib.add_text(w+x, 3*w-v, numb_a, text_style, false, false) 	  	    	  
      numb_b = numb[2][i] 
      lib.add_text(w+x, 4*w+v, numb_b, text_style, false, false)
      x = x + 2*w -v
  end	  
	    
  lib.end_canvas()
end   