
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};		

text_style = {["font_size"] = "16"}

set = {2, 3, 4, 5, 6, 7, 8, 9, 10}

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}

sign = { "≤", "<", "≥", ">"} 

index = math.random(4) 

max = 20
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
	denom[i] = qq[1]
    enum[i] = 2 + math.random(max);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]
	end	
end	

for i = 1,2 do
    q = lib.math.gcd(enum[i], denom[i])
    enum[i] = enum[i] / q
    denom[i] = denom[i] / q
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
end	 

term1 = ""    
if (whl[1] ~= 0) then
    term1 = whl[1]
end
term1 = term1 .. "\(\frac{" .. math.floor(enum_p[1]) .. "}{" .. math.floor(denom[1]).. "}\)" 	
	
term2 = ""
if (whl[2] ~= 0) then
    term2 = whl[2]
end
term2 = term2 .. "\(\frac{" .. math.floor(enum_p[2]) .. "}{" .. math.floor(denom[2]).. "}\)" 	
	 
result = value[1] * value[2]

imen = denom[1] * denom[2]
broj = enum[1] * enum[2]
q = lib.math.gcd(imen, broj)
broj = broj / q
imen = imen / q
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

term3 = ""
if (ceo ~= 0) then
    term3 = ceo
end
if (broj ~= 0) then
    term3 = term3 .. "\(\frac{" .. math.floor(broj) .. "}{" .. math.floor(imen).. "}\)"
end	

ans = ""
if (index < 3) then
    if (whl[1] ~= 0) then
       ans = ans .. lib.check_number(math.floor(whl[1]),15)
    end
    if (enum_p[1] ~= 0) then
	    temp = value[1] - whl[1]
        condition = "is_ok = math.eq(numerator/denominator, "..tostring(temp)..");"	          
        solution = "numerator="..tostring(enum_p[1])..";denominator="..tostring(denom[1])..";"
        ans = ans .. lib.check_fraction_condition(condition, nil, nil, solution)	
    end	
	p1 = whl[1]
	p2 = enum_p[1]
	part = denom[1]
else
    if (whl[2] ~= 0) then
       ans = ans .. lib.check_number(math.floor(whl[2]),15)
    end
    if (enum_p[2] ~= 0) then
	    temp = value[2] - whl[2]
        condition = "is_ok = math.eq(numerator/denominator, "..tostring(temp)..");"	          
        solution = "numerator="..tostring(enum_p[2])..";denominator="..tostring(denom[2])..";"
        ans = ans .. lib.check_fraction_condition(condition, nil, nil, solution)		
    end	
	p1 = whl[2]
	p2 = enum_p[2]
	part = denom[2]
end	

sg = math.random(2)
neq = ""
if (index == 1) then
    neq = "x * " .. term2 .. " " .. sign[2+sg] .. " " .. term3
	reply = "x " .. lib.check_one_option_dropdown(sign, sign[2+sg]) .. " " .. ans
    cent = math.floor(value[1])
	if (sg == 1) then
	    point = 1
	else
        point = 0 	
    end	
end
if (index == 2) then
    neq = "x * " .. term2 .. " " .. sign[sg] .. " " .. term3
	reply = lib.check_number(0,15) .. " " .. lib.check_one_option_dropdown(sign, sign[1]) .. " x " .. lib.check_one_option_dropdown(sign, sign[sg]) .. " " .. ans
    cent = math.floor(value[1]) 
	if (sg == 1) then
	    point = 1
	else
        point = 0 	
    end	
end
if (index == 3) then
    neq = term1 .. " * x " .. sign[2+sg] .. " " .. term3	
	reply = "x " .. lib.check_one_option_dropdown(sign, sign[2+sg]) .. " " .. ans	
    cent = math.floor(value[2])
	if (sg == 1) then
	    point = 1
	else
        point = 0 	
    end		
end
if (index == 4) then
    neq = term1 .. " * x " .. sign[sg] .. " "  .. term3
	reply = lib.check_number(0,15) .. " " .. lib.check_one_option_dropdown(sign, sign[1]) .. " x " .. lib.check_one_option_dropdown(sign, sign[sg]) .. " " .. ans	
    cent = math.floor(value[2])
	if (sg == 1) then
	    point = 1
	else
        point = 0 	
    end		
end
  	
first = 0
last =  cent + 2
int = last * part

if (index == 1 or index == 3) then
    results = "result[0] == 0 && result[1] == 1 && result[2] == 0 &&" 
else
    results = "result[0] == 1 && result[1] == 0 && result[2] == 1 &&" 	
end
if (point == 1) then
	results = results .. "result[3] == 1"
else
	results = results .. "result[3] == 0"
end	
	

mycanvas = function()
  lib.start_canvas(320, 120, "center", results)

  scale1 = math.floor(300/int)
  scale2 = part * scale1
  ow = 40
  w = 15
  v = 30
  ov = 5

  mark = p1*scale2 + p2*scale1 

  lib.add_straight_path(w, 2*ow, {{mark, 0}, {0, -ow}, {-mark, 0}}, dif_style, false, true)
  lib.add_straight_path(w+8, ow-3, {{-8, 3}, {8, 3}}, style, false, false) 
  lib.add_straight_path(w + last*scale2, 2*ow, {{-last*scale2+mark, 0}, {0, -2*v}, {last*scale2-mark, 0}}, dif_style, false, true)
  lib.add_straight_path(w+last*scale2-8, 2*(ow-v)-3, {{8, 3}, {-8, 3}}, style, false, false) 
   
  lib.add_straight_path(w, 2*ow, {{last*scale2, 0}}, style, false, false)  
  
  for i = 2, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, 2*ow, {{0, 5}, {0, -10}}, style, false, false)
  end 

  for i = 1, last + 1 do 
      number = first + i - 1
      lib.add_straight_path(w+(i-1)*scale2, 2*ow, {{0, 10}, {0, -20}}, style, false, false)
      lib.add_text(w+(i-1)*scale2, ow+2*v, number, text_style, false, false)	  
  end
 
  lib.add_circle (w, 2*ow, 4, dif_style, false, true)  
  lib.add_circle (w+mark, 2*ow, 4, dif_style, false, true)

  lib.end_canvas()
end     


  


  
