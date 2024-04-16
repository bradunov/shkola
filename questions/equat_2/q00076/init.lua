
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};

diff_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

line_style = 
	{["off_line_color"] = "0cf",
        ["line_color"] = "f30",
        ["line_width"] = "2.5"};			

text_style = {["font_size"] = "14"}


coef = {}
imp = {""}

index = {}
perm = {}
out = {}

px = {}
py = {}
par = {}

numb = 6

dimx = 16
dimx2 = 8
dimy = 10
dimy2 = 5 
xpoint = dimx2 -1 - math.random(dimx-3)
ypoint = dimy2 - math.random(dimy-1)

sing = math.random(6)

max_range = 5
nr = 0
check = 0
for i = 1,numb do
	coef[i] = {}
    if (check == 0) then		
		nr = nr + 1
	end	
	for j = 1,2 do	
		coef[nr][j] = max_range - math.random(2*max_range) 
	end
    if (coef[nr][1] == 0 and coef[nr][2] == 0) then
	    sg = math.random(2)
		coef[nr][sg] = math.random(max_range)	
    end	
	coef[nr][3] = coef[nr][1] * xpoint + coef[nr][2] * ypoint	
	if (i == 2) then
		if ((coef[1][1] == 0 and coef[2][1] == 0) or (coef[1][2] == 0 and coef[2][2] == 0)) then
			coef[2][3] = coef[2][3] + math.random(3)
			sing = 5
		end
	end
	if (coef[nr][1] < 0) then
		for j = 1,3 do
			coef[nr][j] = -coef[nr][j]
		end
	end
	if (coef[nr][1] == 0 and coef[nr][2] < 0) then
		for j = 2,3 do
			coef[nr][j] = -coef[nr][j]
		end
	end
    if (i > 1) then
	    check = 0
		for j = 1,nr-1 do
			if ((coef[nr][1]*coef[j][2] == coef[nr][2]*coef[j][1]) and (coef[nr][1]*coef[j][3] == coef[nr][3]*coef[j][1])) then
			    check = 1
			end
        end	
	end				
end
		
if (nr < numb or sing == 5) then
    numb = nr - 1
end	

fct = 1 + math.random(3)
for i = 1,numb do
	coef[i+numb] = {}
    choice = math.random(2)	
	if (choice == 1) then
		for j = 1,2 do
			coef[i+numb][j] = fct * coef[i][j]	
		end
		if (coef[i][3] ~= 0) then
			coef[i+numb][3] = -coef[i][3]
		else
			coef[i+numb][3] = math.random(3)	
        end			
    else
		if (coef[i][1] ~= 0) then
			coef[i+numb][1] = coef[i][1]	
			coef[i+numb][2] = -coef[i][2]
			coef[i+numb][3] = -coef[i][3]			
        else
			coef[i+numb][1] = coef[i][1]		
			coef[i+numb][2] = coef[i][2]	
			coef[i+numb][3] = -coef[i][3]			
		end

	end
end	


if (sing > 4) then
	for j = 1,2 do
		coef[2][j] = fct * coef[1][j]	
	end
	if (sing == 6) then
		coef[2][3] = fct * coef[1][3]
    else
		coef[2][3] = coef[1][3]	
	end
end	

for i = 1,2*numb do	
  	imp[i] = ""
	if (coef[i][1] ~= 0) then	
		if (coef[i][1] ~= 1) then
			imp[i] = imp[i] .. tostring(coef[i][1]) 
		end		
		imp[i] = imp[i] .. "x"	
	end
	if (coef[i][2] ~= 0) then	
		if (coef[i][1] ~= 0) then	
			if (coef[i][2] < 0) then
				imp[i] = imp[i] .. " - "
			else	
				imp[i] = imp[i] .. " + "	
			end
		end
		if (math.abs(coef[i][2]) ~= 1) then
			imp[i] = imp[i] .. tostring(math.abs(coef[i][2])) 
		end		
		imp[i] = imp[i] .. "y"	
	end
	imp[i] = imp[i] .. " = " .. tostring(coef[i][3])		
end	          

for i = 1, 2*numb - 2 do 
	index[i] = i + 2
end	
perm = lib.math.random_shuffle(index)
for j = 1,4 do
	if (j < 3) then
		out[j] = j
	else
		out[j] = perm[j-2]
	end			
end

sol = ""
text = "" 
ans = ""

