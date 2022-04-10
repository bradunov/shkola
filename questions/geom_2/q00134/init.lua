
style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "1"};

diff_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
red_style = 
	{["off_color"] = "ffe6cc",
        ["on_color"] = "ffe6cc",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

blue_style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};		
yelow_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};				

dot_style = {["font_size"] = "35"}	
text_style = {["font_size"] = "16"}

meas = "\(\small^\circ\)"
spc = "\(\ \ \ \ \ \)"
ang_y = {"ζ", "φ", "α"}
ang_n = {"x", "y", "z"}

numb = {}
ang_style = {}
name = {""}
value = {}
answ = ""		  

ind = math.random(6)

if (ind == 1) then
    numb[1] = 20 + math.random(15)
	numb[2] = 2 * numb[1]
        numb[3] = 90
	ch = math.random(2)
    task = numb[ch]		
	if (ch == 2) then
        name[1] = ang_y[1]
        name[2] = ang_n[1]	
        ang_style[1] =  blue_style	
        ang_style[2] =  red_style	
        value[1] = numb[1]		
	else
        name[1] = ang_n[1]
        name[2] = ang_y[1]	
        ang_style[1] =  red_style	
        ang_style[2] =  blue_style	
        value[1] = numb[2]		
	end
        name[3] = ang_n[2] 
        value[2] = numb[3] 
        ang_style[3] =  red_style      
	answ = ang_n[1] .. " = " .. lib.check_number(value[1], 30) .. meas .. spc .. ang_n[2] .. " = " .. lib.check_number(value[2], 30) .. meas
end

if (ind == 2) then  
    numb[1] = 20 + math.random(30)
	numb[2] = 180 - 2 * numb[1]
	numb[3] = lib.math.round_dec(0.5 * numb[2],1)
	ch = math.random(3)
    task = numb[ch]	
	if (ch == 1) then
        name[1] = ang_y[1]
        name[2] = ang_n[1]	
        name[3] = ang_n[2]		
        ang_style[1] =  blue_style	
        ang_style[2] =  red_style	
        ang_style[3] =  red_style			
        value[1] = numb[2]	
        value[2] = numb[3]			
	end
	if (ch == 2) then
        name[2] = ang_y[1]
        name[1] = ang_n[1]	
        name[3] = ang_n[2]		
        ang_style[2] =  blue_style	
        ang_style[1] =  red_style	
        ang_style[3] =  red_style			
        value[1] = numb[1]	
        value[2] = numb[3]			
	end
	if (ch == 3) then
        name[3] = ang_y[1]
        name[1] = ang_n[1]	
        name[2] = ang_n[2]		
        ang_style[3] =  blue_style	
        ang_style[1] =  red_style	
        ang_style[2] =  red_style			
        value[1] = numb[1]	
        value[2] = numb[2]			
	end	
	answ = ang_n[1] .. " = " .. lib.check_number(value[1], 30) .. meas .. spc .. ang_n[2] .. " = " .. lib.check_number(value[2], 30) .. meas
end

if (ind == 3) then  
    numb[1] = 20 + math.random(30)
	numb[2] = numb[1]
	numb[3] = numb[1]	
	numb[4] = 2 * numb[1]
	ch = math.random(3)
    task = numb[ch]	
	if (ch == 1) then
        name[2] = ang_y[1]
        name[3] = ang_n[1]	
        name[4] = ang_n[2]
        name[1] = ang_n[3]		
        ang_style[2] =  blue_style	
        ang_style[3] =  red_style	
        ang_style[4] =  red_style	
        ang_style[1] =  red_style			
        value[1] = numb[2]	
        value[2] = numb[3]	
        value[3] = numb[4]		
	end
	if (ch == 2) then
        name[3] = ang_y[1]
        name[4] = ang_n[1]	
        name[1] = ang_n[2]
        name[2] = ang_n[3]		
        ang_style[3] =  blue_style	
        ang_style[4] =  red_style	
        ang_style[1] =  red_style	
        ang_style[2] =  red_style			
        value[1] = numb[3]	
        value[2] = numb[4]	
        value[3] = numb[1]		
	end	
	if (ch == 3) then
	    task = numb[4]
        name[2] = ang_n[1]
        name[3] = ang_n[2]	
        name[4] = ang_n[3]
        name[1] = ang_y[1]		
        ang_style[2] =  red_style	
        ang_style[3] =  red_style	
        ang_style[4] =  red_style	
        ang_style[1] =  blue_style			
        value[1] = numb[1]	
        value[2] = numb[2]	
        value[3] = numb[3]		
	end	
	answ = ang_n[1] .. " = " .. lib.check_number(value[1], 30) .. meas .. spc .. ang_n[2] .. " = " .. lib.check_number(value[2], 30) .. meas .. spc .. ang_n[3] .. " = " .. lib.check_number(value[3], 30) .. meas	
