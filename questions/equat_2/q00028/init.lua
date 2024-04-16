
style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "none",
        ["off_line_color"] = "none",
        ["line_width"] = "2"};	
		
point_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};				

text_style = {["font_size"] = "16"}

set = {2, 3, 4, 5, 6, 7, 8, 9, 10}
sign = {"<", ">", "≤", "≥"}
space = "\( \ \ \ \ \) "

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}
term = {""}
ch = {}

try = {}
inter = {0, 0, 0}

index = math.random(4)       --[[ izbor relacije]]--
choice = math.random(2)      --[[ 1 x brojilac, 2 x imenilac]]--

max_range = 20
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
	denom[i] = qq[1]
    enum[i] = 2 + math.random(max_range);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
	end	
	if (i == 2 and fact == 2) then
	    fact = 1
    else		
	    fact = math.random(2)
	end	
	if (fact == 1) then
        enum[i] = - enum[i]
	end	
	value[i] = enum[i] / denom[i]	
end	

if (choice == 1) then
    enum[3] = enum[1] * denom[2]
    denom[3] = denom[1] * enum[2] 
else
    enum[3] = enum[2] * denom[1]
    denom[3] = denom[2] * enum[1] 
end	

if (denom[3] < 0) then
    enum[3] = - enum[3]
    denom[3] = - denom[3]
end	

for i = 1,3 do
    term[i] = ""
    q = lib.math.gcd(enum[i], denom[i])
    denom[i] = denom[i] / q
    enum[i] = enum[i] / q
    value[i] = enum[i]/denom[i]
    tmp = math.floor(value[i] * 10)
	rest = value[i] * 10 - tmp		
    if (value[i] > 0) then
        whl[i] = math.floor(value[i])
    else 
        whl[i] = math.ceil(value[i])
    end
    enum_p[i] = enum[i]	- whl[i] * denom[i]
    if (i == 1) then
        sht = enum_p[1]
    end
    if (rest == 0) then	
	    term[i] = lib.dec_to_str(lib.math.round_dec(value[i], 1))
        ch[i] = 1
	else		
        if (whl[i] ~= 0) then
            term[i] = term[i] .. tostring(whl[i])  
			enum_p[i] = math.abs(enum_p[i])
        end
        term[i] = term[i] .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	
        ch[i] = 2
	end
end

neq = ""
answ1 = ""
answ2 = ""

if (ch[1] == 1) then	
    answ1 = lib.check_number(value[1],30)	
else 
    if (whl[1] ~= 0) then
        answ1 = lib.check_number(whl[1],20)  
    end
	tmp = enum_p[1]/denom[1]	
 	condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
    sln2 = "numerator="..tostring(enum_p[1])..";denominator="..tostring(denom[1])..";"
    answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)
end

if (choice == 1) then 
    neq = "x : " .. "(" .. term[2] .. ") " .. sign[index] .. " " .. term[3]	
	if (value[2] < 0) then
		if (index < 3) then
			if (index == 1) then
				ind = 2
			else
				ind = 1
			end	
		else		
			if (index == 3) then
				ind = 4
			else
				ind = 3
			end	
		end		
	else
		ind = index 
	end 
	reply = "x " .. lib.check_one_option_dropdown(sign, sign[ind]) .. " " .. answ1 .. answ2
