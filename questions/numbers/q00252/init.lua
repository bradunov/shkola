
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
			
text_style = {["font_size"] = "14"}	

numb = {}
numb[1] = {}
for i = 1,4 do
    numb[1][i] = 1 + math.random(4)
end	
for j = 2,4 do
    numb[j] = {}
	for i = 1,5-j do
        numb[j][i] = numb[j-1][i] * numb[j-1][i+1]
	end
end	

ind = {}
for i = 1,4 do
    ind[i] = i
end
ind = lib.math.random_shuffle(ind)
second = ind[2]
if (ind[1] * ind[2] == 4 or ind[1] * ind[2] == 6) then
	total = numb[4][1]
else
    if (ind[1] == 1 or ind[1] == 4) then
        total = numb[4][1] * (numb[1][ind[1]] /numb[1][ind[2]])^2	
	else
		total = numb[4][1] * (numb[1][ind[2]] /numb[1][ind[1]])^2	
	end	
	total = lib.math.round(total)
end		

         
mycanvas = function(no)

  lib.start_canvas(280, 190, "center")   
 
  w = 30
  v = 40
  ow = 10

  for j = 1,4 do
      for i = 1,j do
      	  lib.add_rectangle (ow +(2*(i+1)-j)*w, ow+(j-1)*v, 2*w, v, style, true)
      end
  end 
  for j = 1,3 do
	  ch = math.random(5-j)  
          j1 = 4 - j
	  for i = 1,5-j do
	      if (i == ch) then
              lib.add_text(ow +(2*(i+1)-j1)*w, 3*ow+j1*v, numb[j][i], text_style, false, false) 
          else
		      lib.add_input((2*(i+1)-j1)*w-ow, 2*ow+j1*v, 50, 50, lib.check_number(numb[j][i]))
		  end	  
	  end
  end	
  lib.add_text(ow+3*v, 3*ow, numb[4][1], text_style, false, false)
	
  lib.end_canvas()
end           
          