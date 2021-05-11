 
green_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};

yelow_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};		
						
text_style = {["font_size"] = "14"}		

meas = {"cm", "\(^\circ\)" }

numb = {"α", "β", "γ", "ρ", "σ", "τ"}
name = {"a", "b", "c", "r", "s", "t" }

index = {}
edge = {}
ang = {}
out = {} 
qe = {}
qa = {}

for i = 1,6 do
    qe[i] = 0
	qa[i] = 0
end	


sign = math.random(3)
value = 3600 +(2 - sign) * math.random(1800)
ang[1] = lib.math.round_dec(value/60, 1)
sign = math.random(3)
value = 2400 +(2 - sign) * math.random(1800)
ang[2] = lib.math.round_dec(value/60, 1)	
ang[3] = lib.math.round_dec(180 - ang[1] - ang[2], 1) 

factor = 10 + math.random(10)
x = math.pi / 180
for i = 1,3 do
    value = factor * math.sin(x * ang[i])
    edge[i] = lib.math.round_dec(value, 1)
	edge[i+3] =  edge[i]
    ang[i+3] = ang[i]		
end

      
index = {1, 2, 3}
out = lib.math.random_shuffle(index)
sign = math.random(2)
if (sign == 1) then
   out[2] = out[2] + 3
else
   out[1] = out[1] + 3
   out[3] = out[3] + 3 
end   
   
qe[out[1]] = 1
qe[out[2]] = 1
qe[out[3]] = 1			
qa[out[1]] = 1
qa[out[2]] = 1
            
mycanvas = function(no)

  ow = 5
  w = 125
  ov = 75
  v = 20

	
  lib.start_canvas(350, 290, "center") 
           
    lib.add_straight_path(ov-ow, 2*(v+ow), {{2*v, w-v}, {w+3*ow+v, -ov-v-2*ow}, {-w-2*v-7*ow, 0} }, green_style, true, false)  
    lib.add_straight_path(ov+v-ow, 2*w, {{w+ov, 0}, {-2*v, -5*v}, {-w-3*ow-v, ov+v+ow} }, yelow_style, true, false) 

    lib.add_text(3*v, 2*(v+ow), "A", text_style) 
    lib.add_text(ov-ow+2*v, w+2*v, "B", text_style)
    lib.add_text(2*(w+ow)+v, 2*(v+ow), "C", text_style) 

    lib.add_text(2*(w+ow)+2*v, 2*w, "R", text_style) 
    lib.add_text(2*(w-ow)+v, w+v, "S", text_style)
    lib.add_text(4*v, 2*w, "T", text_style) 
	
    reply = ""    
    if (qe[1] == 1) then
	    reply = edge[1] .. meas[1]
    else
        reply = lib.check_number(edge[1],30) .. meas[1]	
	end			
    lib.add_input(2*ov+v+ow, ov+v+ow, 70, 30, reply)		

    reply = ""  	
    if (qe[2] == 1) then
	    reply = edge[2] .. meas[1]	
    else
        reply = lib.check_number(edge[2],30) .. meas[1]	
    end		
    lib.add_input(2*ov, v, 70, 30, reply)		
	
    reply = "" 	
    if (qe[3] == 1) then
	    reply = edge[3] .. meas[1]	
    else
        reply = lib.check_number(edge[3],30) .. meas[1]
	end		
    lib.add_input(ov-2*v, ov+v+ow, 70, 30, reply)		

    reply = "" 	
    if (qe[4] == 1) then
	    reply = edge[4] .. meas[1]	
    else
        reply = lib.check_number(edge[4],30) .. meas[1]
	end		
    lib.add_input(w+ov-3*v-ow, w+ov-v-ow, 70, 30, reply)		

    reply = "" 	
    if (qe[5] == 1) then
	    reply = edge[5] .. meas[1]	
    else
        reply = lib.check_number(edge[5],30) .. meas[1]	
	end 		
    lib.add_input(w+ov-v, 2*(w+ow), 70, 30, reply)		

    reply = "" 	
    if (qe[6] == 1) then
		reply = edge[6] .. meas[1]
    else
        reply = lib.check_number(edge[6],30) .. meas[1]	
    end		
    lib.add_input(2*w+v, w+ov-v, 70, 30, reply)		

    reply = "" 		 
    if (qa[1] == 1) then
		reply = ang[1] .. meas[2]	
    else
        reply = lib.check_number(ang[1],30) .. meas[2]	
    end		
    lib.add_input(4*v, 3*v-ow, 70, 30, reply)
	
    reply = "" 	
    if (qa[2] == 1) then
		reply = ang[2] .. meas[2]	
    else
        reply = lib.check_number(ang[2],30) .. meas[2]	
    end			
    lib.add_input(5*v-ow, w-v+ow, 70, 30, reply)

    reply = "" 	
    if (qa[3] == 1) then
		reply = ang[3] .. meas[2]	
    else
	    reply = lib.check_number(ang[3],30) .. meas[2]
    end		
    lib.add_input(9*v, 3*v-ow, 70, 30, reply)
	
    reply = "" 	
    if (qa[4] == 1) then
		reply = ang[4] .. meas[2]	 
    else
        reply = lib.check_number(ang[4],30) .. meas[2]	
    end		
    lib.add_input(2*w-3*ow, 2*w-v-ow, 70, 30, reply)
	
    reply = "" 	
    if (qa[5] == 1) then
		reply = ang[5] .. meas[2]		
    else
        reply = lib.check_number(ang[5],30) .. meas[2]	
    end		
    lib.add_input(2*(w-v), 2*ov+3*ow, 70, 30, reply)

    reply = "" 	
    if (qa[6] == 1) then
		reply = ang[6] .. meas[2]				
    else
        reply = lib.check_number(ang[6],30) .. meas[2]
    end		
    lib.add_input(6*v, 2*w-v-ow, 70, 30, reply)
	
	
    for i = 1,15 do
        lib.add_line(v+2*ow, 2*ow+(i-1)*v, 14*v, 0, grid_style, false, false)
    end
    for i = 1,15 do
        lib.add_line(2*ow+i*v, 2*ow, 0, 14*v, grid_style, false, false)
    end
     
  lib.end_canvas()
end             
                
          
            
        