else
    neq = "( " .. term[2] .. ") : x " .. sign[index] .. " " .. term[3]		
    if (value[1] < 0 ) then
        try[1] =  1.5*value[1]
        try[2] = 0.5*value[1]
        try[3] = 1
	else
        try[1] =  -1
        try[2] = 0.5*value[1]
        try[3] = 1.5*value[1]	
	end
	for i = 1,3 do
		if (value[2]/try[i] < value[3]) then
		    if (index == 1 or index == 3) then
				inter[i] = 1
			else
				inter[i] = 0
            end	
        else
		    if (index == 2 or index == 4) then
				inter[i] = 1
			else
				inter[i] = 0
            end			
		end
	end
	if (index > 2) then
		rel = sign[3]
		ind = 3
	else
		rel = sign[1]
		ind = 1			
	end	
	reply = " "	
	if (inter[1] == 1 ) then
		if (value[1] < 0 ) then						
			reply = "x " .. lib.check_one_option_dropdown(sign, rel) .. " " .. answ1 .. answ2
        else
			reply = "x " .. lib.check_one_option_dropdown(sign, sign[1]) .. " " .. lib.check_number(0,20)		
        end
    end		
	if (inter[2] == 1 ) then
		if (value[1] < 0 ) then	
			reply = reply .. space .. answ1 .. answ2 .. lib.check_one_option_dropdown(sign, rel) .. " x " .. lib.check_one_option_dropdown(sign, sign[1]) .. " " .. lib.check_number(0,20)
        else
			reply = reply .. space .. lib.check_number(0,20) .. lib.check_one_option_dropdown(sign, sign[1]) ..  " x " .. lib.check_one_option_dropdown(sign, rel) .. answ1 .. answ2		
        end
    end	
	if (inter[3] == 1 ) then
		if (value[1] < 0 ) then	
			reply = reply .. space .. " x " .. lib.check_one_option_dropdown(sign, sign[2]) .. " " .. lib.check_number(0,20)
        else
			if (index > 2) then
				rel = sign[4]
				ind = 4
			else
				rel = sign[2]	
				ind = 2			
			end					
			reply = reply .. space .. "x " .. lib.check_one_option_dropdown(sign, rel) .. " " .. answ1 .. answ2
        end
    end		
end	

part = denom[1]
step = 1
if (choice == 1) then
	dist = 2 * step
	leng = 2 * dist	
	first = whl[1] - dist
	last =  whl[1] + dist
else
    if (value[1] < 0) then
		first = whl[1] -1
	    last = 1
	else
		first = -1
	    last = whl[1]+1	
	end
	dist = math.abs(whl[1])
    leng = dist + 2	
end	
int = leng * part
	
results = ""
if (choice == 1) then
	if (ind < 3) then
		if (ind == 2) then
			results = "result[0] == 0 && result[1] == 1 && result[2] == 0" 
		else
			results = "result[0] == 1 && result[1] == 0 && result[2] == 0"	
		end
	else
		if (ind == 4 ) then
			results = "result[0] == 0 && result[1] == 1 && result[2] == 1" 
		else
			results = "result[0] == 1 && result[1] == 0 && result[2] == 1"	
		end	
	end	
else
	for i = 1, 3 do
		if i > 1 then
		 results = results .. " && "
		end
		results = results .. "result[" .. tostring(i-1) .. "] == "
		if (inter[i] == 1 ) then
		    results = results .. "1"
		else
		    results = results .. "0"
		end
	end	
	if (ind > 2) then
		results = results .. "&& result[3] == 1" 
    else	
		results = results .. "&& result[3] == 0" 
    end	
	results = results .. "&& result[4] == 0" 	
end	

