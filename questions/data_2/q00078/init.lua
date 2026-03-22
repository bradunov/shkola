
include("terms")

style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};

dif_style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};
		
bar_style = 
    {["off_color"] = "e6e6ff",
        ["on_color"] = "e6e6ff",
        ["line_color"] = "000",
        ["line_width"] = "2"};		
		
marker_style = 
	{["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
		
text_style = {["font_size"] = "14"}

numb = {}
mark = {}
out = {}
perc = {}

for i = 1,5 do
    mark[i] = i
end

min = 1000
for i = 1,5 do
    numb[i] = min + 10 * math.random(300)
end

out = lib.math.argsort(numb)
ind = math.random(3)

level = 4 + math.random(6)
perc[ind] = 10*(level - 1) + math.random(9)
for i = 1,5 do
    if (i ~= ind) then
	    dif = 10*math.random(level - 3) +  math.random(8)
        perc[i] = perc[ind] - dif
	end
end
out = lib.math.argsort(perc)
for i = 2, 5 do
	if (math.abs(perc[out[i]] - perc[out[i-1]]) < 0.5) then    
		perc[out[i-1]] = perc[out[i-1]] - 0.1*(4 + math.random(8))
		perc[out[i-1]] = lib.math.round_dec(perc[out[i-1]],1)
	end
end

mycanvas = function()  
     
  lib.start_canvas(350, 320, "center")
 
  v = 35
  ov = 80
  w = 120
  ow = 20
  vv = 15
  sft = w + ov +ow

  oww = math.floor(140/level) + 1 
  maxb = 10

  for i = 1,maxb do
      j = maxb+1-i
	  lib.add_input(5, (j-1)*ow, 20, 30, note[j])
      if (i <= level) then
		  j = level+1-i
		  tmp = tostring(10*i)
		  lib.add_text(ow+v, j*oww, tmp, text_style, false, false)
		  lib.add_line(ov-vv, j*oww, 2*w+10, 0, dif_style, false, false)
      end
  end

  lib.add_line(2*vv+v, oww, 13*ow-10, 0, dif_style, false, false)
  lib.add_line(2*vv+v, (level+1)*oww, 13*ow-10, 0, bar_style, false, false)
  lib.add_text(ow+v, (level+1)*oww, "0", text_style, false, false)
  lib.add_line(2*vv+v, oww, 0, level*oww, dif_style, false, false)
  lib.add_line(15*ow+vv, oww, 0, level*oww, dif_style, false, false)

  for i = 1,5 do
	  x = math.floor(perc[i]/10)
	  y = perc[i] - 10 * x
	  x = x * oww
	  y = 0.1*y*oww
      lib.add_rectangle (4*ow+(i-1)*(2*vv+ow), oww*(level+1) - x-y, ow, x+y, bar_style, true, false)  
      lib.add_text(ov+vv+(i-1)*(v+vv), (level+2)*oww-5, mark[i], text_style, false, false)
  end
  lib.add_input(2*w, (level+2)*oww+5, 100, 40, msg[1])
  
--[[ tabela  ]]--

  lib.add_line(ow, sft+ow, 0, 2*v, dif_style, false, false)
  for i = 1,6 do 
     lib.add_line(w-ow+(i-1)*3*vv, sft+ow, 0, 2*v, dif_style, false, false)
  end
	 
  for j = 1,3 do
    lib.add_line(ow, sft+ow+(j-1)*v, 2*(w+v)-5, 0, dif_style, false, false)
  end

  lib.add_input(5, sft+v-10, 120, 30, msg[1])
  lib.add_input(5, sft+2*v-15, 120, 30, msg[2])
  lib.add_input(5, sft+2*v, 120, 30, msg[3])
  
  for i = 1,5 do
      lib.add_text(2*v+i*3*vv, sft+v, mark[i], text_style, false, false)   	  
      lib.add_text(4*v-ow+(i-1)*3*vv, sft+2*v, numb[i], text_style, false, false)  	  
  end
 
  lib.end_canvas()
end    
     