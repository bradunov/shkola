
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

meas = {"°", "'"}
numb = {"α", "β", "γ", "δ", "α₁", "β₁", "γ₁", "δ₁"}

ang_g = {}
ang_m = {}

answ = {}
ind = {}
ang_style = {}
index_f = {1, 4, 5, 8}
index_s = {2, 3, 6, 7}
out = {}

sign = math.random(3)
first_g = 60 +(2 - sign) * math.random(15)
first_m = math.random(59) - 1
sign = math.random(3)
second_g = 105 +(2 - sign) * math.random(20)
second_m = math.random(59) - 1	

ang_g[1] = first_g 
ang_m[1] = first_m 
ang_g[6] = second_g 
ang_m[6] = second_m 		
ang_g[2] = 179 - second_g 
ang_m[2] = 60 - second_m 
temp =  math.floor(ang_m[2]/60) 
ang_g[2] = ang_g[2] + temp    
ang_m[2] = ang_m[2] - 60 * temp
ang_g[5] = 179 - first_g
ang_m[5] = 60 - first_m
temp =  math.floor(ang_m[5]/60) 
ang_g[5] = ang_g[5] + temp    
ang_m[5] = ang_m[5] - 60 * temp
ang_g[3] = ang_g[6] 
ang_m[3] = ang_m[6] 	
ang_g[4] = ang_g[5] 
ang_m[4] = ang_m[5] 
ang_g[7] = ang_g[2]
ang_m[7] = ang_m[2]
ang_g[8] = ang_g[1]   
ang_m[8] = ang_m[1]	

out = lib.math.random_shuffle(index_f)
number_f = numb[out[1]]
dat_f = ang_g[out[1]] .. meas[1] .. " "
if (ang_m[out[1]] ~= 0) then
    dat_f = dat_f .. ang_m[out[1]] .. meas[2] .. " "
end	

out = lib.math.random_shuffle(index_s)
number_s = numb[out[1]]
dat_s = ang_g[out[1]] .. meas[1] .. " "
if (ang_m[out[1]] ~= 0) then
    dat_s = dat_s .. ang_m[out[1]] .. meas[2] .. " "
end	

nr = 0
for i = 1,8 do
    if (numb[i] ~= number_f and numb[i] ~= number_s) then
	    nr = nr + 1
	    ind[nr] = i
        answ[nr] = ""
        if (ang_g[ind[nr]] ~= 0) then
            answ[nr] = answ[nr] .. lib.check_number(ang_g[ind[nr]],30) .. meas[1] .. " "
        end	
        if (ang_m[ind[i]] ~= 0) then
            answ[nr] = answ[nr] .. lib.check_number(ang_m[ind[nr]],20) .. meas[2] .. " "
        end	
	end	
end	

mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40

  lib.start_canvas(320, 160, "center")
  
  for i = 1,8 do
	  ang_style[i] = dif_style  
      if (numb[i] == number_f or numb[i] == number_s ) then
	      ang_style[i] = blue_style
	  end	
  end	  

  lib.add_straight_path(6*ow+5, ov-7*ow+6, {{-2*ow+4, 3*ow-6 }, {3*ow, 0}}, ang_style[1], true, false) 
  lib.add_input(v+3, 2*v+ow,  50, 30, numb[1]) 
  lib.add_straight_path(w-ow-2, ov-v, {{4*ow-2, 0}, {-3*ow+2, -3*ow}}, ang_style[2], true, false) 
  lib.add_input(w-2*ow-5,2*v+ow, 50, 30, numb[2]) 
  lib.add_straight_path(w-2*v+2, 4*ow, {{3*ow, 0}, {2*ow, 2*ow}}, ang_style[3], true, false) 
  lib.add_input(w-2*v+5, v-5, 50, 30, numb[3])  
  lib.add_straight_path(2*v, 2*v-ow-3, {{2*ow-3, -3*ow+3}, {4*ow, 0}}, ang_style[4], true, false) 
  lib.add_input(2*v, v-5, 50, 30, numb[4])  
  lib.add_straight_path(ow, ov-4*ow, {{4*ow, 0}, {2*ow-4, -3*ow+5}}, ang_style[5], true, false) 
  lib.add_input(ow+5, 2*v+ow, 50, 30, numb[5]) 
  lib.add_straight_path(w-ow, v+3*ow+3, {{4*ow-4, 4*ow-3}, {4*ow, 0}}, ang_style[6], true, false) 
  lib.add_input(w+ow, 2*v+ow, 50, 30, numb[6]) 
  lib.add_straight_path(w-ow, v, {{-3*ow-6, 0}, {2*ow, 3*ow-8}}, ang_style[7], true, false) 
  lib.add_input(w-v-5, v-5, 50, 30, numb[7])  
  lib.add_straight_path(v+ow+6, v, {{v, 0}, {-2*ow, 3*ow+3}}, ang_style[8], true, false) 
  lib.add_input(v+ow, v-5,  50, 30, numb[8])
    
  lib.add_straight_path(ov+2*ow, ow, {{w-ov+v, ov-2*ow}}, style, true, false)
  lib.add_straight_path(ov-v, 2*ow, {{-2*v, ov-3*ow}}, style, true, false) 
  lib.add_straight_path(v, v, {{ov+2*v, 0}}, style, true, false)   
  lib.add_straight_path(ow, ov-v, {{w+v, 0}}, style, true, false)  
 
  lib.add_text(v+ow, 3*v+5, "A", text_style) 
  lib.add_text(w+2*ow+5, 3*v+5, "B", text_style)
  lib.add_text(w-v, 3*ow, "C", text_style)
  lib.add_text(w-ov-ow, 3*ow, "D", text_style)

  lib.end_canvas()
end  