mycanvas = function()

  lib.start_canvas(340, 130, "center", results)

  ow = 40
  w = 15
  v = 30
  ov = 5

  scale1 = math.floor(300/int)
  scale2 = part * scale1

  if (choice == 1) then
    mark = dist*scale2 + sht*scale1 
		lib.add_straight_path(w, ow, {{mark, 0}, {0, ow}}, style, false, false)  			  		
		lib.add_straight_path(w, 2*ow, {{0, -ow}, {mark, 0}, {0, ow}, {-mark, 0}}, dif_style, false, true)  
		lib.add_straight_path(w+8, ow-3, {{-8, 3}, {8, 3}}, style, false, false) 
		lib.add_straight_path(w + mark, 2*ow, {{0, -2*v}, {leng*scale2-mark, 0}}, style, false, false)  			  		
		lib.add_straight_path(w + mark, 2*ow, {{0, -2*v}, {leng*scale2-mark, 0}, {0, 2*v}, {mark-leng*scale2, 0}}, dif_style, false, true)  
		lib.add_straight_path(w+leng*scale2-8, 2*ow-2*v-3, {{8, 3}, {-8, 3}}, style, false, false) 			
        point = mark
  else
    mark = dist*scale2 + math.abs(sht)*scale1
    if (value[1] < 0 ) then
 		lib.add_straight_path(w, ow, {{step*scale2+sht*scale1, 0}, {0, ow} }, style, false, false)  
 		lib.add_straight_path(w, ow, {{step*scale2+sht*scale1, 0}, {0, ow}, {-step*scale2-sht*scale1, 0}, {0, -ow} }, dif_style, false, true) 		
		lib.add_straight_path(w+step*scale2+sht*scale1, 2*ow, {{0, -2*v}, {mark, 0}, {0, 2*v} }, style, false, false)  
		lib.add_straight_path(w+step*scale2+sht*scale1, 2*ow, {{0, -2*v}, {mark, 0}, {0, 2*v}, {mark, 0}}, dif_style, false, true) 
		lib.add_straight_path(w+(leng-1)*scale2, 2*ow, {{0, -ow}, {step*scale2, 0} }, style, false, false) 
		lib.add_straight_path(w+(leng-1)*scale2, 2*ow, {{0, -ow}, {step*scale2, 0}, {0, ow}, {-step*scale2, 0} }, dif_style, false, true) 		
	    lib.add_straight_path(w+8, ow-3, {{-8, 3}, {8, 3}}, style, false, false) 
        lib.add_straight_path(w+leng*scale2-8, ow-3, {{8, 3}, {-8, 3}}, style, false, false) 		
        point = step*scale2+sht*scale1 
		pt0 = (leng-1)*scale2
	else
		lib.add_straight_path(w, ow, { {step*scale2, 0}, {0, ow}}, style, false, false)  
		lib.add_straight_path(w, ow, { {step*scale2, 0}, {0, ow}, {-step*scale2, 0}, {0, -ow}}, dif_style, false, true)		
		lib.add_straight_path(w+step*scale2, 2*ow, {{0, -2*v}, {mark, 0}, {0, 2*v} }, style, false, false) 
		lib.add_straight_path(w+step*scale2, 2*ow, {{0, -2*v}, {mark, 0}, {0, 2*v}, {-mark, 0}}, dif_style, false, true) 		
		lib.add_straight_path(w+(leng-1)*scale2+sht*scale1, 2*ow, {{0, -ow}, {step*scale2-sht*scale1, 0} }, style, false, false) 
		lib.add_straight_path(w+(leng-1)*scale2+sht*scale1, 2*ow, {{0, -ow}, {step*scale2-sht*scale1, 0}, {0, ow}, {-step*scale2+sht*scale1, 0} }, dif_style, false, true) 		
	    lib.add_straight_path(w+8, ow-3, {{-8, 3}, {8, 3}}, style, false, false) 
        lib.add_straight_path(w+leng*scale2-8, ow-3, {{8, 3}, {-8, 3}}, style, false, false) 		
        point = step*scale2+mark 
		pt0 = step*scale2	
	end
  end

  lib.add_straight_path(w, 2*ow, {{leng*scale2, 0}}, style, false, false)     
  
  for i = 2, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, 2*ow, {{0, 5}, {0, -10}}, style, false, false)
  end 

  for i = 1, leng + 1 do 
      number = first + i - 1
      lib.add_straight_path(w+(i-1)*scale2, 2*ow, {{0, 10}, {0, -20}}, style, false, false)
      lib.add_input(2+(i-1)*scale2, 2*(ow+w)-ov, 40, 30, lib.check_number(number, 25))	  
  end
   
  lib.add_circle (w+point, 2*ow, 4, point_style, false, true)
  if (choice == 2) then
	  lib.add_circle (w+pt0, 2*ow, 4, point_style, false, true)
  end
  
  lib.end_canvas()
end     