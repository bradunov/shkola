
red_style = 
	{["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "f30",
        ["line_width"] = "3"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "fff",
        ["line_width"] = "0.1"};
				
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};	
							
meas =  {"cm", "cm²"}
numb = {}

grid = math.random(9)
dim = 10
rang_max = 4

leng = 0
nr = 0
ch = 0
for i = 1,dim do
    if (ch == 0) then
		numb[i] = math.random(rang_max)
		sum = leng + 2*numb[i]
		if (sum <= 2*dim) then
			leng = sum
			nr = nr + 1
		else	
			ch = 1	
		end
	end
end	

area = 0
for i = 1,nr do
    area = area + numb[i]*numb[i]
end	
area = area * grid^2 * 22 / 14
area = lib.math.round_dec(area, 2)


mycanvas = function()
	 		  
  lib.start_canvas(270, 140, "center")   
  
   w = 12
   ow = 9
   v = 3

   sg = math.random(2) - 1
   if (sg == 2) then
       sg = -1
   end	   
   x = v + w
   y = v + 5*w  
   for i = 1,nr do
       lib.add_circle (x+numb[i]*w, v+5*w, numb[i]*w, red_style, true, false)
	   lib.add_rectangle (x+1, y-sg*(numb[i]+1)*w, 2*numb[i]*w-1, (numb[i]+1)*w, dif_style, true, false)
       if (i == 1) then
  	       lib.add_rectangle (x-v, y-sg*(numb[i]+1)*w, 2*numb[i]*w+v, (numb[i]+1)*w, dif_style, true, false)	   
	   end
	   if (i == nr) then
  	       lib.add_rectangle (x, y-sg*(numb[i]+1)*w, 2*numb[i]*w+v, (numb[i]+1)*w, dif_style, true, false)	   
	   end
	   sg = 1 - sg
       x = x + 2 * numb[i] * w	   
   end
   
  for i = 1,11 do
    lib.add_line(v, v+(i-1)*w, 21*w, 0, grid_style, false, false)
  end
  for i = 1,22 do
    lib.add_line(v+(i-1)*w, v, 0, 10*w, grid_style, false, false)
  end

  lib.end_canvas()
end    