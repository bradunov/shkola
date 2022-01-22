
include("terms")

style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
text_style = {["font_size"] = "16"}

numb = {}
mark = {}
out = {}
tmp = {}

ch = math.random(3)

for i = 1,5 do
    mark[i] = i
end

total = 25 + math.random(15)
max = math.floor(total/7)
sum = 0
for i = 1,2 do
    numb[i] = i + math.random(max+i)
    numb[6-i] = i + math.random(max+i)		
	sum = sum + numb[i] + numb[6-i]
end

if (sum + 3 > total) then
    total = sum + 2 + math.random(5)
end
numb[3]	= total - sum 


out = lib.math.argsort(numb)

if (numb[out[5]] == numb[out[4]]) then
    numb[out[5]] = numb[out[5]] + 1
	total = total + 1
end	
	
aver = 0
for i = 1,5 do
    aver = aver + numb[i] * mark[i]
end
aver = lib.math.round_dec(aver/total,2)	

modus = mark[out[5]]

nr = 0
for i = 1,5 do
    for j = 1,numb[i] do
	    nr = nr + 1
	    tmp[nr] = mark[i]
	end
end	
tot = math.floor(total/2)
if (total - 2*tot == 0) then
    med = (tmp[tot] + tmp[tot+1]) * 0.5
else
    med = tmp[tot+1]
end	
    	
if (ch == 1) then
    value = aver
else
    if (ch == 2) then
       value = med
    else
       value = modus
    end
end


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

  lib.add_text(ov+ow, v, msg[1], text_style, false, false)
  lib.add_text(ov+ow, 2*v, msg[2], text_style, false, false)
  
  ind = math.random(5)
  for i = 1,5 do
      lib.add_text(ow+w+i*v, v, mark[6-i], text_style, false, false)  
      if (i == ind) then
          lib.add_input(w+i*v-8, 2*v-10, 60, 30, lib.check_number(math.floor(numb[6-i]), 15))  	  
	  else
          lib.add_text(ow+w+i*v, 2*v, numb[6-i], text_style, false, false)   
      end
  end

  lib.end_canvas()
end              