
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};		

dif_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};			

dark_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "none",
        ["off_line_color"] = "none",
        ["line_width"] = "1"};	
		
brown_style = 
	{["off_color"] = "fff",
        ["on_color"] = "c60",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "1"};			

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};					

line_style = 
	{["line_color"] = "000",
        ["line_width"] = "1"};		
				
text_style = {["font_size"] = "14"}	
	

x = {}
y = {}
px = {}
py = {}
out = {}
index = {}
stampa = {}
stx = {}
sty = {}
ind = {}
op = {}

gridx = 15
gridy = 15

sg = math.random(2)     --[[zahtev zadatka]]--	

dim = 13
for i = 1,dim do
    index[i] = i
	op[i] = math.random(2)
    if (op[i] == sg) then
        ind[i] = 1
	else   	
		ind[i] = 0
	end	
end	
out = lib.math.random_shuffle(index)

for i = 1,dim do
	stampa[i] = 0
	stx[i] = 0
	sty[i] = 0
	for j = 1,4 do	
		if (out[j] == i) then
			stampa[i] = 1
			if (j > 2) then
				sty[i] = 1
			else
				sty[i] = 0
			end	
			if (j ==1 or j == 3) then
				stx[i] = 0
			else
				stx[i] = 1
			end					
		end	
	end
end


results = ""
for i = 1, 4 do
  if i > 1 then
    results = results .. " && "
  end
  if (ind[out[i]] == 1) then
     results = results .. "result[" .. tostring(i-1) .. "] == 1"
  else
     results = results .. "result[" .. tostring(i-1) .. "] == 0"
  end
end


mycanvas = function(no)

  lib.start_canvas(300, 260, "center", results)  
  
	w = 20
	ow = 10
	dx = 20
	dy = 15
	shift_x = math.floor(gridx/2)*dx
	shift_y = math.floor((gridy + 1)/2)*dy
	rt = 2 

	for i = 1,gridy+2 do
		y[i] = ow+(i-1)*dy
	end
	for i = 1,gridx+1 do
		x[i] = ow+(i-1)*dx
	end

for i = 1,4 do
	if (i > 2) then
		yy = (gridy+1)*dy
	else
		yy = dy
	end	
	if (i == 1 or i == 3) then
		xx = dx
	else
		xx = (gridx-1)*dx
	end					   
	lib.add_circle (xx, yy, 6, brown_style, false, true)
end	
		
