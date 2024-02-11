
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"};

red_style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f90",
        ["off_line_color"] = "000",
        ["line_width"] = "3"};

text_style = {["font_size"] = "16"}

--[[
space = "\( \ \ \ \ \) "
answ = {space, space}
]]--
answ = {""}
denom = { 4, 5, 8, 10}
numb = {}
enum = {} 

imen = {}
broj = {}
value = {}

first = 0
last =  2 +  math.random(3) 
part = 2
int = last * part

for i = 1,3 do
	ch = math.random(4)
	imen[i] = denom[ch]
	broj[i] = math.random(last*imen[i] - 3)
	value[i] = lib.math.round_dec(broj[i] / imen[i],2)	
	if (value[i] == math.floor(value[i])) then
	    broj[i] = broj[i] + 1		
	end
	value[i] = broj[i] / imen[i]
end

bound = math.random(last)
if (math.abs(value[1] - bound) == math.abs(value[2] - bound) ) then
    broj[1] = broj[1] + 1
	value[1] = broj[1] / imen[1]	
end		
for i = 1,2 do
    answ[i] = "\(\frac{" .. broj[i] .. "}{" .. imen[i] .. "}\)"
end	
if (math.abs(value[1] - bound) > math.abs(value[2] - bound) ) then
    ind = 1	
else
	ind = 0	
end	

nr = 0
for i = 1,int do
    if (math.abs(value[3] - i/part) < 0.001) then
	    broj[3] = broj[3] + 1
		value[3] = broj[3] / imen[3]		
	end
	if (value[3] > (i-1)/part and value[3] < i/part) then
	    nr = i
	end
end	
		
results = ""
  
for i = 1,int do  
    if (i > 1) then
        results = results .. "&& "
    end
    results = results .. "result[" .. tostring(i-1) .. "] == "
    if (i == nr) then
	    results = results .. "1 "
	else
	    results = results .. "0 "
	end	
end	  

mycanvas = function(no)
  lib.start_canvas(300, 80, "center", results)

  scale1 = math.floor(280/int)
  scale2 = part * scale1
  ow = 40
  w = 15
  
   
  for i = 1, int   do 
      lib.add_line(w+(i-1)*scale1, ow, scale1, 0, red_style, false, true)
  end 
  for i = 2, int + 1  do 
      lib.add_straight_path(w+(i-1)*scale1, ow, {{0, 5}, {0, -10}}, style, false, false)
  end 

  for i = 1, last + 1 do 
      lib.add_straight_path(w+(i-1)*scale2, ow, {{0, 10}, {0, -20}}, style, false, false)
      lib.add_text(w+(i-1)*scale2, w, i-1, text_style)	  
  end

  lib.end_canvas()
end   