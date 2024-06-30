
include("names")
include("terms")

style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
text_style = {["font_size"] = "14"}

numb_m = {}
numb_s = {}
total_m = {}
total_s = {}
value = {}
out = {}
ime = {}

rm1 = math.random(#musko_ime_nom);
rm2 = math.random(#musko_ime_nom-1);
if (rm2 >= rm1) then rm2 = rm2 + 1 end;
ime[2] = musko_ime_nom[rm1];
ime[3] = musko_ime_nom[rm2];
rz1 = math.random(#zensko_ime_nom);
rz2 = math.random(#zensko_ime_nom-1);
if (rz2 >= rz1) then rz2 = rz2 + 1 end;
ime[1] = zensko_ime_nom[rz1];
ime[4] = zensko_ime_nom[rz2];

lap = 2 + math.random(4)
if (lang == 1) then
	if (lap < 5) then
	   path = circ[1]
	else
	   path = circ[2]
	end
else
    if (lap == 2) then
	    path = circ[1]
    else		
		if (lap < 5) then
		   path = circ[2]
		else
		   path = circ[3]
		end
	end
end	
	
for i = 1,4 do
	numb_m[i] = math.random(3)
	if (numb_m[i] == 2) then	
		numb_s[i] = math.random(59)
	else
		numb_s[i] = 20 * (3 - numb_m[i]) + math.random(19)	
	end	
end

for i = 1,4 do
    value[i] = lap * (60 * numb_m[i] + numb_s[i])
	total_m[i] = math.floor(value[i]/60)
	total_s[i] = value[i] - 60 * total_m[i]	
end

out = lib.math.argsort(value)
result = value[out[4]] - value[out[1]]
res_m = math.floor(result/60)
res_s = result - 60 * res_m

mycanvas = function()

  lib.start_canvas(350, 230, "center")
 
  v = 35 
  ov = 80
  w = 200
  ow = 20
  ww = 5
 
  lib.add_line(ww, ow, 0, w-ow/2, style, false, false)
  lib.add_line(ww, ow, w+ov+2*ow, 0, style, false, false)

  lib.add_line(ww, 2*v, w+ov+2*ow, 0, style, false, false)
  lib.add_line(2*v+ov+2*ww, 2*(ow+ww), w-v, 0, style, false, false)
  for j = 2,5 do
    lib.add_line(ww, (j+1)*v, w+ov+2*ow, 0, style, false, false)
  end

  lib.add_line(2*v, ow, 0, w-ow/2, style, false, false)
      lib.add_line(2*v+ov+2*ww, ow, 0, w-ow/2, style, false, false)
     lib.add_line(2*v+2*(ov+ww), 2*(ow+ww), 0, w-2*ow, style, false, false)
  lib.add_line(4*ov+ww, ow, 0, w-ow/2, style, false, false)	 


  lib.add_text(v, v, msg[1], text_style, false, false)
  lib.add_text(ov+v, v, msg[2], text_style, false, false)
  lib.add_text(ov+v, v+ow, msg[4], text_style, false, false)
 
  lib.add_text(2*(ov+ow), v, msg[3], text_style, false, false)
  lib.add_text(3*ov+v, v, msg[4], text_style, false, false)
  lib.add_text(2*ov+2*ow, 3*ow, "( s )", text_style, false, false)
  lib.add_text(3*ov+2*ow, 3*ow, "(min, s)", text_style, false, false)

  
  ind = math.random(5)
  for i = 1,4 do
      lib.add_text(v, ow + (i+1)*v, ime[i], text_style, false, false)  
      lib.add_text(ov+ww, ow + (i+1)*v, numb_m[i], text_style, false, false)   
      lib.add_text(ov+ow+ww, ow + (i+1)*v, " min", text_style, false, false) 
      lib.add_text(ov+3*ow-ww, ow + (i+1)*v, numb_s[i], text_style, false, false)   
      lib.add_text(ov+2*v, ow + (i+1)*v, " s", text_style, false, false) 
      lib.add_input(2*ov+ow/2, (i+1)*v+ww, 50, 50, lib.check_number(math.floor(value[i]), 30))  	  
      lib.add_input(3*ov, (i+1)*v+ww, 50, 30, lib.check_number(math.floor(total_m[i]), 15))  	
      lib.add_input(3*ov+v, (i+1)*v+ww, 50, 30, lib.check_number(math.floor(total_s[i]), 15)) 
  end

  lib.end_canvas()
end              
