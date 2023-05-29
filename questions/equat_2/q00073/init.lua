
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
        ["line_width"] = "2"};	

text_style = {["font_size"] = "14"}

numb = {}
term = {""}

xbroj = {}
ximen = {}
ybroj = {}
yimen = {}
fbroj = {}
fimen = {}
coef = {}

px = {}
py = {}
par = {}

max_range = 5

for j = 1,2 do
	numb[j] = {}
	for i = 1,11 do	
		if (i >= 8) then
			min_range = 1	
		else
			min_range = 0		
		end	
		numb[j][i] = min_range + math.random(max_range) 
        if (i < 8) then		
			sg = math.random(2)	
			if (sg == 2) then
				numb[j][i] = - numb[j][i]			
			end
		end
	end	
end	

for j = 1,2 do
	term[j] = ""
    for k = 1,3 do
		part = ""	
		if (math.abs(numb[j][2*k-1]) ~= 1) then
			part = part .. tostring(numb[j][2*k-1])
		else
			if (numb[j][2*k-1] == -1) then	
				part = part .. "-"
			end
		end
		if (k == 1 or k == 3) then	
			part = part .. " x "	
		else	
			part = part .. " y "
		end		
		if (numb[j][2*k] ~= 0) then
			if (numb[j][2*k] < 0) then
				op = " - "
			else
				op = " + "
			end	
			part = part .. op
			if (k < 3) then			
				part = part .. tostring(math.abs(numb[j][2*k]))
			else
				if (math.abs(numb[j][2*k]) ~= 1) then			
					part = part .. tostring(math.abs(numb[j][2*k]))
				end
				part = part .. " y "				
			end			
		end 	
		term[j] = 	term[j] .. lib.frac_start() .. part .. lib.frac_mid() .. tostring(math.abs(numb[j][k+7])) .. lib.frac_end() 
		if (k < 3) then
			term[j] = 	term[j] .. " + "
		end
	end
	if (numb[j][7] ~= 0) then
		if (numb[j][7] < 0) then
			op = " - "
		else
			op = " + "
		end
		tmp = math.abs(numb[j][7]/numb[j][11])
		if (tmp == math.floor(tmp)) then
			term[j] = 	term[j] .. op .. tostring(math.floor(tmp)) 
		else
			qq = lib.math.gcd(numb[j][7],numb[j][11])
			numb[j][7] = numb[j][7]/qq
			numb[j][11] = numb[j][11]/qq
			term[j] = 	term[j] ..op .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_mid() .. tostring(math.floor(math.abs(numb[j][11]))) .. lib.frac_end() 
		end
	end
end

for j = 1,2 do
	xbroj[j] = numb[j][1] * numb[j][10] + numb[j][5] * numb[j][8]
	ximen[j] = numb[j][8] * numb[j][10]
end
brojx = xbroj[1] * ximen[2] - xbroj[2] * ximen[1]
imenx = ximen[1] * ximen[2]	
for j = 1,2 do
	ybroj[j] = numb[j][3] * numb[j][10] + numb[j][6] * numb[j][9]
	yimen[j] = numb[j][9] * numb[j][10]
end
brojy = ybroj[1] * yimen[2] - ybroj[2] * yimen[1]
imeny = yimen[1] * yimen[2]	
for j = 1,2 do
	fbroj[j] = numb[j][2] * numb[j][9] * numb[j][11] + numb[j][4] * numb[j][8] * numb[j][11] + numb[j][7] * numb[j][8] * numb[j][9]
	fimen[j] = numb[j][8] * numb[j][9] * numb[j][11]
end
brojf = fbroj[2] * fimen[1] - fbroj[1] * fimen[2]
imenf = fimen[1] * fimen[2]	

coef[1] = brojx * imeny * imenf
coef[2] = brojy * imenx * imenf
coef[3] = brojf * imenx * imeny
if (coef[1] < 0) then
	for j = 1,3 do
		coef[j] = - coef[j]
	end
end	
q1 = lib.math.gcd(coef[1], coef[2])
q2 = lib.math.gcd(coef[2], coef[3])
qq = lib.math.gcd(q1, q2)
for j = 1,3 do
	coef[j] = math.floor(coef[j]/qq)
end			
if (coef[2] < 0) then	
    sign = "-"
else
    sign = "+"	
end
equ = lib.check_number(coef[1],30) .. "x " .. lib.check_string(sign,10) .. lib.check_number(math.abs(coef[2]),30) .. "y = " .. lib.check_number(coef[3],30)     

note = ""
ind = 1
if (coef[1] == 0 and coef[2] == 0) then
    ind = 2
    if (coef[3] == 0) then
	    note = msg[2]
    else
	    note = msg[1]
    end
end	
	    

stampa = 4
 
mycanvas = function()

  dimx = 16
  dimx2 = 8
  dimy = 10
  dimy2 = 5
  
  if (ind == 1) then  
	results = "result[0] == 1"
  else
	results = "result[0] == 0"
  end	
  for i = 1, stampa-1 do
      results = results .. "  && result[" .. tostring(i) .. "] == 0"
  end

  lib.start_canvas(320, 180,  "center", results)
  
  wx = math.floor(300/dimx)
  wy = math.floor(170/dimy) 
  ow = 10

--[[linija ]]--
  for i = 1,stampa do
    for j = 1,3 do
	    if (j == i-1) then
			par[j] = -coef[j]
		else
			par[j] = coef[j]	
        end			
    end	
	if (i > 1) then	
		if (par[2] ~= 0) then
			tmp = par[3]/par[2]
			if (math.abs(tmp) < 0.5) then			    
			    if (tmp >= 0) then
					par[3] = par[3] + 2*par[2]
				else
					par[3] = par[3] - 2*par[2]				
				end 
			end
		else	
			tmp = par[3]/par[1]
			if (math.abs(tmp) < 0.5) then			    
			    if (tmp >= 0) then
					par[3] = par[3] + 2*par[1]
				else
					par[3] = par[3] - 2*par[1]				
				end 
			end					
		end
	end	
	if (par[1] * par[2] ~= 0) then
		px[1] = 1
		px[2] = dimx - 1
		for j = 1,2 do
			py[j] = dimy2 + (px[j] - dimx2)*par[1]/par[2] - par[3]/par[2]	
		end			
	else
		if (par[2] == 0) then   
			if (i <= 2) then		
				px[1] = dimx2 + par[3]/par[1]
				px[2] = px[1]
				py[1] = 1
				py[2] = dimy - 1
			else
				px[1] = 1
				px[2] = dimx - 1
				py[1] = dimy2 + par[3]/par[1]
				py[2] = py[1]
			end			
		else
		    if (i == 2 or i == 4) then
			    par[3] = -par[3]
			end
			if (i <= 2) then
				px[1] = 1
				px[2] = dimx - 1
				py[1] = dimy2 - par[3]/par[2]
				py[2] = py[1]			
			else
				px[1] = dimx2 - par[3]/par[2]
				px[2] = px[1]
				py[1] = 1
				py[2] = dimy - 1
			end		
        end			
    end				
    difx = px[2] - px[1]
    dify = py[2] - py[1]
    lib.add_line(ow+px[1]*wx, ow+py[1]*wy, difx*wx, dify*wy, line_style, false, true)
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
      