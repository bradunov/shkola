
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

meas = {"\(^\circ\)", "'"}
symb = "\(\angle\)"

numb = {}
ang_g = {}
ang_m = {}

answ = {}
ind = {}

for i = 1, 16 do
    numb[i] = i
end	

number_f = math.random(8)
if (number_f - 2*math.floor(number_f/2) == 0) then
    number_s = 8 + 2*math.random(4)
    sign = math.random(3)
    first_g = 70 +(2 - sign) * math.random(5)
    first_m = math.random(51) - 1
    sign = math.random(3)
    second_g = 130 +(2 - sign) * math.random(5)
    second_m = math.random(51) - 1	
    for i = 1,4 do
	    ang_g[2*i]  = first_g 
	    ang_m[2*i]  = first_m 
        if (first_m == 0) then
            ang_g[2*i-1] = 180 - first_g 
            ang_m[2*i-1] = 0	
	    else
            ang_g[2*i-1] = 179 - first_g 
            ang_m[2*i-1] = 60 - first_m	
	    end	
        ang_g[8+2*i] = second_g
        ang_m[8+2*i] = second_m	
        if (second_m == 0) then
            ang_g[7+2*i] = 180 - second_g 
            ang_m[7+2*i] = 0	
	    else
            ang_g[7+2*i] = 179 - second_g 
            ang_m[7+2*i] = 60 - second_m	
	    end		
    end	
else
    number_s = 7 + 2*math.random(4)
    sign = math.random(3)
    first_g = 130 +(2 - sign) * math.random(5)
    first_m = math.random(51) - 1
    sign = math.random(3)
    second_g = 70 +(2 - sign) * math.random(5)
    second_m = math.random(51) - 1
    for i = 1,4 do
	    ang_g[2*i-1]  = first_g 
	    ang_m[2*i-1]  = first_m 
        if (first_m == 0) then
            ang_g[2*i] = 180 - first_g 
            ang_m[2*i] = 0	
	    else
            ang_g[2*i] = 179 - first_g 
            ang_m[2*i] = 60 - first_m	
	    end	
        ang_g[7+2*i] = second_g
        ang_m[7+2*i] = second_m	
        if (second_m == 0) then
            ang_g[8+2*i] = 180 - second_g 
            ang_m[8+2*i] = 0	
	    else
            ang_g[8+2*i] = 179 - second_g 
            ang_m[8+2*i] = 60 - second_m	
	    end		
    end		
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

min = 0 
for i = 1,4 do
    ind[i] = min + math.random(4)
    if (ind[i] == number_f) then
        if (ind[i]~= 1) then
            ind[i] = ind[i] - 1
        else
            ind[i] = ind[i] + 1  
        end
	end	
    if (ind[i] == number_s) then
        if (ind[i] ~= 16) then
            ind[i] = ind[i] + 1
        else
            ind[i] = ind[i] - 1  
        end	
    end	
    answ[i] = ""
    if (ang_g[ind[i]] ~= 0) then
        answ[i] = answ[i] .. lib.check_number(ang_g[ind[i]],30) .. meas[1] .. " "
    end	
    if (ang_m[ind[i]] ~= 0) then
        answ[i] = answ[i] .. lib.check_number(ang_m[ind[i]],20) .. meas[2] .. " "
    end	
	min = min + 4
end	

mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40   

  lib.start_canvas(300, 180, "center")
  
    if (numb[1] == number_f) then
	    angb_style = blue_style
	else
	    angb_style = dif_style
    end		
    lib.add_straight_path(v, 2*v+5, {{v, -5}, {v-2*ow, -v-4}}, angb_style, true, false) 
    lib.add_text(2*v-ow, 2*v-ow-3, numb[1], text_style)
    if (numb[2] == number_f) then
	    angb_style = blue_style
	else
	    angb_style = dif_style
    end			
    lib.add_straight_path(3*v-3, 2*v-5, {{-v, ow-3}, {v-ow, -v-2*ow+2}}, angb_style, true, false) 
    lib.add_text(2*v+ow+5, 2*v-ow-5, numb[2], text_style)
    if (numb[3] == number_f) then
	    angb_style = blue_style
	else
	    angb_style = dif_style
    end			
    lib.add_straight_path(3*v-3, 2*v-5, {{-v, ow-3}, {-ow-5, v-ow}}, angb_style, true, false) 
    lib.add_text(2*v+5, 2*v+ow, numb[3], text_style)
    if (numb[4] == number_f) then
	    angb_style = blue_style
	else
	    angb_style = dif_style
    end		
    lib.add_straight_path(v, 2*v+5, {{v-3, -5}, {-2*ow, v}}, angb_style, true, false) 
    lib.add_text(v+2*ow, 2*v+ow+3, numb[4], text_style)
    if (numb[5] == number_f) then
	    angb_style = blue_style
	else
	    angb_style = dif_style
    end			 
    lib.add_straight_path(ow+2, 3*v+2*ow, {{v-4, -5}, {v-2*ow, -v+2}}, angb_style, true, false) 
    lib.add_text(v+2, 3*v+2, numb[5], text_style)
    if (numb[6] == number_f) then
	    angb_style = blue_style
	else
	    angb_style = dif_style
    end		
    lib.add_straight_path(2*v+ow, 3*v+ow, {{-v, ow-5}, {v-2*ow+2, -v-ow+5}}, angb_style, true, false) 
    lib.add_text(v+3*ow-3, 3*v, numb[6], text_style)
    if (numb[7] == number_f) then
	    angb_style = blue_style
	else
	    angb_style = dif_style
    end		
    lib.add_straight_path(2*v+ow, 3*v+ow, {{-v, ow-5}, {-ow-6, v-ow}}, angb_style, true, false) 
    lib.add_text(v+ow+5, 3*v+2*ow+5, numb[7], text_style)	
    if (numb[8] == number_f) then
	    angb_style = blue_style
	else
	    angb_style = dif_style
    end			
    lib.add_straight_path(ow+2, 3*v+2*ow, {{v-3, -5}, {-2*ow, v-3}}, angb_style, true, false) 
    lib.add_text(3*ow+2, 3*(v+ow)-3, numb[8], text_style)

    if (numb[9] == number_s) then
	    angr_style = red_style
	else
	    angr_style = dif_style
    end	
    lib.add_straight_path(w-2*v, v+3*ow-2, {{v, -5}, {-v+2*ow, -v-4}}, angr_style, false, true) 
    lib.add_text(w-v-2*ow+3, v+ow+2, numb[9], text_style)
    if (numb[10] == number_s) then
	    angr_style = red_style
	else
	    angr_style = dif_style
    end		
    lib.add_straight_path(w-2*(v-ow), 2*ow, {{2*ow, v+3}, {v-ow, -4}}, angr_style, false, true) 
    lib.add_text(w-v+ow, v+ow, numb[10], text_style)
    if (numb[11] == number_s) then
	    angr_style = red_style
	else
	    angr_style = dif_style
    end		
    lib.add_straight_path(w-ow, v+2*ow-2, {{-v+ow, 4}, {2*ow-2, v}}, angr_style, false, true) 
    lib.add_text(w-2*ow, 2*v-ow, numb[11], text_style)
    if (numb[12] == number_s) then
	    angr_style = red_style
	else
	    angr_style = dif_style
    end		
    lib.add_straight_path(w-2*v, v+3*ow-3, {{v, -4}, {2*ow-2, v}}, angr_style, false, true) 
    lib.add_text(ov+v+ow, 2*v-ow+5, numb[12], text_style)
    if (numb[13] == number_s) then
	    angr_style = red_style
	else
	    angr_style = dif_style
    end	  
    lib.add_straight_path(w-v-2*ow+2, 3*v-5, {{v, -5}, {-v+2*ow, -v-4}}, angr_style, false, true) 
    lib.add_text(w-v, 3*v-2*ow, numb[13], text_style)
    if (numb[14] == number_s) then
	    angr_style = red_style
	else
	    angr_style = dif_style
    end		
    lib.add_straight_path(w-v+2, 2*v-ow-4, {{2*ow, v+3}, {v-ow, -4}}, angr_style, false, true) 
    lib.add_text(w-ow, 2*v+ow+5, numb[14], text_style)	
    if (numb[15] == number_s) then
	    angr_style = red_style
	else
	    angr_style = dif_style
    end		
    lib.add_straight_path(w+ow, 3*v-ow-5, {{-v+ow, 4}, {2*ow, v}}, angr_style, false, true) 
    lib.add_text(w, 3*v, numb[15], text_style)
    if (numb[16] == number_s) then
	    angr_style = red_style
	else
	    angr_style = dif_style
    end		
    lib.add_straight_path(w-v-2*ow+3, 3*v-5, {{v, -5}, {2*ow-2, v}}, angr_style, false, true) 
    lib.add_text(w-v+ow, 3*v+3, numb[16], text_style)
	
    lib.add_line(ow, 2*v+ow, w+v, -v, style, false, false)
    lib.add_line(ow, ov-ow, w+v, -v, style, false, false)
    lib.add_line(ov-v, 2*ow, -2*v, ov, style, false, false) 
    lib.add_line(v+ov, 2*ow, ov-2*v, ov, style, false, false)   

    lib.add_text(2*v-4, 2*v-ow, ".", dot_style, false, false)  
    lib.add_text(v+ow-2, 3*v+2, ".", dot_style, false, false) 	
    lib.add_text(w-v, v+ow, ".", dot_style, false, false)
    lib.add_text(w-2*ow+2, 2*(v+ow)-2, ".", dot_style, false, false)	
 
    lib.add_text(w+v-ow, v, "a", text_style)  
    lib.add_text(w+v-ow, 2*v+ow, "b", text_style)
    lib.add_text(3*v, 2*ow, "c", text_style, false, false)
    lib.add_text(ov+v+ow, 2*ow, "d", text_style, false, false)
  
  lib.end_canvas()
end
          
         
            
    
    
            
            
          