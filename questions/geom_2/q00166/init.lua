
include("terms")	  

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

point_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};	
		
blue_style = {["off_color"] = "aff",
             ["on_color"] = "aff",
             ["line_color"] = "fff",
             ["line_width"] = "1"};		

text_style = {["font_size"] = "14"}	
			 

point = {"A", "B", "C", "D"}
line = {"p", "q", "r"}
plane = "π"
symb = {"∈", "∉", "∋", "∌"} 
space = "\( \ \ \ \ \) "

quest = {""}
term = ""
ind = {}
out = {}
ch = {}

		
mycanvas = function(no)

  w = 250
  ov = 150
  v = 40
  ow = 10

  lib.start_canvas(320, 170, "center")

  lib.add_straight_path (w+v, ow, {{-ov, ov}, {-ov+ow,0}, {ov, -ov}, {ov-ow, 0},}, blue_style, true, false)

  lib.add_line(v, 2*v-7, v, ow-3, style, false, false)  
  lib.add_line(2*v, 2*v, 3*v, 2*ow, dif_style, false, false)  
  lib.add_line(2*(w-ov), 2*(v+ow), 2*v+ow, ow+3, style, false, false)
  lib.add_circle(w, ov-v-4, 2.5, point_style, false, false)
  lib.add_text(w, 3*v-4, "A", text_style, false, false) 
  lib.add_text(v, 2*v, "p", text_style, false, false) 

  lib.add_line(2*v-ow, ov-2*ow, w-2*v, -2*v-2*ow, style, false, false)
  lib.add_circle(ov-v, ov-v-3, 2.5, point_style, false, false)  
  lib.add_text(ov-v, 3*v, "B", text_style, false, false)
  lib.add_text(2*(w-ov+ow), v-ow, "q", text_style, false, false)

  lib.add_line(v, v-ow-7, 3*v-7, 2*ow-3, style, false, false) 
  lib.add_line(ov, v, 3*v-2*ow, ow+5, dif_style, dif_false, false)  
  lib.add_line(w-6, v+ow+5, v, ow-4, style, false, false)  
  lib.add_circle(ov, v, 2.5, point_style, false, false) 
  lib.add_text(ov, v+ow, "C", text_style, false, false)
  lib.add_circle(2*v-ow, v-ow-3, 2.5, point_style, false, false)
  lib.add_text(2*v-ow, v, "D", text_style, false, false) 
  lib.add_text(w+2*ow, 2*v-ow-3, "r", text_style, false, false)

  lib.add_text(v-ow, ov, plane, text_style, false, false)

  lib.end_canvas()
end   

dim = 39

for i = 1,dim do
    ind[i] = i
end	
out = lib.math.random_shuffle(ind)

for i = 1,3 do
    ch[i] = i
end	
ch = lib.math.random_shuffle(ch)

quest[1] = ""
quest[2] = ""
for k = 1,6 do
    if (out[k] < 25) then
	    if (out[k] < 13) then
		    tmp = out[k]
		else		
		    tmp = out[k] - 12
		end
		i = math.floor((tmp-1)/3) + 1
		j = tmp - 3 * math.floor((tmp-1)/3)
	    if (out[k] < 13) then		
			if (j == i or (i == 4 and j == 3)) then
				reply = symb[1]
			else
				reply = symb[2]	
			end	
			term = point[i] .. " " .. lib.check_one_option_dropdown(symb, reply) .. " " .. line[j] 			
		else
			if (j == i or (i == 4 and j == 3)) then
				reply = symb[3]
			else
				reply = symb[4]	
			end			
			term = line[j] .. " " .. lib.check_one_option_dropdown(symb, reply) .. " " .. point[i] 	
		end
	else
		if (out[k] > 24 and out[k] < 33) then
			if (out[k] < 29) then
				j = out[k] - 24
				term = point[j]
				if (j > 1 and j < 4) then
					reply = symb[1]
				else
					reply = symb[2]	
				end					
			else		
				j = out[k] - 28
				term = plane			
				if (j > 1 and j < 4) then
					reply = symb[3]
				else
					reply = symb[4]	
				end	
			end			
			term = term .. " " .. lib.check_one_option_dropdown(symb, reply) 
			if (out[k] < 29) then
				term = term .. " " .. plane
			else
				term = term .. " " .. point[j]
			end	
        else
			if (out[k] > 32 and out[k] < 39) then		
				if (out[k] < 36) then
					j = out[k] - 32
					term = line[j]
					if (j == 2) then
						reply = msg[4]
					else
						if (j == 1) then					
						    reply = msg[3]
                        else
						    reply = msg[1]
                        end							
					end	
				    term = term .. " " .. lib.check_one_option_dropdown(msg, reply)					
				else		
					j = out[k] - 35
					term = plane			
					if (j == 2) then
						reply = symb[3]
					else
						reply = symb[4]	
					end	
					term = term .. " " .. lib.check_one_option_dropdown(symb, reply) 
				end					
				if (out[k] < 36) then
					term = term .. " " .. plane
				else
					term = term .. " " .. line[j]
				end	
			else
                term = line[ch[1]] .. " " .. lib.check_one_option_dropdown(msg, msg[2]) .. " " .. line[ch[2]]  		
			end		
		end	
	end
	if (k < 4) then
		quest[1] = quest[1] .. space .. term .. "," 
	else
		quest[2] = quest[2] .. space .. term
	    if (k == 6) then
			quest[2] = quest[2] .. "." 	
		else
			quest[2] = quest[2] .. ","		
		end
	end
end	