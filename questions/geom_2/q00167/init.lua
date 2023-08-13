
include("terms")

front_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

up_style = 
	{["off_color"] = "f00",
        ["on_color"] = "f00",
        ["line_color"] = "000",
        ["line_width"] = "2"};			
		
side_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "2"};				
		
line_style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};	

text_style = {["font_size"] = "14"}		


edge = {"a", "c", "e", "g", "b", "d", "f", "h", "m", "n", "p", "q"} 

plane = {}
plane[1] = {1, 3, 9, 10}               --[[zelena]]--
plane[2] = {2, 4, 12, 11}
plane[3] = {3, 4, 7, 8}                --[[crvena]]--
plane[4] = {1, 2, 6, 5} 
plane[5] = {5, 7, 10, 11}              --[[žuta]]--
plane[6] = {6, 8, 9, 12}

dim_e = 12
dim_p = 3
ch = {}
ind = {}

 --[[ prava/prava ]]--
 
reply = "none"
for i = 1, dim_e do
	ch[i] = i
end
ch = lib.math.random_shuffle(ch)
for k = 1,3 do
	left = 4*(k-1)
	right = 4*k
	if (ch[1] > left and ch[1] <= right and ch[2] > left and ch[2] <= right) then 
		reply = msg_line[3]
	end
end		
if (reply == "none") then
	for i = 1,2 do
	    ind[i] = {}
		nr = 0		
		for k = 1,6 do
		    for j = 1,4 do
				if (ch[i] == plane[k][j]) then
				    nr = nr + 1
				    ind[i][nr] = k
                end					
            end
		end
	end	
	reply = msg_line[2]	
    for j = 1,2 do	
		if (ind[1][j] == ind[2][1] or ind[1][j] == ind[2][2]) then
		    reply = msg_line[1]
        end	
    end		
end	
term = edge[ch[1]] .. " " .. text .. " " .. edge[ch[2]] .. " " .. lib.check_one_option_dropdown(msg_line, reply)   		

 --[[ prava/ravan ]]--
 
ch[1] = math.random(dim_e)
ch[2] = math.random(dim_p)

reply2 = "none"
for j = 1,4 do
	if (ch[1] == plane[2*ch[2]-1][j]) then
		reply2 = msg_plane[1]
	end					
end
if (reply2 == "none") then
	reply2 = msg_plane[2]
	for j = 1,4 do
		if (ch[1] == plane[2*ch[2]][j]) then
			reply2 = msg_plane[3]
		end					
	end
end 


mycanvas = function(no)

  lib.start_canvas(350, 150, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130

    lib.add_rectangle (v, v-2*ow, ov, w, front_style, true, false)
    lib.add_straight_path(v, v-2*ow, {{4*ow, -3*ow}, {ov, 0}, {-4*ow, 3*ow}, {-ov, 0}}, up_style,  false, false)
    lib.add_straight_path(ov+v, v-2*ow, {{4*ow, -3*ow}, {0, w}, {-4*ow, 3*ow}, {0, -w}}, side_style,  false, false)
    lib.add_rectangle (ov-2*ow, 2*ow, ov, w, line_style, true, false)
    lib.add_straight_path(v, ov, {{4*ow, -3*ow}}, line_style,  false, false) 
 
    lib.add_text(2*v, ov+5, "a", text_style, false, false) 
    lib.add_text(2*ov-4*ow, ov-ow, "b", text_style, false, false) 
    lib.add_text(2*w, w+2*ow+5, "c", text_style, false, false) 
    lib.add_text(w+2*ow, w+3*ow+3, "d", text_style, false, false) 
   
    lib.add_text(2*v, w/2, "e", text_style, false, false)
    lib.add_text(ov+w, 3*ow+5, "f", text_style, false, false) 
    lib.add_text(2*w, ow, "g", text_style, false, false)    
    lib.add_text(w+ow, 2*ow+5, "h", text_style, false, false)

	lib.add_text(v-ow, w, "m", text_style, false, false)
	lib.add_text(v+ov-ow, w, "n", text_style, false, false) 
	lib.add_text(3*w-7, v-5, "p", text_style, false, false)    
	lib.add_text(v+3*ow+3, v, "q", text_style, false, false)
 
  lib.end_canvas()
end
    