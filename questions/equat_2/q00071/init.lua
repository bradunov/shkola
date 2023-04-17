
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
	{["off_line_color"] = "000",
        ["line_color"] = "f30",
        ["line_width"] = "2"};	

text_style = {["font_size"] = "14"}


numb = 1

fun = {""}
enum = {}
denom = {}
ch = {}

imp = {""}
coef ={}

max_range = 5 
 
for i = 1,numb do
	enum[i] = {}
	denom[i] = {}
	ch[i] = {}
	for j = 1,2 do	   
		ch[i][j] = math.random(2) - 1
		enum[i][j] = max_range - math.random(2*max_range)
		if (j == 1 and enum[i][j] == 0) then
			enum[i][j] = math.random(max_range)
		end		
		if (ch[i][j] == 0) then
			denom[i][j] = 1 
		else
			denom[i][j] = 1 + math.random(max_range)
			qq = lib.math.gcd(enum[i][j], denom[i][j])
			enum[i][j] = math.floor(enum[i][j]/qq)
			denom[i][j] = math.floor(denom[i][j]/qq)
			if (denom[i][j] == 1) then
			    ch[i][j] = 0
			else
				tmp = enum[i][j]/denom[i][j]
				rest = 10*tmp - math.floor(10*tmp)				
				if (rest == 0) then
					enum[i][j] = 10 * tmp
					denom[i][j] = 10
					ch[i][j] = 1
				else
					ch[i][j] = 2			
				end	
            end				
		end
	end
 end
  
for i = 1,numb do	
	fun[i] = ""
	if (math.abs(enum[i][1]/denom[i][1]) ~= 1) then	
		if (ch[i][1] < 2) then
			fun[i] = fun[i] .. lib.check_number(lib.math.round_dec(enum[i][1]/denom[i][1],1))   
		else	
			fun[i] = fun[i] .. lib.check_fraction_simple(enum[i][1],denom[i][1]) 		
		end 
	else
		if (enum[i][1] < 0) then
			fun[i] = lib.check_string("-", 10) .. fun[i]	
        end			
	end
	fun[i] = fun[i] .. lib.check_string("x", 15)
    if (enum[i][2] ~= 0) then	
		if (enum[i][2] < 0) then
			fun[i] = fun[i] .. lib.check_string("-", 10)	
        else
			fun[i] = fun[i] .. lib.check_string("+", 10)	
		end			
		if (ch[i][2] < 2) then
			fun[i] = fun[i] .. lib.dec_to_str(lib.math.round_dec(math.abs(enum[i][2])/denom[i][2],1)) 
		else
			fun[i] = fun[i] .. "\(\frac{" .. tostring(math.abs(enum[i][2])) .. "}{" .. tostring(denom[i][2]) .. "}\)" 					
		end
	end		
end
	
for i = 1,numb do	
  	imp[i] = ""
	coef[i] = {}
    coef[i][1] = enum[i][1] * denom[i][2]
    coef[i][2] = -denom[i][1] * denom[i][2]	
    coef[i][3] = enum[i][2] * denom[i][1]	
	if (coef[i][1] < 0) then
	    for j = 1,3 do
			coef[i][j] = -coef[i][j]
		end	
	end	
	q1 = lib.math.gcd(coef[i][1], coef[i][2])
	q2 = lib.math.gcd(coef[i][2], coef[i][3])
	qq = lib.math.gcd(q1, q2)
	for j = 1,3 do
		coef[i][j] = math.floor(coef[i][j]/qq)
	end	
	if (coef[i][1] ~= 1) then
	    imp[i] = imp[i] .. lib.check_number(coef[i][1],20) 
    end		
	imp[i] = imp[i] .. lib.check_string("x",15)	
	if (coef[i][2] < 0) then
	    imp[i] = imp[i] .. lib.check_string("-",10)
    else	
	    imp[i] = imp[i] .. lib.check_string("+",10)	
	end
	if (math.abs(coef[i][2]) ~= 1) then
	    imp[i] = imp[i] .. lib.check_number(math.abs(coef[i][2]),20) 
    end		
	imp[i] = imp[i] .. lib.check_string("y",15)	
    if (coef[i][3] ~= 0) then	
		if (coef[i][3] < 0) then
			imp[i] = imp[i] .. lib.check_string("-",10)
		else
			imp[i] = imp[i] .. lib.check_string("+",10)			
		end
		imp[i] = imp[i] .. lib.check_number(math.abs(coef[i][3]),20)
	end
end	  
            

--[[ nula i tacka preseka sa y-osom]]--
if (enum[1][2] == 0) then
	x0 = 0
	y0 = 0
	x1 = 0
	y1 = 0
else
	x1 = 0
	y1 = enum[1][2]/denom[1][2]
	x0 = - y1 * denom[1][1] 
	x0 = x0/enum[1][1]
	y0 = 0	
end	

point0 = ""	
point1 = ""
broj = 	-enum[1][2]*denom[1][1] 
imen = enum[1][1]*denom[1][2]
qq = lib.math.gcd(broj, imen)
broj = math.floor(broj/qq)
imen = math.floor(imen/qq)
if (imen < 0) then
	broj = - broj
	imen = - imen
end
if (imen == 1) then
	check = 0
else
	tmp = broj/imen
	rest = 10*tmp - math.floor(10*tmp)				
	if (rest == 0) then
		broj = 10 * tmp
		imen = 10
		check = 1
	else
		check = 2			
	end	
end	
if (check < 2) then
	point0 = lib.check_number(lib.math.round_dec(broj/imen,1))  
else
	point0 = lib.check_fraction_simple(broj, imen) 	
end	
if (ch[1][2] < 2) then
	point1 = lib.check_number(lib.math.round_dec(enum[1][2]/denom[1][2],1))  
else
	point1 = lib.check_fraction_simple(enum[1][2], denom[1][2]) 					
end



px = {}
py = {}

mycanvas = function()

  dimx = 16
  dimx2 = 8
  dimy = 10
  dimy2 = 5

  lib.start_canvas(280, 160,  "center")
  
  wx = math.floor(260/dimx)
  wy = math.floor(140/dimy) 
  ow = 10
 
--[[linija ]]--
	c1 = enum[1][1]/denom[1][1]
	c2 = enum[1][2]/denom[1][2]
	px[1] = 1
	px[2] = dimx - 1
	for j = 1,2 do
		py[j] = dimy2 - c1*(px[j] - dimx2) - c2	
	end			
    difx = px[2] - px[1]
    dify = py[2] - py[1]
    lib.add_line(ow+px[1]*wx, ow+py[1]*wy, difx*wx, dify*wy, line_style, false, true)
  
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
     