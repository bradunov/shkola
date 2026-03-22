
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
		
text_style = {["font_size"] = "14"}

numb = {}
out = {}
per = {}
mark = {""}

qq = {}
qq[1] = {6, 3, 2, 1}
qq[2] = {5, 3, 3, 1}
qq[3] = {5, 3, 2, 2}
qq[4] = {5, 4, 2, 1}
qq[5] = {6, 2, 2, 2}
qq[6] = {5, 2, 4, 1}

xm = {}
ym = {}
xt = {}
yt = {}

ch = math.random(6) 
total = 12
for i = 1,4 do
    numb[i] = qq[ch][i]
    per[i] = lib.math.round_dec(100 * numb[i] / total,2)
end	
factor = 5*(9 + math.random(11))
total = total * factor
for i = 1,4 do
    out[i] = lib.math.round(per[i] * total/100)
end
	

opt = math.random(3)
if (opt == 1) then
    result = total - out[1]
else
    if (opt == 2) then
		result = out[2] + out[3]	
    else
		result = out[3] + out[4]	
	end
end
	

mycanvas = function()

  w = 5 
  ow = 10
  v = 50
  ov = 15
  wy = 100
  oc = 160
  ocy = 120
  shf = -ow

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
  
  lib.start_canvas(300, 220, "center")

  lib.add_circle (oc, ocy+shf, wy-5, colour_style, true, false )

  for i = 1,4 do
      lib.add_straight_path(oc, ocy+shf, {{xm[i], ym[i]}}, line_style,  false, false)   	  
	  x = oc + xt[i] 
	  y = ocy+shf + yt[i]  	
      if (i == 1) then	
          y = y - 2*ov
      end	
      if (i == 2) then	
          x = x + 2*ow
      end
      if (i > 2) then
         x = x - ov
         if (i == 3) then	
             y = y + 2*ow
         end	
      end  	  
	  note =  tostring(i-1)
	  if (i == 4) then
	      note = "≥ " .. note
	  end 		  
	  mark[i] = tostring(per[i]) .. "%"
	  lib.add_input(x-ov-ow, y-2*ow, 60, 40, note) 
	  lib.add_text(x+ow, y+ow, mark[i], text_style, false, false) 	  
  end 

  lib.end_canvas()
end                   
         