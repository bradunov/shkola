
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
		
red_style = 
	{["off_color"] = "ffe6cc",
        ["on_color"] = "ffe6cc",
        ["line_color"] = "000",
        ["line_width"] = "1"};

blue_style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
		
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "14"}	
letter_style = {["font_size"] = "16"}	

meas = {"°", "'"}

numb = {}
ang_g = {}
ang_m = {}

answ = {}
ind = {}
ang_style = {}

numb = {"α", "β", "γ", "ζ", "δ", "η", "τ", "ω"}

sign = math.random(3)
first_g = 65 +(2 - sign) * math.random(5)
first_m = math.random(51) - 1
sign = math.random(3)
second_g = 33 +(2 - sign) * math.random(5)
second_m = math.random(51) - 1	

ang_g[3] = first_g 
ang_m[3] = first_m 
ang_g[1] = second_g 
ang_m[1] = second_m 		
ang_g[2] = 178 - first_g - second_g 
ang_m[2] = 120 - first_m - second_m 
temp =  math.floor(ang_m[2]/60) 
ang_g[2] = ang_g[2] + temp    
ang_m[2] = ang_m[2] - 60 * temp
ang_g[5] = ang_g[3] 
ang_m[5] = ang_m[3] 	
ang_g[4] = 179 - ang_g[3]
ang_m[4] = 60 - ang_m[3]
temp =  math.floor(ang_m[4]/60) 
ang_g[4] = ang_g[4] + temp    
ang_m[4] = ang_m[4] - 60 * temp
ang_g[6] = ang_g[4] 
ang_m[6] = ang_m[4] 
ang_g[7] = ang_g[1] 
ang_m[7] = ang_m[1] 
ang_g[8] = ang_g[2]
ang_m[8] = ang_m[2]

ch_f = math.random(2)
if (ch_f == 1) then
    number_f = numb[3]
else
    number_f = numb[5]
end	
ch_s = math.random(2)
if (ch_s == 1) then
    number_s = numb[1]
else
    number_s = numb[7]
end	

dat_f = ""
if (first_g ~= 0) then
    dat_f = dat_f .. first_g .. meas[1] .. " "
end	
if (first_m ~= 0) then
    dat_f = dat_f .. first_m .. meas[2] .. " "
end	

dat_s = ""
if (second_g ~= 0) then
    dat_s = dat_s .. second_g .. meas[1] .. " "
end	
if (second_m ~= 0) then
    dat_s = dat_s .. second_m .. meas[2] .. " "
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

  lib.start_canvas(320, 170, "center")
  
  for i = 1,8 do
      if (numb[i] == number_f) then
	      ang_style[i] = blue_style
	  else
          if (numb[i] == number_s) then
	          ang_style[i] = red_style
          else			  
	          ang_style[i] = dif_style
          end
      end	
  end	  

  lib.add_straight_path(ov-8, 2*v, {{4*ow, 0}, {-2*ow+5, 3*ow}}, ang_style[5], true, false) 
  lib.add_text(ov+ow+5, 2*v+ow, numb[5], text_style)
  lib.add_straight_path(2*v+ow-2, 6*ow, {{2*ow-4, -3*ow}, {4*ow, 3*ow-5}}, ang_style[2], true, false) 
  lib.add_text(2*v+3*ow, 5*ow-5, numb[2], text_style)  
  lib.add_straight_path(3*v-ow, 2*v, {{-3*ow-2, 0}, {-2*ow+2, 3*ow+4}}, ang_style[6], true, false) 
  lib.add_text(2*v+ow-5, 2*v+ow, numb[6], text_style)
  lib.add_straight_path(ov-3*ow, ov-ow, {{3*ow, 0}, {2*ow-4, -3*ow}}, ang_style[4], true, false) 
  lib.add_text(ov-5, ov-2*ow, numb[4], text_style) 
  lib.add_straight_path(6*ow+1, ov-4*ow, {{-2*ow+4, 3*ow }, {3*ow, 0}}, ang_style[3], true, false) 
  lib.add_text(6*ow, ov-2*ow, numb[3], text_style) 
  lib.add_straight_path(w-ow-2, ov-ow, {{4*ow, 0}, {-4*ow, -3*ow+4}}, ang_style[1], true, false) 
  lib.add_text(w-3, ov-2*ow, numb[1], text_style) 
  lib.add_straight_path(ov-5, v+ow+4, {{4*ow, 3*ow-4}, {-4*ow, 0}}, ang_style[7], true, false) 
  lib.add_text(ov, 2*v-ow, numb[7], text_style) 
  lib.add_straight_path(ov-6, 2*v, {{4*ow, 0}, {3*ow, ow+7}}, ang_style[8], true, false) 
  lib.add_text(ov+v-3, 2*v+ow, numb[8], text_style)
  
  lib.add_straight_path(2*(ow+v)+3, 3*ow-2, {{w-2*v+ow-2, ov-v+2}}, style, true, false)  
  lib.add_straight_path(ov-v-3, 2*ow+6, {{-2*v+2*ow-4, ov-3*ow-3}}, style, true, false)  
  lib.add_straight_path(v, ov-ow, {{w-ow, 0}}, style, true, false)  
  lib.add_straight_path(2*v-3, 2*v, {{2*(v+ow)+5, 0}}, style, true, false) 
  lib.add_straight_path(ov+v-7, 2*v, {{-v+7, 2*v-2*ow}}, style, true, false)  

  lib.add_text(w-ov+5, 2*ow-2, ".", dot_style)   
  lib.add_text(w-ov+5, ow+3, "B", letter_style) 
  lib.add_text(v+ow-5, ov-2*ow-2, ".", dot_style)  
  lib.add_text(v+ow-5, ov+5, "C", letter_style) 
  lib.add_text(w+3*ow, ov-2*ow-2, ".", dot_style)  
  lib.add_text(w+3*ow, ov+5, "A", letter_style)
  lib.add_text(2*v-ow-3, 2*v-5, "E", letter_style)
  lib.add_text(ov+v+5, 2*v-5, "D", letter_style)   
  lib.add_text(ov, ov+5, "F", letter_style) 
  
  lib.end_canvas()
end 
 