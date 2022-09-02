
include("terms")
                                                                                               
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

red_style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "3"};
		
yelow_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "ff0",
        ["off_line_color"] = "ff0",
        ["line_width"] = "3"};		

text_style = {["font_size"] = "16"}

numb = {}
out = {}
index = {}
enum = {}
denom = {}
value = {}
ind = {}
quest = {""}

dim = 3
first = 0
last =  1 
part = dim + 1 + math.random(9-dim)
int = last * part

for i = 1,part-1 do
    index[i] = i
end	
out = lib.math.random_shuffle(index)
for i = 1,dim do
    numb[i] = out[i]
end	

for i = 1,dim do
	q = lib.math.gcd(numb[i], part)
    enum[i] = math.floor(numb[i]/q)
    denom[i] = math.floor(part/q)
	value[i] = enum[i]/denom[i]
end		
ind = lib.math.argsort(value)

ch = math.random(3)
if (ch < 3) then
	right = ind[3]
	if (ch == 1) then
	    left = ind[2]
		quest[1] = op[1]
		quest[2] = op[2]
		quest[3] = op[2]		
	else
	    left = ind[1]	
		quest[1] = op[2]
		quest[2] = op[2]
		quest[3] = op[1]			
	end	
else
	left = ind[1]
	right = ind[2]	
	quest[1] = op[2]
	quest[2] = op[1]
	quest[3] = op[2]		
end	
	

results = ""
  
for i = 1,int do  
    if (i > 1) then
        results = results .. "&& "
    end
    results = results .. "result[" .. tostring(i-1) .. "] == "
    sign = 0
        if (i == numb[ind[ch]]) then
		    sign = 1
		end
	if (sign == 0) then
	    results = results .. "0 "
	else
	    results = results .. "1 "
	end	
end	  

mycanvas = function(no)
  lib.start_canvas(350, 80, "center", results)

  scale1 = math.floor(300/int)
  scale2 = part * scale1
  ow = 40
  w = 15
  
  lib.add_straight_path(w, ow, {{last*scale2, 0}}, style, false, false)  
  
  for i = 2, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, ow, {{0, 5}, {0, -10}}, red_style, false, true)
  end 
  xl = w+(numb[left])*scale1
  lib.add_straight_path(xl, ow, {{0, 5}, {0, -10}}, yelow_style, true, false)  
  xr = w+(numb[right])*scale1 
  lib.add_straight_path(xr, ow, {{0, 5}, {0, -10}}, yelow_style, true, false)  
  
  for i = 1, last + 1 do 
      lib.add_straight_path(w+(i-1)*scale2, ow, {{0, 10}, {0, -20}}, style, false, false)
      lib.add_text(w+(i-1)*scale2, w, i-1, text_style)	  
  end

  lib.end_canvas()
end   
        