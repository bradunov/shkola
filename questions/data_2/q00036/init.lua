
include("terms")


tab_style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
colour_style = 
	{["off_color"] = "cfc",
        ["on_color"] = "cfc",
        ["line_color"] = "000",
        ["line_width"] = "2"};

line_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "16"}

numb = {}
out = {}
per = {}
mark = {}


xm = {}
ym = {}
xt = {}
yt = {}

total = 12
max = math.floor(total/6)
numb[1] = 1+math.random(max)
numb[4] = math.random(max)
temp = total - numb[1] - numb[4]
numb[2] = math.floor(temp/2) 
rest = temp - 2 * numb[2] 
numb[3] = numb[2] + rest + 1
numb[2] = numb[2] - 1

for i = 1,4 do
    mark[i] = 6 - i
    per[i] = lib.math.round_dec(100 * numb[i] / total,1)
end	

factor = 8 + math.random(11)
for i = 1,4 do
    out[i] = numb[i] * factor
end
total = total * factor	


mycanvas = function()

  w = 5 
  ow = 10
  v = 50
  ov = 15
  wy = 100
  oc = 150
  ocy = 120
  shf = 80

ind = -1
for i = 1,4 do
    ind = ind + numb[i] 
    if (ind == 0) then
       xm[i] = 0 
       ym[i] = -wy+ow 
       xt[i] = -ov 
       yt[i] = -v 	   
    end
    if (ind == 1) then
       xm[i] = wy/2-ow/5 
       ym[i] = -wy+2*ow 
       xt[i] = ov
       yt[i] = -v 		   
    end
    if (ind == 2) then
       xm[i] = wy-ov 
       ym[i] = -wy/2 
	   xt[i] = v 
       yt[i] = -v
    end
    if (ind == 3) then
       xm[i] = wy 
       ym[i] = 0 
	   xt[i] = v 
       yt[i] = -ov 	   
    end
    if (ind == 4) then
       xm[i] = wy-ov 
       ym[i] = wy/2-w 
	   xt[i] = v 
       yt[i] = ov	   
    end
    if (ind == 5) then
       xm[i] = wy/2-ow/5 
       ym[i] = wy-2*ow 
	   xt[i] = v 
       yt[i] = v	   
    end
    if (ind == 6) then
       xm[i] = 0 
       ym[i] = wy-ow 
	   xt[i] = ov 
       yt[i] = v	   
    end
    if (ind == 7) then
       xm[i] = -wy/2+ow/5-2 
       ym[i] = wy-2*ow 
	   xt[i] = -ov 
       yt[i] = v	 	   
    end
    if (ind == 8) then
       xm[i] = -wy+ov 
       ym[i] = wy/2-w 
	   xt[i] = -v 
       yt[i] = v	   
    end
    if (ind == 9) then
       xm[i] = -wy 
       ym[i] = 0 
	   xt[i] = -v 
       yt[i] = ov	   
    end
    if (ind == 10) then
       xm[i] = -wy+ov 
       ym[i] = -wy/2+w 
	   xt[i] = -v 
       yt[i] = -ov	 	   
    end
    if (ind == 11) then
       xm[i] = -wy/2+ow/5-2 
       ym[i] = -wy+2*ow 
	   xt[i] = -v 
       yt[i] = -v	  	   
    end
end

  ch = math.random(4) 
  
  lib.start_canvas(350, 300, "center")

 
  
--[[ tabela ]]--
  lib.add_line(ow, ow, 0, 2*(v-ov), tab_style, false, false)
  for i = 1,5 do 
     lib.add_line(oc+(i-1)*(v-w), ow, 0, 2*(v-ov), tab_style, false, false)
  end
	 
  for j = 1,3 do
    lib.add_line(ow, ow+(j-1)*(v-ov), oc-w+5*(v-ov), 0, tab_style, false, false)
  end

  lib.add_text(wy-2*ow, v-2*ow, msg[1], text_style, false, false)
  lib.add_text(wy-2*ow, 2*(v-2*ow), msg[2], text_style, false, false)
  
  for i = 1,4 do
      lib.add_text(ocy+ow+i*(v-w), v-2*ow, mark[i], text_style, false, false) 
	  if (i == ch) then
	     lib.add_text(ocy+ow+i*(v-w), 2*(v-2*ow), lib.dec_to_str(per[i]), text_style, false, false)	 
      else		   	   	  
	     lib.add_input(ocy-ov+i*(v-w), 2*v-5*ow, 50, 30, lib.check_number(per[i],30))  
	  end
  end 

--[[ circle ]]--
  lib.add_circle (oc, ocy+shf, wy-w, colour_style, true, false )

  for i = 1,4 do
      lib.add_straight_path(oc, ocy+shf, {{xm[i], ym[i]}}, line_style,  false, false)    
	  x = oc + xt[i] 
	  y = ocy+shf + yt[i]  	  
	  if (i == ch) then
	     lib.add_text(x, y, tostring(mark[i]), text_style, false, false)	 
      else		 
	     lib.add_input(x-ov-ow, y-ow, 50, 30, lib.check_number(mark[i],10))
      end  	  
  end 

  lib.end_canvas()
end    

          

             
                           
                       
       
     
                
                            
                       
    