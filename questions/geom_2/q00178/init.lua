
include("terms")

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
		
dif_style = {["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "1"};		

text_style = {["font_size"] = "14"}		


edge = {"a", "H", "d₁", "d"} 
meas = {"cm", "cm²"} 
space = "\( \ \ \ \ \ \ \) " 
numb = {}
area = {}
px = {}
py = {}

quest = ""
ans = ""

min_range = 2
for i = 1,4 do
    if (i < 3) then
		numb[i] = 2 + math.random(10)	
	else
	    if (i == 3) then
			min_range = 3*numb[1] + numb[2]
		else
			min_range = numb[3] + numb[1]
        end			
		numb[i] = min_range + math.random(10)		    
	end
end   
   
ind = math.random(5)

ch = math.random(3)

if (ind < 4) then  
	s = numb[1]^2 
	quest = edge[1] .. " = " .. numb[1] .. meas[1] .. "," .. space .. edge[ind+1] .. " = " .. numb[ind+1] .. meas[1]
	if (ind == 1) then
		numb[3] = math.sqrt (3*s + numb[2]^2)
		numb[3] = lib.math.round_dec(numb[3],1)			
		numb[4] = math.sqrt (4*s + numb[2]^2)	
		numb[4] = lib.math.round_dec(numb[4],1)			
        ans = edge[3] .. " = " .. lib.check_number(numb[3]) .. meas[1] 
        if (ch == 1) then 
			ans = ans .. "," .. space .. edge[4] .. " = " .. lib.check_number(numb[4]) .. meas[1]
		end 		
	else			
		if (ind == 2) then	
			numb[2] = math.sqrt (numb[3]^2 - 3*s)				
		else
			numb[2] = math.sqrt (numb[4]^2 - 4*s)			 					 			
		end	
		numb[2] = lib.math.round_dec(numb[2],1)		
		ans = edge[2] .. " = " .. lib.check_number(numb[2]) .. meas[1]
		if (ind == 2) then			
			numb[4] = math.sqrt (4*s + numb[2]^2)			
			numb[4] = lib.math.round_dec(numb[4],1)	
			if (ch == 1) then 
				ans = ans .. "," .. space .. edge[4] .. " = " .. lib.check_number(numb[4]) .. meas[1]
			end 					
		else	
			numb[3] = math.sqrt (3*s + numb[2]^2)		 			
			numb[3] = lib.math.round_dec(numb[3],1)		 
			if (ch == 1) then 
				ans = ans .. "," .. space .. edge[3] .. " = " .. lib.check_number(numb[3]) .. meas[1]
			end 				
		end	
	end
else
	s = numb[2]^2 	
	quest = edge[2] .. " = " .. numb[2] .. meas[1] .. "," .. space .. edge[ind-1] .. " = " .. numb[ind-1] .. meas[1] 
	if (ind == 4) then
		numb[1] = math.sqrt ((numb[3]^2 - s)/3)
		numb[1] = lib.math.round_dec(numb[1],1)			
    else		
		numb[1] = math.sqrt ((numb[4]^2 - s)/4)
		numb[1] = lib.math.round_dec(numb[1],1)				
    end	
	ans = edge[1] .. " = " .. lib.check_number(numb[1]) .. meas[1] 		
	if (ind == 4) then	
		numb[4] = math.sqrt (4*numb[1]^2+s)	
		numb[4] = lib.math.round_dec(numb[4],1)		 
		if (ch == 1) then 
			ans = ans .. "," .. space .. edge[4] .. " = " .. lib.check_number(numb[4]) .. meas[1]
		end 			
    else		
		numb[3] = math.sqrt (3*numb[1]^2+s)
		numb[3] = lib.math.round_dec(numb[3],1)		
		if (ch == 1) then 
			ans = ans .. "," .. space .. edge[3] .. " = " .. lib.check_number(numb[3]) .. meas[1]
		end 			
    end	
end	

ans2 = ""
note = ""
if (ch > 1) then
	s = numb[1] * numb[2]
	area[1] = lib.math.round_dec(2 * s,1)	
	area[2] = lib.math.round_dec(s * math.sqrt(3),1)
	note = text[ch-1]  
	if (ch == 3) then
	    ans2 =  "P₁ = " .. lib.check_number(area[2],50).. meas[2]
    else
	    ans2 = "P = " .. lib.check_number(area[1],50).. meas[2]	
    end
end	


  
mycanvas = function(no)

  lib.start_canvas(350, 160, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130
	
	px[1] = ov 
	py[1] = v
	px[2] = v+ov 
	py[2] = v
	px[3] = v+ov 
	py[3] = ov+2*ow
	px[4] = ov 
	py[4] = ov+2*ow		
	px[5] = ov-2*ow 
	py[5] = 2*ow
	px[6] = 2*w+2*ow 
	py[6] = 2*ow	
	px[7] = 2*w+2*ow 
	py[7] = w+2*ow
	px[8] = ov-2*ow 
	py[8] = w+2*ow		
	px[9] = w 
	py[9] = 4*ow
	px[10] = 3*w-ow 
	py[10] = v-2*ow
	px[11] = 3*w-ow 
	py[11] = ov
	px[12] = w 
	py[12] = ov-ow			

	lib.add_straight_path (px[5], py[5], {{px[10]-px[5], py[10]-py[5]}, {px[11]-px[10], py[11]-py[10]}, {px[8]-px[11], py[8]-py[11]}, {px[5]-px[8], py[5]-py[8]}}, dif_style, true, false)	
	lib.add_straight_path (px[5], py[5], {{px[11]-px[5], py[11]-py[5]}}, style,  false, false)
	lib.add_straight_path (px[5], py[5], {{px[2]-px[5], py[2]-py[5]}, {px[3]-px[2], py[3]-py[2]}, {px[8]-px[3], py[8]-py[3]}, {px[5]-px[8], py[5]-py[8]} }, dig_style, true, false)
	lib.add_straight_path (px[6], py[6], {{px[7]-px[6], py[7]-py[6]}, {px[8]-px[7], py[8]-py[7]}, {px[5]-px[8], py[5]-py[8]}}, line_style, true, false)
	lib.add_rectangle (px[1], py[1], px[2]-px[1], py[4]-py[1], style, true, false)
	lib.add_straight_path(px[1], py[1], {{px[9]-px[1], py[9]-py[1]}, {px[5]-px[9], py[5]-py[9]}, {px[6]-px[5], py[6]-py[5]}, {px[10]-px[6], py[10]-py[6]},{px[2]-px[10], py[2]-py[10]}}, style,  false, false) 
	lib.add_straight_path(px[4], py[4], {{px[12]-px[4], py[12]-py[4]}, {px[9]-px[12], py[9]-py[12]}}, style,  false, false)
	lib.add_straight_path(px[3], py[3], {{px[11]-px[3], py[11]-py[3]}, {px[10]-px[11], py[10]-py[11]}}, style,  false, false)
	lib.add_straight_path(px[12], py[12], {{px[8]-px[12], py[8]-py[12]}}, line_style,  false, false) 
	lib.add_straight_path(px[11], py[11], {{px[7]-px[11], py[7]-py[11]}}, line_style,  false, false) 
	lib.add_straight_path (px[5], py[5], {{px[3]-px[5], py[3]-py[5]}}, style,  false, false) 	

    lib.add_text(2*w, ov+2*ow+5, "a", text_style, false, false) 
    lib.add_text(w+ow, ov+ow, "a", text_style, false, false) 
    lib.add_text(3*v+ow, ov+ow+5, "a", text_style, false, false) 
	lib.add_text(3*w+3, v+5, "H", text_style, false, false) 
	lib.add_text(2*v+ow, v-ow-5, "d", text_style, false, false) 
	lib.add_text(2*v+ow, w+2*ow+5, "P", text_style, false, false)   
	lib.add_text(3*v-5, v-ow-5, "P₁", text_style, false, false) 
	lib.add_text(3*v+5, w+2*ow+5, "d₁", text_style, false, false)  
	
  lib.end_canvas()
end
                