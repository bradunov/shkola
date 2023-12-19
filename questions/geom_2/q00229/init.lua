
include("terms")

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
				
line_style = {["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "1"};

blue_style = {["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

yelow_style = {["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};	

dif_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "none",
        ["line_width"] = "1"};

text_style = {["font_size"] = "16"}		


edge = {"R", "r", "H", "O", "P", "q", "Q"} 
meas = {"cm", "cm²"} 
space = "\( \ \ \ \ \) " 
quest = {""}
ans = {""}

numb = {}
px = {}
py = {}
index = {}
out = {}

pi = 22/7
 
numb[2] = 4 + math.random(8)	
numb[1] = numb[2] + math.random(10)	
numb[3] = math.sqrt(numb[1]^2 - numb[2]^2)
numb[4] = 2 * pi * numb[1]
numb[5] = pi * numb[1]^2
numb[6] = 2 * pi * numb[2]
numb[7] = pi * numb[2]^2

ind = math.random(15)
if (ind < 5) then
    dat1 = 1
    if (ind > 1) then
        if (ind == 2) then
		    dat2 = 3
	        numb[3] = math.ceil(numb[3]) 
            numb[2] = math.sqrt(numb[1]^2 - numb[3]^2)
			numb[6] = 2 * pi * numb[2]
			numb[7] = pi * numb[2]^2			
        else			
			if (ind == 3) then
				dat2 = 6
				numb[6] = math.ceil(numb[6]) 
				numb[2] = numb[6] / (2 * pi)
				numb[3] = math.sqrt(numb[1]^2 - numb[2]^2)
				numb[7] = pi * numb[2]^2				
			else
				dat2 = 7			
				numb[7] = math.ceil(numb[7]) 
				numb[2] = math.sqrt(numb[7] / pi)
				numb[3] = math.sqrt(numb[1]^2 - numb[2]^2)
				numb[6] = 2 * pi * numb[2]	
            end
        end
    else
		dat2 = 2 	
    end	
else
	if (ind < 8) then
		dat1 = 2
		if (ind == 5) then
		    dat2 = 3
	        numb[3] = math.ceil(numb[3]) 
            numb[1] = math.sqrt(numb[2]^2 + numb[3]^2)
			numb[4] = 2 * pi * numb[1]
			numb[5] = pi * numb[1]^2			
        else			
			if (ind == 6) then
			    dat2 = 4
				numb[4] = math.ceil(numb[4]) 
				numb[1] = numb[4] / (2 * pi)
				numb[3] = math.sqrt(numb[1]^2 - numb[2]^2)
				numb[5] = pi * numb[1]^2					
			else
                dat2 = 5			
				numb[5] = math.ceil(numb[5]) 
				numb[1] = math.sqrt(numb[5] / pi)
				numb[3] = math.sqrt(numb[1]^2 - numb[2]^2)
				numb[4] = 2 * pi * numb[1]	
            end
        end	
    else
		if (ind < 12) then
			numb[3] = math.ceil(numb[3])
			dat1 = 3
			if (ind < 10) then
				if (ind == 8) then
					dat2 = 4
					numb[4] = math.ceil(numb[4])
					numb[1] = numb[4] / (2 * pi)
					numb[5] = pi * numb[1]^2					
				else
					dat2 = 5
					numb[5] = math.ceil(numb[5])
					numb[1] = math.sqrt(numb[5] / pi)
					numb[4] = 2 * pi * numb[1]					
				end	
				numb[2] = math.sqrt(numb[1]^2 - numb[3]^2)				
				numb[6] = 2 * pi * numb[2]
				numb[7] = pi * numb[2]^2				
			else			
				if (ind == 10) then
					dat2 = 6
					numb[6] = math.ceil(numb[6]) 
					numb[2] = numb[6] / (2 * pi)
					numb[7] = pi * numb[2]^2
				else	
					dat2 = 7
					numb[7] = math.ceil(numb[7]) 
					numb[2] = math.sqrt(numb[7] / pi)
					numb[6] = 2 * pi * numb[2]
				end
				numb[1] = math.sqrt(numb[2]^2 + numb[3]^2)				
				numb[4] = 2 * pi * numb[1]
				numb[5] = pi * numb[1]^2					
			end	
		else
			if (ind < 14) then		
				numb[4] = math.ceil(numb[4])
				dat1 = 4
				numb[1] =  numb[4] / (2 * pi)			
				numb[5] = pi * numb[1]^2					
				if (ind == 12) then
					dat2 = 6
					numb[6] = math.ceil(numb[6])
					numb[2] = numb[6] / (2 * pi)
					numb[7] = pi * numb[1]^2				
				else
					dat2 = 7
					numb[7] = math.ceil(numb[7])
					numb[2] = math.sqrt(numb[7] / pi)
					numb[6] = 2 * pi * numb[2]	
                end	
            else		
				numb[5] = math.ceil(numb[5])
				dat1 = 5
				numb[1] = math.sqrt(numb[5] / pi)	
				numb[4] = 2 * pi * numb[1]				
				if (ind == 14) then
					dat2 = 6
					numb[6] = math.ceil(numb[6])
					numb[2] = numb[6] / (2 * pi)
					numb[7] = pi * numb[1]^2				
				else
					dat2 = 7
					numb[7] = math.ceil(numb[7])
					numb[2] = math.sqrt(numb[7] / pi)
					numb[6] = 2 * pi * numb[2]	
				end				
			end
			numb[3] = math.sqrt(numb[1]^2 - numb[2]^2)
		end	
	end
end	

quest[1] = elem[dat1] .. space .. edge[dat1] .. " = " .. numb[dat1] 
quest[2] = elem[dat2] .. space .. edge[dat2] .. " = " .. numb[dat2] 
if (dat1 == 5 or dat1 == 7) then
	quest[1] = quest[1] .. meas[2]
else
	quest[1] = quest[1] .. meas[1]	
end	
if (dat2 == 5 or dat2 == 7) then
	quest[2] = quest[2] .. meas[2]
else
	quest[2] = quest[2] .. meas[1]	
end				

nr = 0
for i = 1,7 do
    if (i ~= dat1 and i ~= dat2) then
		nr = nr + 1
		index[nr] = i
	end
end
out = lib.math.random_shuffle(index)
for i = 1,2 do
	tmp = lib.math.round_dec(numb[out[i]], 1)
    ans[i] = elem[out[i]] .. space .. edge[out[i]] .. " = " 
	if (out[i] == 5 or out[i] == 7) then
	    ans[i] = ans[i] .. lib.check_number(tmp,40) .. meas[2]
	else
	    ans[i] = ans[i] .. lib.check_number(tmp) .. meas[1]
    end		
end

mycanvas = function(no)

  lib.start_canvas(300, 140, "center")

	w = 80
	ow = 10
	v = 70
	ov =  130
	rt = 2
	scal = 0.75

	px[1] = w 
	py[1] = v	
	px[2] = px[1] + ov/2
	py[2] = py[1]
	px[3] = px[1] + ov
	py[3] = py[1]	 
	px[4] = px[1] + ov/2
	py[4] = 3*ow 		
	f1 = ov/2
	f2 = 2*ow
	lib.add_circle (px[2], py[2], f1, style, true, false)		
	lib.add_ellipse(px[2], py[2], f1, f2, style,  false, false )
	lib.add_straight_path(px[1],py[1], {{ow, -f2-5}, {ov-2*ow, 0}, {ow, f2+5} }, dif_style,  false, false)		
	lib.add_ellipse(px[2], py[2], f1, f2, yelow_style,  false, false )		

	lib.add_ellipse(px[4], py[4], scal*f1, scal*f2, blue_style,  false, false )

	lib.add_straight_path(px[2],py[2], {{ov/2, 0}}, line_style,  false, false) 
	lib.add_straight_path(px[4],py[4], {{-scal*f1, 0}}, line_style,  false, false)
	lib.add_straight_path(px[4],py[4], {{px[2]-px[4], py[2]-py[4]}}, line_style,  false, false)

	lib.add_text(ov+5, 5*ow, "H", text_style, false, false) 
	lib.add_text(ov-ow, 2*ow, "r", text_style, false, false) 
	lib.add_text(2*(w+ow), v-ow, "R", text_style, false, false) 

	lib.add_circle (px[2], py[2], rt, point_style, true, false)
	lib.add_circle (px[4], py[4], rt, point_style, true, false)


--[[
	for i = 1,4 do	
		lib.add_circle (px[i], py[i], rt, point_style, true, false)	
		lib.add_text(px[i], py[i]-ow, i, text_style, false, false)	
	end		
]]--
 
  lib.end_canvas()
end            
    
    
            
            