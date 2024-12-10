
include("terms")
                              
style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

dif_style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "ccc",
        ["on_color"] = "ccc",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
text_style = {["font_size"] = "16"}
small_style = {["font_size"] = "14"}

ret = {}
cost = {}
numb = {}

ch = math.random(3)

cost[1] = 121 + math.random(40)
cost[3] = cost[1] + 10 + math.random(30)
cost[5] = cost[1] - 10 - math.random(30)
for i = 1,3 do
	cost[2*i] = lib.math.round(cost[2*i-1] *(0.7 - 0.01 * math.random(20)))
end
for i = 1,6 do
	ret[i] = lib.math.round(2*cost[i] *(0.9 - 0.01 * math.random(15)))
end

for i = 1,6 do 	
    cost[i] = lib.math.round_dec(0.1 * cost[i],1)
    ret[i] = lib.math.round_dec(0.1 * ret[i],1)	
end	

numb[1] = 1 + math.random(3)
numb[2] = 1 + math.random(3)
total = lib.math.round_dec(ret[2*ch-1]*numb[1] + ret[2*ch]*numb[2],1)

numb[3] = 1 + math.random(3)
first = math.random(3)
if (first == 1) then
    second = 3
else	
	if (first == 2) then
		second = math.random(2)
		if (second == 2) then
		   second = 3
		end
	else
	    second = 3
		first = math.random(2)
	end
end	
dif = lib.math.round_dec((cost[2*first-1] - cost[2*second-1]) *numb[3],1)


mycanvas = function()

  lib.start_canvas(350, 200, "center")
 
  v = 35
  ov = 80
  ow = 10
 
lib.add_rectangle (ow, ow, 4*v-2*ow, v, dif_style, true)

  lib.add_line(ow, ow, 0, 5*v, style, false, false)
  lib.add_line(2*v-ow, ow, 0, 5*v, style, false, false)
  for i = 1,4 do 
     lib.add_line(2*(i+1)*v-ow, ow, 0, 5*v, style, false, false)
  end
	 
  for j = 1,6 do
      if (j == 3 or j == 5) then
          x = 4*v-ow
          z = 4*v-2*ow
      else
          x = ow
          z = 0
     end
     lib.add_line(x, ow+(j-1)*v, 4*ov+ow-z, 0, style, false, false)
  end

  for j = 1,2 do
	lib.add_text(ov+ow, 2*j*v-ow-5, name[3], small_style, false, false)
	lib.add_text(ov+ow, 2*j*v, name[4], small_style, false, false)
	lib.add_text(v, 2*j*v+ow, name[j], small_style, false, false)  
	lib.add_text(ov+ow+5, 2*j*v+3*ow, name[5], small_style, false, false)
  end

  for i = 1,3 do
      lib.add_text(3*ow-5+(i+1)*(ov - ow), v-ow, town[i], small_style, false, false)  
      lib.add_text(2*ov+2*(i-1)*v, 2*v-ow, cost[2*i-1], text_style, false, false)     
	  lib.add_text(2*ov+2*(i-1)*v, 3*v-ow, ret[2*i-1], text_style, false, false)     
      lib.add_text(2*ov+2*(i-1)*v, 4*v-7, cost[2*i], text_style, false, false)  
      lib.add_text(2*ov+2*(i-1)*v, 5*v-ow, ret[2*i], text_style, false, false)   	  
  end

  lib.end_canvas()
end                                     
        