
include("names")
include("terms")

style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "0.5"}; 


blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "2"};

red_style = {["off_color"] = "f30",
                ["on_color"] = "f30",
                ["line_color"] = "000",
                ["line_width"] = "2"};

text_style = {["font_size"] = "16"}				

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 
padez = musko_ime_dativ[r]
if (lang == 2) then
	padez = ime
end

small = {2, 2, 3, 3, 4, 4, 5, 5, 5 ,5}
big  =  {7, 9, 7, 8, 7, 9, 6, 7, 8, 9}
dim = 10

fctb = {0}
fcts = {0}
sum = {}
op = {""}
quest = {""}  

space = "\( \ \ \ \)"
option = {"<--", "-->"}

total = 1 + math.random(8) 
ch = math.random(dim)

if (total < 5) then
	meas = msg[1]
else	    
	meas = msg[2]
end
if (small[ch] < 5) then
	meass = msg[1]
else	    
	meass = msg[2]
end

tmp = math.floor(math.abs(big[ch] - total)/ small[ch])
if (math.abs(big[ch] - total) == small[ch] * tmp) then
    if (big[ch] - total >= 0) then
		ind = 1		
		fctb[1] = 1
		fcts[1] = tmp		
		if (tmp == 0) then
			op[1] = ""	
        else		
			op[1] = option[2]
		end
		sum[1] = total
	else
		ind = 2	
		fctb[1] = 1
		fcts[1] = 0	
		op[1] = ""
		sum[1] = big[ch]	
		fctb[2] = 0
		fcts[2] = tmp		
		op[2] = ""
        sum[2] = total - sum[1]		
	end
end
tmp = math.floor(total/ small[ch])
if (total == small[ch] * tmp) then
 	ind = 1
	fctb[1] = 0
	fcts[1] = tmp		
	op[1] = ""
	sum[1] = total	
end

if (ch == 3) then
    if (total == 2) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 3	
		op[1] = option[1]
        sum[1] = total		
	end
    if (total == 5) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum[1] = big[ch] - small[ch]		
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[2]	
        sum[2] = total - sum[1]		
	end	
    if (total == 8) then
		ind = 2		
		fctb[1] = 1
		fcts[1] = 0	
		op[1] = ""	
        sum[1] = big[ch] 		
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[1]	
        sum[2] = total - sum[1]			
	end		
end
if (ch == 4) then
    if (total == 4) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[2]	
        sum[1] = big[ch] - 2*small[ch]		
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[2]	
        sum[2] = total - sum[1]		
	end	
    if (total == 7) then
		ind = 2		
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum[1] = big[ch] - small[ch] 		
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[2]	
        sum[2] = total - sum[1]		
	end		
end
if (ch == 5) then
    if (total == 2) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]	
        sum[1] = 2*small[ch] - big[ch] 	
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[1]	
        sum[2] = total - sum[1]		
	end	
    if (total == 5) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = ""	
        sum[1] = small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum[2] = total - sum[1]		
	end		
    if (total == 6) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1
		op[1] = option[2]	
        sum[1] = big[ch] - small[ch]		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]
        sum[2] = total - sum[1]		
	end		
    if (total == 9) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 2
		op[1] = ""	
        sum[1] = 2 * small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]
        sum[2] = total - sum[1]		
	end				
end
if (ch == 6) then
    if (total == 2) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[2]	
        sum[1] = big[ch] - 2*small[ch]	
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[2]	
        sum[2] = total - sum[1]		
	end	
    if (total == 3) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 3	
		op[1] = option[1]	
        sum[1] = total		
	end		
    if (total == 6) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 3
		op[1] = option[1]	
        sum[1] = 3 * small[ch] - big[ch]		
		fctb[2] = 1
		fcts[2] = 3	
		op[2] = option[1]	
        sum[2] = total - sum[1]		
	end		
    if (total == 7) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = ""	
        sum[1] = small[ch]		
		fctb[2] = 1
		fcts[2] = 3	
		op[2] = option[1]
        sum[2] = total - sum[1]		
	end				
end
if (ch == 7) then
    if (total == 2) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum[1] = big[ch] - small[ch]	
		fctb[2] = 1
		fcts[2] = 1
		op[2] = option[2]	
        sum[2] = total - sum[1]		
	end	
    if (total == 3) then
		ind = 3	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum[1] = big[ch] - small[ch]	
		fctb[2] = 1
		fcts[2] = 1
		op[2] = option[2]	
        sum[2] = big[ch] - small[ch]
		fctb[3] = fctb[2]
		fcts[3] = fcts[2]
		op[3] = op[2]			
  		sum[3] = sum[2]
	end	
    if (total == 4) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]
        sum[1] = total		
	end			
    if (total == 7) then
		ind = 3	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = ""	
        sum[1] = small[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]	
        sum[2] = big[ch] - small[ch]
		fctb[3] = fctb[2]
		fcts[3] = fcts[2]
		op[3] = op[2]			
  		sum[3] = sum[2]		
	end		
    if (total == 8) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2
		op[1] = option[1]	
        sum[1] = 2 * small[ch] - big[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum[2] = total - sum[1]			
	end	
    if (total == 9) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = ""	
        sum[1] = small[ch] 		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]
        sum[2] = total - sum[1]			
	end		