end

if (ind == 4) then  
    numb[1] = 20 + math.random(30)
	numb[2] = 2 * numb[1]
	numb[3] = numb[1]
	ch = math.random(3)
    task = numb[ch]	
	if (ch == 1) then
        name[1] = ang_y[1]
        name[2] = ang_n[1]	
        name[3] = ang_n[2]		
        ang_style[1] =  blue_style	
        ang_style[2] =  red_style	
        ang_style[3] =  red_style			
        value[1] = numb[2]	
        value[2] = numb[3]			
	end
	if (ch == 2) then
        name[2] = ang_y[1]
        name[1] = ang_n[1]	
        name[3] = ang_n[2]		
        ang_style[2] =  blue_style	
        ang_style[1] =  red_style	
        ang_style[3] =  red_style			
        value[1] = numb[1]	
        value[2] = numb[3]			
	end
	if (ch == 3) then
        name[3] = ang_y[1]
        name[1] = ang_n[1]	
        name[2] = ang_n[2]		
        ang_style[3] =  blue_style	
        ang_style[1] =  red_style	
        ang_style[2] =  red_style			
        value[1] = numb[1]	
        value[2] = numb[2]			
	end	
	answ = ang_n[1] .. " = " .. lib.check_number(value[1], 30) .. meas .. spc .. ang_n[2] .. " = " .. lib.check_number(value[2], 30) .. meas
end

if (ind == 5) then  
    numb[1] = 10 + math.random(20)
	numb[2] = 2 * numb[1]
	numb[3] = 90 - numb[2]
	ch = math.random(3)
    task = numb[ch]	
	if (ch == 1) then
        name[1] = ang_y[1]
        name[2] = ang_n[1]	
        name[3] = ang_n[2]		
        ang_style[1] =  blue_style	
        ang_style[2] =  red_style	
        ang_style[3] =  red_style			
        value[1] = numb[2]	
        value[2] = numb[3]			
	end
	if (ch == 2) then
        name[2] = ang_y[1]
        name[1] = ang_n[1]	
        name[3] = ang_n[2]		
        ang_style[2] =  blue_style	
        ang_style[1] =  red_style	
        ang_style[3] =  red_style			
        value[1] = numb[1]	
        value[2] = numb[3]			
	end
	if (ch == 3) then
        name[3] = ang_y[1]
        name[1] = ang_n[1]	
        name[2] = ang_n[2]		
        ang_style[3] =  blue_style	
        ang_style[1] =  red_style	
        ang_style[2] =  red_style			
        value[1] = numb[1]	
        value[2] = numb[2]			
	end	
	answ = ang_n[1] .. " = " .. lib.check_number(value[1], 30) .. meas .. spc .. ang_n[2] .. " = " .. lib.check_number(value[2], 30) .. meas
end

if (ind == 6) then  
    numb[1] = 10 + math.random(20)
	numb[2] = 4 * numb[1]
	numb[3] = 2 * numb[1]
	ch = math.random(3)
    task = numb[ch]	
	if (ch == 1) then
        name[1] = ang_y[1]
        name[2] = ang_n[1]	
        name[3] = ang_n[2]		
        ang_style[1] =  blue_style	
        ang_style[2] =  red_style	
        ang_style[3] =  red_style			
        value[1] = numb[2]	
        value[2] = numb[3]			
	end
	if (ch == 2) then
        name[2] = ang_y[1]
        name[1] = ang_n[1]	
        name[3] = ang_n[2]		
        ang_style[2] =  blue_style	
        ang_style[1] =  red_style	
        ang_style[3] =  red_style			
        value[1] = numb[1]	
        value[2] = numb[3]			
	end
	if (ch == 3) then
        name[3] = ang_y[1]
        name[1] = ang_n[1]	
        name[2] = ang_n[2]		
        ang_style[3] =  blue_style	
        ang_style[1] =  red_style	
        ang_style[2] =  red_style			
        value[1] = numb[1]	
        value[2] = numb[2]			
	end	
	answ = ang_n[1] .. " = " .. lib.check_number(value[1], 30) .. meas .. spc .. ang_n[2] .. " = " .. lib.check_number(value[2], 30) .. meas
end
				
