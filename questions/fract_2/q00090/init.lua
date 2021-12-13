
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

bar_style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"};

red_style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "3"};

text_style = {["font_size"] = "16"}


first = math.random(5)
last =  first +  2 + math.random(3) 
part = 3 + math.random(4)
int = (last - first) * part

numb2 = (first + 1)^2 + math.random(last - first)
numb = math.sqrt (numb2)
if (numb == math.floor(numb)) then
    numb2 = numb2 + 1
    numb = math.sqrt (numb2)	
end	


for i = 1,int do
    left = first + (i-1)/ part
	right = first + i / part
    if (numb >= left and numb <= right ) then
		 sign = i
	end
end
broj = first * part + sign 
whole_l = math.floor((broj-1)/part)
whole_r = math.floor(broj/part)
enum_l = broj - 1 - part * whole_l
enum_r = broj - part * whole_r

answ = " ∈ [ "    
if (whole_l ~= 0) then
    answ = answ .. lib.check_number(whole_l,15)
end  
if (enum_l ~= 0) then 
    answ = answ .. lib.check_fraction_simple(enum_l, part)			
end		
if (whole_l == 0 and enum_l == 0) then
    answ = answ .. lib.check_number(0, 20) 		
end	
answ = answ .. " , "
if (whole_r ~= 0) then
    answ = answ .. lib.check_number(whole_r,15)
end  
if (enum_r ~= 0) then 
    answ = answ .. lib.check_fraction_simple(enum_r, part)			
end		
if (whole_r == 0 and enum_r == 0) then
    answ = answ .. lib.check_number(0, 20) 		
end	
answ = answ .. " ]"	
	
results = "" 
for i = 1,int do  
    if (i > 1) then
        results = results .. "&& "
    end
    results = results .. "result[" .. tostring(i-1) .. "] == "
    if (i == sign or i+1 == sign ) then
	    results = results .. "1 "
	else
	    results = results .. "0 "
	end	
end	  

mycanvas = function(no)
  lib.start_canvas(350, 80, "center", results)

  scale1 = math.floor(320/int)
  scale2 = part * scale1
  ow = 50
  w = 15
  
  lib.add_straight_path(w, ow, {{last*scale2, 0}}, style, false, false)  
  
  for i = 2, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, ow, {{0, 5}, {0, -10}}, red_style, false, true)
  end 

  for i = 1, last-first + 1 do 
      lib.add_straight_path(w+(i-1)*scale2, ow, {{0, 10}, {0, -20}}, bar_style, false, false)
      lib.add_text(w+(i-1)*scale2, ow-w-5, first+i-1, text_style)	  
  end

  lib.end_canvas()
end   
   
