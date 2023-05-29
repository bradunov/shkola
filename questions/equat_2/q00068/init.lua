
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

numb = 4
stampa = 4

fun = {""}
enum = {}
denom = {}
ch = {}

index = {}
out = {}
px = {}
py = {}

for i = 1, 2*numb do
    index[i] = i
end	
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
	if (enum[i][1] < 0 and enum[i][2] > 0) then
		op = 2
	else
		op = 1
    end		
	termx = "x"
	sgx = ""				
	if (enum[i][1] < 0) then
		sgx = " - "	
	end
	if (math.abs(enum[i][1]/denom[i][1]) ~= 1) then
		tmp = math.abs(enum[i][1])	
		if (ch[i][1] < 2) then
			termx = lib.dec_to_str(lib.math.round_dec(tmp/denom[i][1],1)) .. termx 
		else
			if (tmp == 1) then
				termx = "\(\frac{" .. termx .. "}{" .. tostring(denom[i][1]) .. "}\)"  		
			else		
				termx = "\(\frac{" .. tostring(tmp) .. "}{" .. tostring(denom[i][1]) .. "}\)" .. termx 	
			end			
		end
	end
	termf = ""
	sgf = ""
    if (enum[i][2] ~= 0) then	
		if (enum[i][2] < 0) then
			sgf = " - "	
		else
			if (op == 1) then
				sgf = " + "
			end
		end
		tmp = math.abs(enum[i][2])	
		if (ch[i][2] < 2) then
			termf = lib.dec_to_str(lib.math.round_dec(tmp/denom[i][2],1)) .. termf 
		else
			termf = "\(\frac{" .. tostring(tmp) .. "}{" .. tostring(denom[i][2]) .. "}\)" .. termf 					
		end
	end	
	if (op == 2) then
		fun[i] = sgf .. termf .. sgx .. termx
	else
		fun[i] = sgx .. termx .. sgf .. termf	
	end	
	
  	fun[i+numb] = ""
	enum[i+numb] = {}	
	denom[i+numb] = {}
    ch[i+numb] = {}	
	for j = 1,2 do
		enum[i+numb][j] = enum[i][j] 
		denom[i+numb][j] = denom[i][j]	
		ch[i+numb][j] = ch[i][j]
	end	
	if (enum[i][2] == 0) then
		enum[i+numb][1] = -enum[i][1] 
		sgx = ""
		sgf = ""
		if (enum[i][1] > 0) then
            sgx = " - "	
        end
    else			
		if (enum[i][1]*enum[i][2] < 0) then	
			enum[i+numb][2] = -enum[i][2] 		
			if (enum[i][1] < 0) then
				sgx = " - "
				sgf = " - "			
			else
				sgx = ""
				sgf = " + "			
			end	
		else	
			enum[i+numb][1] = -enum[i][1] 		
			if (enum[i][2] < 0) then
				sgx = ""
				sgf = " - "
			else			
				sgx = " - "
				sgf = " + "			
			end	
		end
	end	
	fun[i+numb] = sgx .. termx .. sgf .. termf		
end	

out = lib.math.random_shuffle(index)

--[[ nula i tacka preseka sa y-osom]]--
if (enum[out[1]][2] == 0) then
	x0 = 0
	y0 = 0
	x1 = 0
	y1 = 0
else
	x1 = 0
	y1 = (enum[out[1]][2])/(denom[out[1]][2])
	x0 = - y1 * denom[out[1]][1] 
	x0 = x0/(enum[out[1]][1])
	y0 = 0	
end	

point0 = ""	
point1 = ""
broj = 	-enum[out[1]][2]*denom[out[1]][1] 
imen = enum[out[1]][1]*denom[out[1]][2]
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
	sign1 = lib.check_number(lib.math.round_dec(broj/imen,1)) 
	sign2 = lib.check_number(lib.math.round_dec(broj/imen,1)) 	
else
	point0 = lib.check_fraction_simple(broj, imen) 	
	sign1 = lib.check_fraction_simple(broj, imen)	
	sign2 = lib.check_fraction_simple(broj, imen)	
end	
if (ch[out[1]][2] < 2) then
	point1 = lib.check_number(lib.math.round_dec(enum[out[1]][2]/denom[out[1]][2],1))  
else
	point1 = lib.check_fraction_simple(enum[out[1]][2], denom[out[1]][2]) 					
end
if (enum[out[1]][1]/denom[out[1]][1] > 0) then
    sg1 = ">"
    sg2 = "<"
else
    sg1 = "<"
    sg2 = ">"
end	

mycanvas = function()

  dimx = 16
  dimx2 = 8
  dimy = 10
  dimy2 = 5

  results = "result[0] == 1"
  for i = 1, stampa-1 do
      results = results .. "  && result[" .. tostring(i) .. "] == 0"
  end


  lib.start_canvas(320, 200,  "center", results)
  
  wx = math.floor(300/dimx)
  wy = math.floor(180/dimy) 
  ow = 10

--[[linija ]]--
  for i = 1,stampa do
	c1 = enum[out[i]][1]/denom[out[i]][1]
	c2 = enum[out[i]][2]/denom[out[i]][2]
	px[1] = 1
	px[2] = dimx - 1
	for j = 1,2 do
		py[j] = dimy2 - c1*(px[j] - dimx2) - c2	
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
     