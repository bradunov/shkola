
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

meas = {"°", "'"}

numb = {"α", "β", "γ", "δ", "η", "ζ"}

ang_g = {}
ang_m = {}

answ = {}
ind = {}
ang_style = {}

sign = math.random(3)
first_g = 60 +(2 - sign) * math.random(5)
first_m = math.random(51) - 1
sign = math.random(3)
second_g = 125 +(2 - sign) * math.random(5)
second_m = math.random(51) - 1	

ang_g[1] = first_g 
ang_m[1] = first_m 
ang_g[4] = 179 - ang_g[1]
ang_m[4] = 60 - ang_m[1]
temp =  math.floor(ang_m[4]/60) 
ang_g[4] = ang_g[4] + temp    
ang_m[4] = ang_m[4] - 60 * temp
ang_g[5] = second_g 
ang_m[5] = second_m 		
ang_g[2] = 179 - ang_g[5]
ang_m[2] = 60 - ang_m[5]
temp =  math.floor(ang_m[2]/60) 
ang_g[2] = ang_g[2] + temp    
ang_m[2] = ang_m[2] - 60 * temp
ang_g[3] = 178 - ang_g[1] - ang_g[2] 
ang_m[3] = 120 - ang_m[1] - ang_m[2]
temp =  math.floor(ang_m[3]/60) 
ang_g[3] = ang_g[3] + temp    
ang_m[3] = ang_m[3] - 60 * temp
ang_g[6] = ang_g[1] + ang_g[2]
ang_m[6] = ang_m[1] + ang_m[2]
temp =  math.floor(ang_m[6]/60) 
ang_g[6] = ang_g[6] + temp    
ang_m[6] = ang_m[6] - 60 * temp

chin = math.random(6)
number_f = numb[chin]
first_g = ang_g[chin]
first_m = ang_m[chin]
chout = math.random(6)
if (chout == chin or math.abs(chin-chout) == 3 ) then
    if (chout < 6) then
        chout = chout + 1
    else
        chout = chout - 1
    end
end	
number_s = numb[chout]
second_g = ang_g[chout]
second_m = ang_m[chout]

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
for i = 1,6 do
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

  lib.start_canvas(320, 180, "center")
  
  for i = 1,6 do
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

  lib.add_straight_path(6*ow+1, ov-4*ow, {{-2*ow+4, 3*ow }, {3*ow, 0}}, ang_style[1], true, false) 
  lib.add_text(6*ow, ov-2*ow, numb[1], text_style) 
  lib.add_straight_path(w-ow-2, ov-ow, {{4*ow, 0}, {-4*ow, -3*ow+4}}, ang_style[2], true, false) 
  lib.add_text(w-3, ov-2*ow, numb[2], text_style) 
  lib.add_straight_path(2*v+ow, 6*ow, {{2*ow-4, -3*ow}, {4*ow, 3*ow-4}}, ang_style[3], true, false) 
  lib.add_text(2*v+3*ow, 5*ow-5, numb[3], text_style)  
  lib.add_straight_path(ow+5, ov-ow, {{3*ow, 0}, {2*ow-4, -3*ow}}, ang_style[4], true, false) 
  lib.add_text(4*ow, ov-2*ow, numb[4], text_style) 
  lib.add_straight_path(w-ow-2, ov-4*ow+4, {{4*ow, 3*ow-4}, {4*ow, 0}}, ang_style[5], true, false) 
  lib.add_text(w+3*ow, ov-2*ow, numb[5], text_style) 
  lib.add_straight_path(3*v+5, 4*ow+2, {{-2*ow, -ow-2}, {2*ow, -4*ow}}, ang_style[6], true, false) 
  lib.add_text(3*v, 3*ow-5, numb[6], text_style)  
  
  lib.add_straight_path(ow+2*v, 2*ow, {{w, ov+ow}}, style, true, false)
  lib.add_straight_path(ov-v, 2*ow, {{-2*v, ov}}, style, true, false)  
  lib.add_straight_path(ow, ov-ow, {{w+v, 0}}, style, true, false)  

  lib.add_text(w-ov, ow, "C", text_style) 
  lib.add_text(v+ow, ov+5, "A", text_style) 
  lib.add_text(w+2*ow+5, ov+5, "B", text_style)

  lib.end_canvas()
end      
