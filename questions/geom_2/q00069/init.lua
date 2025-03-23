
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dif_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "1"};				

blue_style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "1"};					
		
text_style = {["font_size"] = "14"}		

meas = "°"
numb = {"α", "β", "γ", "δ", "α₁", "β₁", "γ₁", "δ₁"}

ang = {}
answ = {}
ind = {}
ang_style = {}
qq = {}
out = {}

sign = math.random(3)
first = 60 +(2 - sign) * math.random(10)
sign = math.random(3)
second = 70 +(2 - sign) * math.random(10)	
sign = math.random(3)
third = 80 +(2 - sign) * math.random(10)
	
ang[1] = first 
ang[5] = 180 - first
ang[2] = second
ang[6] = 180 - second
ang[8] = third
ang[4] = 180 - third
ang[3] = 360 - ang[1] - ang[2] - ang[4]
ang[7] = 360 - ang[5] - ang[6] - ang[8]

qq[1] = 2*math.random(4)
qq[3] = 2*math.random(4) - 1
qq[2] = math.random(8)

if (qq[2] == qq[1] or math.abs(qq[1] - qq[2]) == 4) then
    if (qq[2] > 2) then
	    qq[2] = qq[2] - 2
	else	
	    qq[2] = qq[2] + 2
    end		
end	
if (qq[2] == qq[3] or math.abs(qq[3] - qq[2]) == 4) then
    if (qq[2] > 2) then
	    qq[2] = qq[2] - 2
	else	
	    qq[2] = qq[2] + 2
    end		
end	

out = lib.math.argsort(qq)	
number_f = numb[qq[out[1]]]
first = ang[qq[out[1]]]
number_s = numb[qq[out[2]]]
second = ang[qq[out[2]]]
number_t = numb[qq[out[3]]]
third = ang[qq[out[3]]]

nr = 0
for i = 1,8 do
    if (numb[i] ~= number_f and numb[i] ~= number_s and numb[i] ~= number_t) then
	    nr = nr + 1
	    ind[nr] = i
        answ[nr] = lib.check_number(ang[ind[nr]],30) .. meas 
	end	
end	

mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40

  lib.start_canvas(320, 180, "center")
  
  for i = 1,8 do
	  ang_style[i] = dif_style  
      if (numb[i] == number_f or numb[i] == number_s or numb[i] == number_t) then
	      ang_style[i] = blue_style
	  end	
  end	  

  lib.add_straight_path(6*ow+5, ov-4*ow+6, {{-2*ow+4, 3*ow-6 }, {3*ow, 0}}, ang_style[1], true, false) 
  lib.add_input(v+3, ov-v+ow,  50, 30, numb[1]) 
  lib.add_straight_path(w-ow-2, ov-ow, {{4*ow-2, 0}, {-4*ow+2, -5*ow-2}}, ang_style[2], true, false) 
  lib.add_input(w-2*ow, ov-v+ow, 50, 30, numb[2]) 
  lib.add_straight_path(w-2*v+8, 5*ow, {{3*ow, -5}, {2*ow, 3*ow}}, ang_style[3], true, false) 
  lib.add_input(w-2*v+5, v+2, 50, 30, numb[3])  
  lib.add_straight_path(2*v, 2*(v+ow)-3, {{2*ow-3, -3*ow}, {4*ow, -ow+2}}, ang_style[4], true, false) 
  lib.add_input(2*v, 2*v-ow-5, 50, 30, numb[4])  
  lib.add_straight_path(ow, ov-ow, {{4*ow, 0}, {2*ow-4, -3*ow+5}}, ang_style[5], true, false) 
  lib.add_input(ow+5, ov-v+ow, 50, 30, numb[5]) 
  lib.add_straight_path(w-ow, 2*v+ow, {{4*ow-4, 5*ow}, {4*ow, 0}}, ang_style[6], true, false) 
  lib.add_input(w+ow, ov-v+ow, 50, 30, numb[6]) 
  lib.add_straight_path(w-ow-2, v, {{-3*ow, 3}, {2*ow, 3*ow}}, ang_style[7], true, false) 
  lib.add_input(w-v-5, v, 50, 30, numb[7])  
  lib.add_straight_path(v+ow+6, 2*v-4, {{v, -ow+3}, {-2*ow, 3*ow+4}}, ang_style[8], true, false) 
  lib.add_input(v+ow, 2*v-ow,  50, 30, numb[8])
   
  lib.add_straight_path(ov+v, 2*ow, {{w-ov, ov-ow}}, style, true, false)
  lib.add_straight_path(ov-v, v+ow, {{-2*v, ov-3*ow}}, style, true, false) 
  lib.add_straight_path(v, 2*v, {{ov+v, -v}}, style, true, false)   
  lib.add_straight_path(ow, ov-ow, {{w+v, 0}}, style, true, false)  
 
  lib.add_text(v+ow, ov+5, "A", text_style) 
  lib.add_text(w+2*ow+5, ov+5, "B", text_style)
  lib.add_text(w-v, 3*ow, "C", text_style)
  lib.add_text(w-ov-ow, v+ow, "D", text_style)

  lib.end_canvas()
end 

       