if ((coef[out[1]][1] == 0 and coef[out[2]][1] == 0) or (coef[out[1]][2] == 0 and coef[out[2]][2] == 0))	then
	if ((coef[out[1]][1] == 0 and coef[out[2]][1] == 0) and  (coef[out[1]][3]/coef[out[1]][2] == coef[out[2]][3]/coef[out[2]][2])) then
		sing = 6 
		text = lib.check_string("y",15) .. " = "
		ans = lib.check_number(ypoint,20)
	else	
		sing = 5
	end	
	if ((coef[out[1]][2] == 0 and coef[out[2]][2] == 0) and  (coef[out[1]][3]/coef[out[1]][1] == coef[out[2]][3]/coef[out[2]][1])) then
		sing = 6 
		text = lib.check_string("x",15) .. " = "
		ans = lib.check_number(xpoint,20)	
	else	
		sing = 5
	end			
else
	if (coef[out[1]][1]*coef[out[2]][2] == coef[out[1]][2]*coef[out[2]][1]) then 
		if (coef[out[1]][1]*coef[out[2]][3] == coef[out[1]][3]*coef[out[2]][1]) then
			sing = 6
           reply1 = "answer == '" .. imp[1] .. "' "  ..
					"|| answer == '" .. imp[2] .. "'" ;
			ans1 = "answer = '" .. imp[1] .. "' ";			
			text = lib.check_string_case(reply1, 80, ans1)
		else
			sing = 5		
		end
	end	
end

if (sing > 4) then
	if (sing == 6) then
		sol = text .. " " .. ans
		ind = 3
	else
		sol = ""	
		ind = 2
	end
else	
	sol = "(" .. lib.check_number(xpoint,20) .. ", " .. lib.check_number(ypoint,20) .. ")"	
    ind = 1
end
	
stampa = 4 
        
mycanvas = function()

  results = "result[0] == 1"
  if (sing == 6) then
	  results = results .. " && result[1] == 0 && result[2] == 0"
  else
	  results = results .. " && result[1] == 1 && result[2] == 0 && result[3] == 0"
  end	  
  
	  
  lib.start_canvas(320, 180, "center", results)

  
  wx = math.floor(300/dimx)
  wy = math.floor(170/dimy) 
  ow = 10

--[[linija ]]--
  for i = 1,stampa do
    if (i ~= 2 or (i == 2 and sing ~= 6 )) then  
		for j = 1,3 do
			par[j] = coef[out[i]][j]				
		end	
		if (par[1] * par[2] ~= 0) then
			px[1] = 1
			px[2] = dimx - 1
			for j = 1,2 do
				py[j] = dimy2 + (px[j] - dimx2)*par[1]/par[2] - par[3]/par[2]	
			end			
		else
			if (par[2] == 0) then   		
				px[1] = dimx2 + par[3]/par[1]
				px[2] = px[1]
				py[1] = 1
				py[2] = dimy - 1		
			else
				px[1] = 1
				px[2] = dimx - 1
				py[1] = dimy2 - par[3]/par[2]
				py[2] = py[1]			
			end			
		end				
		difx = px[2] - px[1]
		dify = py[2] - py[1]
		lib.add_line(ow+px[1]*wx, ow+py[1]*wy, difx*wx, dify*wy, line_style, false, true)
    end		
  end
  
--[[mreza ]]--  
  for i = 2,dimx do
     lib.add_line(ow+(i-1)*wx, ow, 0, dimy*wy, style, false, false)
  end
  for i = 2,dimy do
    lib.add_line(ow, ow+(i-1)*wy, dimx*wx, 0, style, false, false)
  end 

--[[x osa ]]--
  lib.add_line(ow, ow+dimy2*wy, dimx*wx, 0, diff_style, false, false)
  lib.add_straight_path(ow+dimx*wx, ow+dimy2*wy-3, {{ow, ow/4}, {-ow, ow/4}}, diff_style, false, false)
  lib.add_text(ow+dimx*wx+5, ow+(dimy2+1)*wy-3, "x", text_style)   

--[[y osa ]]--  
  lib.add_line(ow+dimx2*wx, ow, 0, dimy*wy, diff_style, false, false)
  lib.add_straight_path(ow+dimx2*wx-3, 2*ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(dimx2+1)*wx, ow, "y", text_style)  

  lib.end_canvas()
end          