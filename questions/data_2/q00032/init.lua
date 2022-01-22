
style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
text_style = {["font_size"] = "16"}

include("terms")

numb = {}
part = {}
name = {}
out = {}

number = 0
for i = 1,5 do
    numb[i] = math.random(7)
	number = number + numb[i]
	name[i] = msg2[1]
	if (numb[i] == 1) then
	    name[i] = msg2[2]	
	end    
end

aver = 20 + math.random(10)

for i = 1,5 do
    sign = math.random(2)
	if(sign == 1) then
       part[i] = aver - math.random(9)
	else   
       part[i] = aver + math.random(9)	
    end	   
end

out = lib.math.argsort(part)
for i = 1,4 do
    if (part[out[i]] == part[out[i+1]]) then
	    part[out[i]] = part[out[i]] - (5 - i)*2 
	end	
end	
out = lib.math.argsort(part)
	
total = 0	
for i = 1,5 do	
	total = total + part[i] * numb[i] 	
end	

aver = lib.math.round_dec(total/number,2)	

mycanvas = function()

  lib.start_canvas(350, 100, "center")
 
  v = 35
  ov = 80
  w = 120
  ow = 20
 
  lib.add_line(ow, ow, 0, 2*v, style, false, false)
  for i = 1,6 do 
     lib.add_line(2*ow+w+(i-1)*v, ow, 0, 2*v, style, false, false)
  end
	 
  for j = 1,3 do
    lib.add_line(ow, ow+(j-1)*v, w+5*v+ow, 0, style, false, false)
  end

  lib.add_text(ov+ow, v, msg1[1], text_style, false, false)
  lib.add_text(ov+ow, 2*v, msg1[2], text_style, false, false)
  
  ind = math.random(5)
  for i = 1,5 do
      lib.add_text(ow+w+i*v, v, part[out[i]], text_style, false, false)  	  
      if (i == ind) then
          lib.add_text(ow+w+i*v, 2*v, numb[out[i]], text_style, false, false)  
      else		  
          lib.add_input(w+i*v-8, 2*v-10, 60, 30, lib.check_number(math.floor(numb[out[i]]), 15))  	  
      end
  end

  lib.end_canvas()
end     