mycanvas = function()

  lib.start_canvas(240, 190, "center")
  
    w = 80
    ow = 25
    v = 10
 
    lib.add_circle (ow+w, v+w, w, diff_style, false, false ) 

    lib.add_text(w+ow, w, "O", text_style)  
  
    if (ind == 1) then
        lib.add_straight_path(w-v+5, w+v+4, {{3*v, -4}, {-v+4, 3*v}}, ang_style[1], true, false) 		
        lib.add_text(w+v, w+ow-3, name[1], text_style)
        lib.add_straight_path(w+v+5, 2*w-2*v, {{-4, ow+2}, {2*v+2, -2*v}}, ang_style[2], true, false) 		
        lib.add_text(w+2*v, 2*w-v, name[2], text_style)
        lib.add_straight_path(2*w-ow-2, ow+2*v-2, {{2*v+5, -v-3}, {v, 2*v}}, ang_style[3], true, false) 		
        lib.add_text(2*w-v+3, ow+2*v-2, name[3], text_style) 
        lib.add_line(ow, w+2*v, 2*w, -ow+5, style, false, false)
        lib.add_line(ow, w+2*v, 2*w-ow, -3*ow+5, style, false, false)
        lib.add_line(2*w-2, ow+6, ow, 2*ow, style, false, false)
        lib.add_line(w+v, 2*w+v, w+v+2, -w-7, style, false, false)				
        lib.add_line(w+v, 2*w+v, ow-v, -w, style, false, false)	 		
    end
    if (ind == 2) then
        lib.add_straight_path(w+v+5, 2*w-2*v+2, {{-4, ow+2}, {2*ow, -2*v-2}}, ang_style[1], true, false) 		
        lib.add_text(w+2*v, 2*w-v, name[1], text_style) 
        lib.add_straight_path(w+2*ow+5, w+3*v, {{-3*v, -2*v}, {-v+4, 3*v}}, ang_style[2], true, false) 		
        lib.add_text(w+ow+3, w+ow-3, name[2], text_style) 
        lib.add_straight_path(2*ow+v-2, w+ow+3, {{-3*v, -7}, {2*v, ow}}, ang_style[3], true, false) 		
        lib.add_text(2*ow, w+ow+v, name[3], text_style)	
        lib.add_line(ow, w+2*v, 2*w-v-2, ow+v, style, false, false)
        lib.add_line(ow, w+2*v, w-v-4, w-v, style, false, false)
        lib.add_line(ow+w, v+w, w+v-ow, 2*ow-v+4, style, false, false)				
        lib.add_line(ow+w, v+w, -ow+v, w, style, false, false)
        lib.add_line(4*ow-v, 2*w+v, w, -ow-v, style, false, false)			
    end	
    if (ind == 3) then
        lib.add_straight_path(w-7, w+2*v-6, {{3*v, -v+6}, {-v+4, 3*v}}, ang_style[1], true, false) 		
        lib.add_text(w+v, w+ow, name[1], text_style) 
        lib.add_straight_path(2*w-2*v, 2*w-3*v-2, {{ow+5, 7}, {-2*ow, 2*v+2}}, ang_style[2], true, false) 		
        lib.add_text(w+2*ow+v, 2*w-2*v-5, name[2], text_style) 		
        lib.add_straight_path(w+ow+v+4, 4*v, {{3*v-2, -2*v+2}, {-v, 3*v}}, ang_style[3], true, false) 		
        lib.add_text(w+2*ow+4, ow+v, name[3], text_style) 		
        lib.add_straight_path(2*ow+2, w-2, {{-v-2,-3*v}, {-7, ow}}, ang_style[4], true, false) 		
        lib.add_text(2*ow-v, w-ow+v, name[4], text_style)	
        lib.add_line(ow, w+2*v, ow-v, -w+ow+2, style, false, false)
        lib.add_line(ow, w+2*v, 5*ow, -w, style, false, false)
        lib.add_line(ow, w+2*v, w, -v, style, false, false)
        lib.add_line(ow, w+2*v, v+2*w-ow, ow+v,  style, false, false)			
        lib.add_line(w+v, 2*w+v, ow-v-2, -w, style, false, false)	
        lib.add_line(w+v, 2*w+v, w-ow+4, v-2*w,    style, false, false)
        lib.add_line(w+v, 2*w+v, w, -ow-v, style, false, false)	
        lib.add_line(w+v, 2*w+v, -w+ow+3, -5*ow,  style, false, false)
    end		
    if (ind == 4) then
        lib.add_straight_path( 2*w-v+3, 2*ow+v+7,  {{v+7, -ow-2}, {-ow, v}}, ang_style[1], true, false) 		
        lib.add_text(2*w-v, 2*ow+v, name[1], text_style) 
        lib.add_straight_path(w-v+5, w+v+4, {{3*v, -5}, {-v+4, 3*v}}, ang_style[2], true, false) 		
        lib.add_text(w+v+3, w+ow-3, name[2], text_style) 
        lib.add_straight_path(2*ow+v-3, w+v+6, {{-3*v, 4}, {2*v, -ow+4}}, ang_style[3], true, false) 		
        lib.add_text(2*ow-3, w+v, name[3], text_style)	   
        lib.add_line(ow, w+2*v, w, -v, style, false, false)
        lib.add_line(ow, w+2*v, 2*w-ow+v, -2*ow-v, style, false, false)
        lib.add_line(ow, w+2*v, w+v+5, -w-v, style, false, false)
        lib.add_line(w+v, 2*w+v, w, -w-2*ow, style, false, false)				
        lib.add_line(w+v, 2*w+v, 2*(ow-v), -2*w, style, false, false)		
    end
    if (ind == 5) then
	   lib.add_straight_path(w+2*v+3, ow+v+5, {{2*v, -3*v}, {-v+3, 3*v}}, ang_style[1], true, false) 		
	   lib.add_text(w+ow+v, ow+5, name[1], text_style) 
       lib.add_straight_path( 2*w+v, w+ow+4,  {{v+4, -ow-6}, {-ow, v+2}}, ang_style[2], true, false) 		
	   lib.add_text(2*w+v, w+v+3, name[2], text_style)	   
	   lib.add_straight_path(2*w-2*ow+5, 2*w-6, {{3*v, 5}, {-2*v, -3*v-3}}, ang_style[3], true, false) 		
	   lib.add_text(2*w-ow-5, 2*w-v-3, name[3], text_style)	
	   lib.add_straight_path(w-v+2, 2*w-v-6, {{2*v, 5}, {4, -2*v}}, yelow_style, true, false) 		
	   lib.add_text(w+5, 2*w-ow-3, ".", dot_style, false, false)
       lib.add_line(ow+v+6, w+2*ow+v, w, -w-2*ow, style, false, false)
       lib.add_line(ow+v+6, w+2*ow+v, 2*w-ow+v-4, -2*ow-v, style, false, false)
       lib.add_line(ow+v+6, w+2*ow+v, 2*w-2*ow-4, ow-5, style, false, false)
       lib.add_line(w+ow+v+7, v+2, -2*(ow-v), 2*w-ow+3, style, false, false)
       lib.add_line(2*w+ow-2, w, -ow-v-3, w, style, false, false)				
       lib.add_line(ow+w, w+v, 2*ow-v, 3*ow-5, style, false, false)		
    end
    if (ind == 6) then
       lib.add_straight_path( 2*w-v, w+ow+v-2,  {{ow+v, -ow-v}, {-ow-v, v+4}}, ang_style[1], true, false) 		
	   lib.add_text(2*w-v, w+v+v, name[1], text_style)	     
       lib.add_straight_path(w-v+5, w+ow+8, {{3*v, -2*v-4}, {v+6, 3*v}}, ang_style[2], true, false) 		
       lib.add_text(w+2*v+3, w+ow-3, name[2], text_style)		   
   	   lib.add_straight_path(w+7, ow+v+5, {{v+4, -3*v}, {v, 3*v}}, ang_style[3], true, false) 		
	   lib.add_text(w+2*v, ow+5, name[3], text_style)  	   
	   lib.add_straight_path(w-v+2, 2*w-v-6, {{2*v, 5}, {-4, 2*v}}, yelow_style, true, false) 		
       lib.add_text(w+5, 2*w-v-4, ".", dot_style, false, false)
       lib.add_line(ow+v+6, w+2*ow+v, w-2*v, -w-2*ow, style, false, false)
       lib.add_line(ow+v+6, w+2*ow+v, 2*w-ow+v-4, -2*ow-v, style, false, false)
       lib.add_line(ow+v+6, w+2*ow+v, 2*w-2*ow-4, ow-5, style, false, false)
       lib.add_line(w+ow, w+v, -ow+v, w, style, false, false)
       lib.add_line(w+ow, w+v, -w+v+5, 2*ow, style, false, false)
       lib.add_line(2*w+ow-2, w, -ow-v-3, w, style, false, false)
       lib.add_line(2*w+ow-2, w, -w-v-3, w+v, style, false, false)				
       lib.add_line(ow+w, w+v, 2*ow-v, 3*ow-5, style, false, false)
       lib.add_line(ow+w-3, v, 2*ow-v+3, 2*w-v, style, false, false) 		
    end

  lib.end_canvas()
  
end      
       