--[[1]]--
if (stampa[1] == 1) then
	ch = math.random(2) 
	fctx = stx[1] * shift_x
	fcty = sty[1] * shift_y
	px[1] = x[6] + fctx
	py[1] = y[6] + fcty
	px[2] = x[2] + fctx
	py[2] = y[5] + fcty
	px[3] = x[4] + fctx
	py[3] = y[2] + fcty	
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[1] == 1) then
			lib.add_straight_path(px[1], py[1]-w-3,  {{-9,4}, {9, 6}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-w-4, py[1]+5,  {{3,-8,}, {6, 8}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[2]-px[1],py[2]-py[1]}, {0, py[1]-py[2]+w}, {px[1]-px[2]+w,0}, {0, py[3]-py[1]-w}, {px[3]-px[1]-w,0}, {px[1]-px[3],py[1]-py[3]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)	
		if (op[1] == 2) then
			lib.add_straight_path(px[1]-w, py[1]-ow-2,  {{8,-2}, {0, 8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-w-2, py[1]-ow,  {{3,8}, {6, -6}}, dif_style,  true, false)		
		end
	end
end		
--[[2]]--
if (stampa[2] == 1) then
	ch = math.random(2)   
	fctx = stx[2] * shift_x
	fcty = sty[2] * shift_y      
	px[2] = x[7] + fctx
	py[2] = y[7] + fcty
	px[1] = x[3] + fctx
	py[1] = y[6] + fcty
	px[3] = x[5] + fctx
	py[3] = y[2] + fcty	
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[2] == 1) then
			lib.add_straight_path(px[1]+ow+3, py[1]+ow,  {{7,-7}, {2, 9}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1], py[1]-w+5,  {{10,-2}, {-4, -8}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[3]-px[1],py[3]-py[1]}, {px[1]-px[3]-w,0}, {0, py[2]-py[3]+ow}, {px[2]-px[1]+w,-ow}, {px[1]-px[2],py[1]-py[2]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[2] == 2) then
			lib.add_straight_path(px[1]+ow+4, py[1]-6,  {{6,8}, {2, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+ow+4, py[1]-7, {{-3,-8}, {8, 2}}, dif_style,  true, false)		
		end
	end
end	
--[[3]]--
if (stampa[3] == 1) then
	ch = math.random(2) 
	fctx = stx[3] * shift_x
	fcty = sty[3] * shift_y
	px[2] = x[7] + fctx
	py[2] = y[5] + fcty
	px[1] = x[3] + fctx
	py[1] = y[4] + fcty
	px[3] = x[5] + fctx
	py[3] = y[8] + fcty	
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[3] == 1) then
			lib.add_straight_path(px[1], py[1]+w-5,  {{9,3}, {-8, 6}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+w-5, py[1]-6,  {{7,8}, {2, -8}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[2]-px[1],py[2]-py[1]}, {0, py[1]-py[2]-w}, {px[1]-px[2]-w,0}, {0, 2*w}, {px[3]-px[1]+w,py[3]-py[1]-w}, {px[1]-px[3],py[1]-py[3]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[3] == 2) then
			lib.add_straight_path(px[1]+w, py[1]+w-8,  {{-8,4}, {0, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+w-8, py[1]+ow,  {{8,-8}, {0, 8}}, dif_style,  true, false)		
		end
	end
end
--[[4]]--
if (stampa[4] == 1) then
	ch = math.random(2) 
	fctx = stx[4] * shift_x
	fcty = sty[4] * shift_y
	px[1] = x[6] + fctx
	py[1] = y[4] + fcty
	px[2] = x[2] + fctx
	py[2] = y[3] + fcty
	px[3] = x[4] + fctx
	py[3] = y[7] + fcty	
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[4] == 1) then
			lib.add_straight_path(px[1]-w, py[1]-ow-3,  {{0,8}, {8, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-5, py[1]+w-4,  {{-8,1}, {5, 7}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[2]-px[1],py[2]-py[1]}, {0, w-py[2]+fcty}, {px[1]-px[2]+w,0}, {0, py[3]-py[2]+w}, {px[3]-px[1]-w,0}, {px[1]-px[3],py[1]-py[3]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)	
		if (op[4] == 2) then
			lib.add_straight_path(px[1]-w-2, py[1]+6,  {{2,-8}, {6, 8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-w-2, py[1]+7,  {{7,6}, {0, -8}}, dif_style,  true, false)		
		end
	end
end	
--[[ind = 5]]--
if (stampa[5] == 1) then
	ch = math.random(2)     
	fctx = stx[5] * shift_x
	fcty = sty[5] * shift_y
	px[2] = x[7] + fctx
	py[2] = y[6] + fcty
	px[1] = x[4] + fctx
	py[1] = y[6] + fcty
	px[3] = x[2] + fctx
	py[3] = y[2] + fcty	
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[5] == 1) then
			lib.add_straight_path(px[1]+ow+3, py[1]+ow,  {{7,-7}, {2, 9}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-w+7, py[1]-7,  {{2,-9}, {-9, 2}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[3]-px[1],py[3]-py[1]}, {0,py[1]-py[3]+w}, {px[2]-px[3], 0}, {0,-w}, {px[1]-px[2],py[1]-py[2]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[5] == 2) then
			lib.add_straight_path(px[1]+ow+4, py[1]-6,  {{6,8}, {2, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1], py[1]-ow-4, {{-9,-4}, {9, -5}}, dif_style,  true, false)		
		end
	end	
end
--[[ind = 6]]--
if (stampa[6] == 1) then
	ch = math.random(2)      
	fctx = stx[6] * shift_x
	fcty = sty[6] * shift_y
	px[1] = x[5] + fctx
	py[1] = y[6] + fcty
	px[2] = x[2] + fctx
	py[2] = y[6] + fcty
	px[3] = x[7] + fctx
	py[3] = y[2] + fcty
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[6] == 2) then
			lib.add_straight_path(px[1]-w-3, py[1]+8,  {{3,-8}, {5, 8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+ow+2, py[1]-ow+2,  {{-2,-10}, {10, 4}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)

		lib.add_straight_path(px[1], py[1], {{px[3]-px[1],py[3]-py[1]}, {0, py[1]-py[3]+w}, {px[2]-px[3],0}, {0,-w}, {px[1]-px[2],0}}, dark_style,  true, false)	

		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[6] == 1) then
			lib.add_straight_path(px[1]-w-3, py[1]-8,  {{4,8}, {4, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1], py[1]-w+5, {{10,0}, {-8, -8}}, dif_style,  true, false)		
		end
	end	
end	
--[[ind = 7]]--
if (stampa[7] == 1) then
	ch = math.random(2)     
	fctx = stx[7] * shift_x
	fcty = sty[7] * shift_y
	px[1] = x[5] + fctx
	py[1] = y[4] + fcty
	px[2] = x[2] + fctx
	py[2] = y[4] + fcty
	px[3] = x[7] + fctx
	py[3] = y[8] + fcty
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[7] == 1) then
			lib.add_straight_path(px[1]-w-3, py[1]-8,  {{3,8}, {5, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+ow+3, py[1]+ow-2, {{0,9}, {9,-7}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)

		lib.add_straight_path(px[1], py[1], {{px[2]-px[1],py[2]-py[1]}, {0,-w}, {px[3]-px[2],0}, {0, py[3]-py[1]+w}, {px[1]-px[3],py[1]-py[3]}}, dark_style,  true, false)	

		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[7] == 2) then
			lib.add_straight_path(px[1]-w-3, py[1]+8,  {{3,-8}, {5, 8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1], py[1]+w+3, {{8,-5}, {-8, -4}}, dif_style,  true, false)		
		end
	end
end	
--[[ind = 8]]--
if (stampa[8] == 1) then
	ch = math.random(2)      
	fctx = stx[8] * shift_x
	fcty = sty[8] * shift_y
	px[1] = x[4] + fctx
	py[1] = y[4] + fcty
	px[2] = x[7] + fctx
	py[2] = y[4] + fcty
	px[3] = x[2] + fctx
	py[3] = y[8] + fcty	
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[8] == 2) then
			lib.add_straight_path(px[1]+w-5, py[1]-ow, {{5,9}, {4, -9}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-w+7, py[1]+7,  {{0,9}, {-9, -2}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[3]-px[1],py[3]-py[1]}, {0,py[1]-py[3]-w}, {px[2]-px[3], 0}, {0,w}, {px[1]-px[2],py[1]-py[2]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[8] == 1) then
			lib.add_straight_path(px[1]+ow+4, py[1]+7,  {{6,-8}, {2, 8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1], py[1]+w-5, {{-9,4}, {9, 5}}, dif_style,  true, false)		
		end
	end				
end
--[[ind = 9]]--
if (stampa[9] == 1) then
	ch = math.random(2)      
	fctx = stx[9] * shift_x
	fcty = sty[9] * shift_y
	px[2] = x[7] + fctx
	py[2] = y[6] + fcty
	px[1] = x[3] + fctx
	py[1] = y[6] + fcty
	px[3] = x[3] + fctx
	py[3] = y[2] + fcty	
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[9] == 1) then
			lib.add_straight_path(px[1]+ow+3, py[1]+ow,  {{7,-7}, {2, 9}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-8, py[1]-ow-6,  {{8,-4}, {-9, -2}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[3]-px[1],py[3]-py[1]}, {-w,0}, {0,py[1]-py[3]+w}, {px[2]-px[3]+w, 0}, {0,-w}, {px[1]-px[2],py[1]-py[2]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[9] == 2) then
			lib.add_straight_path(px[1]+ow+4, py[1]-6,  {{6,8}, {2, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+8, py[1]-ow-3, {{-9,-6}, {9, -2}}, dif_style,  true, false)		
		end
	end	
end
--[[ind = 10]]--
if (stampa[10] == 1) then
	ch = math.random(2)     
	fctx = stx[10] * shift_x
	fcty = sty[10] * shift_y
	px[1] = x[6] + fctx
	py[1] = y[6] + fcty
	px[2] = x[2] + fctx
	py[2] = y[6] + fcty
	px[3] = x[6] + fctx
	py[3] = y[2] + fcty
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[10] == 2) then
			lib.add_straight_path(px[1]-w-3, py[1]+8,  {{3,-8}, {5, 8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+7, py[1]-w-2,  {{-8,2}, {8, 4}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[3]-px[1],py[3]-py[1]}, {w,0}, {0, py[1]-py[3]+w}, {px[2]-px[1]-w,0}, {0,-w}, {px[1]-px[2],0}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[10] == 1) then
			lib.add_straight_path(px[1]-w-3, py[1]-8,  {{4,8}, {4, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-ow, py[1]-ow-2, {{8,-7}, {-8, -2}}, dif_style,  true, false)		
		end
	end
end
--[[ind = 11]]--
if (stampa[11] == 1) then
	ch = math.random(2)    
	fctx = stx[11] * shift_x
	fcty = sty[11] * shift_y
	px[1] = x[6] + fctx
	py[1] = y[4] + fcty
	px[2] = x[2] + fctx
	py[2] = y[4] + fcty
	px[3] = x[6] + fctx
	py[3] = y[8] + fcty
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[11] == 1) then
			lib.add_straight_path(px[1]-w-3, py[1]-8,  {{3,8}, {5, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+5, py[1]+ow+4, {{-6,7}, {8,3}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[2]-px[1],py[2]-py[1]}, {0,-w}, {px[3]-px[2]+w,0}, {0, py[3]-py[1]+w}, {-w,0}, {px[1]-px[3],py[1]-py[3]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[11] == 2) then
			lib.add_straight_path(px[1]-w-3, py[1]+8,  {{3,-8}, {5, 8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-9, py[1]+w+2, {{8,-2}, {-8, -8}}, dif_style,  true, false)		
		end
	end
end
--[[ind = 12]]--
if (stampa[12] == 1) then
	ch = math.random(2)    
	fctx = stx[12] * shift_x
	fcty = sty[12] * shift_y
	px[1] = x[3] + fctx
	py[1] = y[4] + fcty
	px[2] = x[7] + fctx
	py[2] = y[4] + fcty
	px[3] = x[3] + fctx
	py[3] = y[8] + fcty	
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w, dif_style, true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, style,  true, false)
		if (op[12] == 2) then
			lib.add_straight_path(px[1]+w-5, py[1]-ow, {{5,9}, {4, -9}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]-7, py[1]+ow+3,  {{6,8}, {-8, 2}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[1], py[1], {{px[2]-px[1],py[2]-py[1]}, {0,-w}, {px[1]-px[2]-w, 0},  {0,py[3]-py[1]+w}, {w,0}, {px[1]-px[3],py[1]-py[3]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[1]-px[2], py[1]-py[2]}, {px[3]-px[1], py[3]-py[1]}}, dif_style,  true, false)		
		if (op[12] == 1) then
			lib.add_straight_path(px[1]+ow+4, py[1]+7,  {{6,-8}, {2, 8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+ow, py[1]+ow+2, {{-6,8}, {8, 0}}, dif_style,  true, false)		
		end
	end		
end
--[[ind = 13]]--
if (stampa[13] == 1) then
	ch = math.random(2)     
	fctx = stx[13] * shift_x
	fcty = sty[13] * shift_y
	px[1] = x[4] + fctx
	py[1] = y[5] + fcty
	px[2] = x[7] + fctx
	py[2] = y[5] + fcty
	px[3] = x[2] + fctx
	py[3] = y[5] + fcty	
	if (ch == 2) then
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)	
		lib.add_straight_path(px[3], py[3], {{0,-w}, {px[2]-px[3], py[2]-py[3]}, {0, w}, {px[3]-px[2],py[3]-py[2]}}, dark_style,  true, false)				
		lib.add_straight_path(px[2], py[2],  {{px[3]-px[2], py[3]-py[2]}}, style,  true, false)
		if (op[13] == 2) then
			lib.add_straight_path(px[1]-w-4, py[1]+ow, {{2,-9}, {9, 7}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+ow+3, py[1]+ow,  {{6,-8}, {3, 8}}, dif_style,  true, false)		
		end
	else
		lib.add_circle (px[1], py[1], w-1, dif_style, true, false)
		lib.add_straight_path(px[3], py[3], {{0,w}, {px[2]-px[3], py[2]-py[3]}, {0, -w}, {px[3]-px[2],py[3]-py[2]}}, dark_style,  true, false)	
		lib.add_straight_path(px[2], py[2],  {{px[3]-px[2], py[3]-py[2]}}, style,  true, false)		
		if (op[13] == 1) then
			lib.add_straight_path(px[1]-w-4, py[1]-7,  {{5,8}, {4, -8}}, dif_style,  true, false)
		else
			lib.add_straight_path(px[1]+w-5, py[1]-7, {{4,8}, {3,-8,}}, dif_style,  true, false)		
		end
	end
	lib.add_circle (px[1], py[1], 2, dif_style, true, false)	
end

--[[
	for i = 1,gridy+2 do
		lib.add_line(ow, ow+(i-1)*dy, (gridx-1)*dx, 0, grid_style, false, false)
	end
	lib.add_line(ow, ow + (gridy+1)*dy/2, (gridx-1)*dx, 0, line_style, false, false)
	for i = 1,gridx+1 do
		lib.add_line(ow+(i-1)*dx, ow, 0, (gridy+1)*dy, grid_style, false, false)
	end
	lib.add_line(ow+(gridx-1)*dx/2, ow, 0, (gridy+1)*dy, line_style, false, false)

	lib.add_circle (px[1], py[1], 2, dif_style, true, false)	
	lib.add_text(px[1]-ow, py[1], "1", text_style, false, false)	
	lib.add_circle (px[2], py[2], 2, dif_style, true, false)	
	lib.add_text(px[2]-ow, py[2], "2", text_style, false, false)
	lib.add_circle (px[3], py[3], 2, dif_style, true, false)	
	lib.add_text(px[3]-ow, py[3], "3", text_style, false, false)			
]]--	
	
  lib.end_canvas()
  
end      