end
if (ch == 8) then
    if (total == 2) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]
        sum[1] = total		
	end	
    if (total == 3) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]	
        sum[1] = total		
	end	
    if (total == 4) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]
        sum[1] = big[ch] - small[ch] 
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]
        sum[2] = total - sum[1]		
	end			
    if (total == 6) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]		
        sum[1] = 2 * small[ch] - big[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[2]
        sum[2] = total - sum[1]		
	end		
    if (total == 8) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = ""	
        sum[1] = small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum[2] = total - sum[1]		
	end	
    if (total == 9) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 0
		op[1] = ""	
        sum[1] = big[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]
        sum[2] = total - sum[1]		
	end		
end
if (ch == 9) then
    if (total == 2) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]
        sum[1] = total		
	end	
    if (total == 3) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum[1] = total		
	end	
    if (total == 4) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]
        sum[1] = 2 * small[ch] - big[ch]
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum[2] = total - sum[1]		
	end			
    if (total == 6) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]		
        sum[1] = big[ch] - small[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]	
        sum[2] = total - sum[1]		
	end		
    if (total == 7) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = ""	
        sum[1] = small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum[2] = total - sum[1]		
	end	
    if (total == 9) then
		ind = 3	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum[1] = big[ch] - small[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]	
        sum[2] = big[ch] - small[ch]
		fctb[3] = fctb[2]
		fcts[3] = fcts[2]
		op[3] = op[2]			
        sum[3] = sum[2]		
	end		
end
if (ch == 10) then
    if (total == 2) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]	
        sum[1] = 2 * small[ch] - big[ch]
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum[2] = total - sum[1]		
	end	
    if (total == 3) then
		ind = 3	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]	
        sum[1] = 2 * small[ch] - big[ch]
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum[2] = 2 * small[ch] - big[ch]
		fctb[3] = fctb[2]
		fcts[3] = fcts[2]
		op[3] = op[2]			
        sum[3] = sum[2]		
	end	
    if (total == 4) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]
		sum[1] = total
	end			
    if (total == 6) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1	
		op[1] = ""		
        sum[1] = small[ch] 		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]
        sum[2] = total - sum[1]		
	end		
    if (total == 7) then
		ind = 3	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = ""	
        sum[1] = small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum[2] = 2 * small[ch] - big[ch]
		fctb[3] = fctb[2]
		fcts[3] = fcts[2]
		op[3] = op[2]					
        sum[3] = sum[2]		
	end	
    if (total == 8) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum[1] = big[ch] - small[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]	
        sum[2] = total - sum[1]		
	end		
end

for j = 1,ind do
	quest[j] = ""
	if (fctb[j] ~= 0) then
		quest[j] = quest[j] .. lib.check_number(fctb[j],10) .. " * " .. lib.check_number(big[ch],20)   
	end	
	if (fcts[j] ~= 0) then
		if (fctb[j] ~= 0) then
			quest[j] = quest[j] .. space .. lib.check_one_option_dropdown(option, op[j]).. space
		end			
		quest[j] = quest[j] .. lib.check_number(fcts[j],10) .. " * " .. lib.check_number(small[ch],20)    
	end		
	quest[j] = quest[j] .. space .. work[j] .. space .. lib.check_number(sum[j],20)	
end       
            
			
mycanvas = function()
			
lib.start_canvas( 300, 130, "center")

  v = 5
  w = 10
  ow = 20
  
  lib.add_straight_path (3*ow, w, {{w, 0}, {-w, ow}}, blue_style, true, false)
  lib.add_rectangle(w, w, 2*ow+w, 3*ow, blue_style, true, false)
  lib.add_text(2*ow-v, ow+w, "V", text_style, false, false)

  lib.add_straight_path (7*ow-v, 3*ow-v, {{2*ow+w, 0}, {-ow, ow}, {-w, 0}, {-ow, -ow},},red_style, true, false)
  lib.add_circle(8*ow, 9*w, ow+v, red_style, true, false)
  lib.add_text(8*ow, 9*w, "R", text_style, false, false)

  lib.add_straight_path (12*ow, ow, {{-v, -w}, {v, 0}}, blue_style, true, false)  
  lib.add_rectangle(12*ow, w, ow+w, 2*ow, blue_style, true, false)
  lib.add_text(13*ow-v, ow+w, "M", text_style, false, false)

  lib.add_straight_path (6*ow, ow-v, {{-w, v}, {w, v}}, style, true, false) 
  lib.add_straight_path (19*w, ow-v, {{w, v}, {-w, v}}, style, true, false) 
  lib.add_line(11*w, ow, 9*w, 0, style, false, false)

  lib.add_straight_path (11*w, 9*w, { {w, 0}, {-w, -w}}, style, true, false) 
  lib.add_line(4*ow, 7*w, 2*ow, ow, style, false, false)

  lib.add_straight_path (21*w, 9*w, { {-w, 0}, {w, -w}}, style, true, false) 
  lib.add_line(10*ow, 9*w, 2*ow, -ow, style, false, false)

  lib.end_canvas()
end