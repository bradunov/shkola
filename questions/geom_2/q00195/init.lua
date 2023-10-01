
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
				
line_style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

dig_style = {["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

text_style = {["font_size"] = "14"}		


edge = {"a", "b", "H", "s"} 
numb = {}
meas = {"cm", "cm²"} 
space = "\( \ \ \ \ \) " 

px = {}
py = {}
quest = ""

min_range = 2
for i = 1,4 do
    if (i < 4) then
		numb[i] = 2 + math.random(10)	
	else
		numb[i] = min_range + numb[3]+ math.random(6)		    
	end
end   
   
ind = math.random(4)

if (ind < 3) then  
	d = 2 * math.sqrt(numb[4]^2 - numb[3]^2)
	quest = meas[1] .. "," .. space .. edge[3] .. " = " .. numb[3] .. meas[1] .. "," .. space .. edge[4] .. " = " .. numb[4] .. meas[1]
	if (ind == 1) then
		numb[1] = math.sqrt(d^2 - numb[2]^2)
		quest = edge[2] .. " = " .. numb[2] .. quest
	else
		numb[2] = math.sqrt(d^2 - numb[1]^2)
		quest = edge[1] .. " = " .. numb[1] .. quest		
    end		
else
	d = 0.5 * math.sqrt(numb[1]^2 + numb[2]^2)
	quest = edge[1] .. " = " .. numb[1] .. meas[1] .. "," .. space .. edge[2] .. " = " .. numb[2] .. meas[1] .. ","	
	if (ind == 3) then
		numb[3] = math.sqrt(numb[4]^2 - d^2)
		quest = quest .. space .. edge[4] .. " = " .. numb[4] .. meas[1] .. "," 		
	else
		numb[4] = math.sqrt(numb[3]^2 + d^2)
		quest = quest .. space .. edge[3] .. " = " .. numb[3] .. meas[1] .. "," 
	end
end	

area = 0.5 * math.sqrt (numb[1]^2 + numb[2]^2) * numb[3]
area = lib.math.round_dec(area, 1)	
numb[ind] = lib.math.round_dec(numb[ind],1)
   
mycanvas = function(no)

  lib.start_canvas(350, 150, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130

	px[1] = w + ow 
	py[1] = ov 			
	px[2] = v + ov 
	py[2] = ov
	px[3] = 3*w 
	py[3] = ov-3*ow		
	px[4] = ov
	py[4] = ov-3*ow	
	px[5] = 2*w+5
	py[5] = ow	
	lib.add_straight_path(px[5], py[5], {{px[4]-px[5], py[4]-py[5]}, {px[2]-px[4], py[2]-py[4]}, {px[5]-px[2], py[5]-py[2]}}, dig_style,  false, false)		
	lib.add_straight_path(px[1], py[1], {{px[2]-px[1], py[2]-py[1]}, {px[3]-px[2], py[3]-py[2]}}, style,  false, false)
	lib.add_straight_path(px[1], py[1], {{px[4]-px[1], py[4]-py[1]}, {px[3]-px[4], py[3]-py[4]}}, line_style,  false, false)	
	for i = 1,3 do
		lib.add_straight_path(px[5], py[5], {{px[i]-px[5], py[i]-py[5]}}, style,  false, false) 	
	end	
	lib.add_straight_path(px[5], py[5], {{px[4]-px[5], py[4]-py[5]}}, line_style,  false, false) 		
	lib.add_straight_path(px[5], py[5], {{0, w+2*ow+4}}, dig_style,  false, false) 

    lib.add_text(2*v, ov+5, "a", text_style, false, false) 
    lib.add_text(2*ov-3*ow, ov-ow, "b", text_style, false, false) 
	lib.add_text(3*v+5, v-2*ow, "s", text_style, false, false) 
	lib.add_text(2*w-5, v, "H", text_style, false, false) 
	lib.add_text(2*w+2*ow, w+3*ow, "Q", text_style, false, false)  

  lib.end_canvas()
end
         