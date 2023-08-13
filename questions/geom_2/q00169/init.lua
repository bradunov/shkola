
include("terms")

green_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

red_style = 
	{["off_color"] = "f00",
        ["on_color"] = "f00",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

pink_style = 
	{["off_color"] = "f9c",
        ["on_color"] = "f9c",
        ["line_color"] = "000",
        ["line_width"] = "2"};			
		
yelow_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

blue_style = 
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "000",
        ["line_width"] = "2"};				
		
style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

text_style = {["font_size"] = "14"}		

symb = {"∥", "⟂", "∅", "∈", "∋"}
edge = {"AB", "CD", "EF", "GH", "BC", "AD", "FG", "EH", "AE", "BF", "CG", "DH"} 
space = "\( \ \ \ \ \) "

plane = {}
plane[1] = {1, 3, 9, 10}               --[[bela]]--
plane[2] = {2, 4, 12, 11}              --[[plava]]--
plane[3] = {3, 4, 7, 8}                --[[crvena]]--
plane[4] = {1, 2, 6, 5}                --[[pink]]--
plane[5] = {5, 7, 10, 11}              --[[žuta]]--
plane[6] = {6, 8, 9, 12}               --[[zelena]]--

ans = {""}

dim_e = 12
dim_p = 6
ch = {}
cp = {}
ind = {}

mycanvas = function(no)

  lib.start_canvas(350, 150, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130

    lib.add_rectangle (ov-2*ow, 2*ow, ov, w, blue_style, true, false)
    lib.add_rectangle (v, v-2*ow, ov, w, style, true, false)
    lib.add_straight_path(v, ov, {{4*ow, -3*ow}, {0, -w}, {-4*ow, 3*ow}, {0, w}}, green_style,  false, false) 
    lib.add_straight_path(v, v-2*ow+w, {{4*ow, -3*ow}, {ov, 0}, {-4*ow, 3*ow}, {-ov, 0}}, pink_style,  false, false)
    lib.add_straight_path(v, v-2*ow, {{4*ow, -3*ow}, {ov, 0}, {-4*ow, 3*ow}, {-ov, 0}}, red_style,  false, false)
    lib.add_straight_path(ov+v, v-2*ow, {{4*ow, -3*ow}, {0, w}, {-4*ow, 3*ow}, {0, -w}}, yelow_style,  false, false)

    lib.add_text(w-ow, ov+ow, "A", text_style, false, false) 
    lib.add_text(ov+v, ov+ow, "B", text_style, false, false) 
    lib.add_text(2*ov-ow, w+2*ow, "C", text_style, false, false) 
    lib.add_text(w+2*ow, w+2*ow, "D", text_style, false, false) 
    lib.add_text(w-ow, 4*ow, "E", text_style, false, false) 
    lib.add_text(ov+v, 4*ow, "F", text_style, false, false) 
    lib.add_text(2*ov-ow-5, ow, "G", text_style, false, false) 
    lib.add_text(w+2*ow+5, ow, "H", text_style, false, false) 

  lib.end_canvas()
end
      
--[[ prava/prava ]]--

for it = 1,2 do 
	reply = "none"
	for i = 1, dim_e do
		ch[i] = i
	end
	ch = lib.math.random_shuffle(ch)
    ans[it] = ""
	for k = 1,3 do
		left = 4*(k-1)
		right = 4*k
		if (ch[2*it-1] > left and ch[2*it-1] <= right and ch[2*it] > left and ch[2*it] <= right) then 
			reply = symb[1]
		end
	end		
	if (reply == "none") then
		for i = 1,2 do
			ind[i] = {}
			nr = 0		
			for k = 1,6 do
				for j = 1,4 do
					if (ch[2*(it-1)+i] == plane[k][j]) then
						nr = nr + 1
						ind[i][nr] = k
					end					
				end
			end
		end	
		reply = symb[3]	
		for j = 1,2 do	
			if (ind[1][j] == ind[2][1] or ind[1][j] == ind[2][2]) then
				reply = symb[2]
			end	
		end		
	end	
	ans[it] = edge[ch[2*it-1]] .. " " .. lib.check_one_option_dropdown(symb, reply) .. " " .. edge[ch[2*it]] 
end    		

--[[ prava/ravan ]]--
 
che = math.random(dim_e)
chp = math.random(dim_p)

reply2 = "none"
for j = 1,4 do
	if (che == plane[chp][j]) then
		reply2 = symb[4]
	end					
end
if (reply2 == "none") then
	reply2 = symb[2]	
	if (chp == 2 * math.floor(chp/2)) then
		for j = 1,4 do
			if (che == plane[chp-1][j]) then
				reply2 = symb[1]
			end					
		end
	else	
		for j = 1,4 do
			if (che == plane[chp+1][j]) then
				reply2 = symb[1]
			end					
		end
	end	
end	
sg = math.random(2)
if (sg == 2 and reply2 == symb[4]) then 
    reply2 = symb[5]    
	ans[1] = ans[1] .. "," .. space .. colour[chp] .. " " .. lib.check_one_option_dropdown(symb, reply2) .. " " .. edge[che]
else
	ans[1] = ans[1] .. "," .. space .. edge[che] .. " " .. lib.check_one_option_dropdown(symb, reply2) .. " " .. colour[chp]
end	

--[[ ravan/ravan ]]--
 
for i = 1, dim_p do
	cp[i] = i
end
cp = lib.math.random_shuffle(cp)
if (cp[1] == 2 * math.floor(cp[1]/2)) then
	if (cp[2] == cp[1] - 1) then
		reply3 = symb[1]
	else 
		reply3 = symb[2]	
	end
else	
	if (cp[2] == cp[1] + 1) then
		reply3 = symb[1]
	else 
		reply3 = symb[2]		
	end	
end					
ans[2] = ans[2] .. "," .. space .. colour[cp[1]] .. " " .. lib.check_one_option_dropdown(symb, reply3) .. " " .. colour[cp[2]]



            