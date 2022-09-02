
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

text_style = {["font_size"] = "16"}

numb = {}
out = {}
index = {}
enum = {}
denom = {}

dim = 1 + math.random(4)
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

quest = ""
for i = 1,dim do
	q = lib.math.gcd(numb[i], part)
    enum[i] = math.floor(numb[i]/q)
    denom[i] = math.floor(part/q)
	quest = quest .. "\(\frac{" .. enum[i] .. "}{" .. denom[i] .. "}\)"	
	if (i < dim) then
		quest = quest .. ", \( \ \ \ \) "
	else
		quest = quest .. ". "	
	end	
end		

results = ""
  
for i = 1,int do  
    if (i > 1) then
        results = results .. "&& "
    end
    results = results .. "result[" .. tostring(i-1) .. "] == "
    sign = 0
    for j = 1,dim do
        if (i == numb[j]) then
		    sign = 1
		end
    end
	if (sign == 0) then
	    results = results .. "0 "
	else
	    results = results .. "1 "
	end	
end	  

mycanvas = function(no)
  lib.start_canvas(350, 90, "center", results)

  scale1 = math.floor(300/int)
  scale2 = part * scale1
  ow = 40
  w = 15
  
  lib.add_straight_path(w, ow, {{last*scale2, 0}}, style, false, false)  
  
  for i = 2, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, ow, {{0, 5}, {0, -10}}, red_style, false, true)
  end 

  for i = 1, last + 1 do 
      lib.add_straight_path(w+(i-1)*scale2, ow, {{0, 10}, {0, -20}}, style, false, false)
      lib.add_text(w+(i-1)*scale2, w, i-1, text_style)	  
  end

  lib.end_canvas()
end   
   