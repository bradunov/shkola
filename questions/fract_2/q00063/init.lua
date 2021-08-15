
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
quest = {""}
ind = {}

first = -2 - math.random(3)
last =  2 +  math.random(3) 
part = 2 + math.random(4)
int = (last - first) * part

mid = math.floor(int/3)
numb[1] = first*part + math.random(part - 1) 
numb[2] = numb[1] + 1 + math.random(mid - numb[1]+first*part)
numb[3] = numb[2] + 1 + math.random(2*mid-numb[2]+first*part)
numb[4] = numb[3] + 1 + math.random(int-numb[3]+first*part-2)


for i = 1,4 do
    if (numb[i] == 0) then   
	    numb[i] = 1
	end		
end		

out = lib.math.random_shuffle(numb)

for i = 1,4 do 
    ind[i] = math.random(2)	
	dec = math.floor(out[i]/part)
    rest = out[i] - dec*part
	if (rest == 0) then
		quest[i] = tostring(math.floor(dec))
		ind[i] = 1
	else
	    tmp = math.floor(math.abs(out[i]))	
	    if (out[i] < 0) then       
	        quest[i] = "- " .. "\(\frac{" .. tmp .. "}{" .. part .. "}\)"	      		   
        else	
            quest[i] = "\(\frac{" .. tmp .. "}{" .. part .. "}\)"	
        end
    end	
    if (ind[i] == 2) then
	    dec = math.floor(out[i]*10/part)
		rest = out[i]*10 - dec*part
		if (rest == 0) then
		    quest[i] = lib.dec_to_str(lib.math.round_dec(out[i]/part, 1))
	    end
	end	
	
end	
	

results = ""
  
for i = 1,int do  
    if (i > 1) then
        results = results .. "&& "
    end
    results = results .. "result[" .. tostring(i-1) .. "] == "
    sign = 0
    for j = 1,4 do
        if (i == numb[j]-first*part) then
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
  lib.start_canvas(370, 70, "center", results)

  scale1 = math.floor(330/int)
  scale2 = part * scale1
  ow = 40
  w = 15
  
  lib.add_straight_path(w, ow, {{(last-first)*scale2, 0}}, style, false, false)  
  
  for i = 2, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, ow, {{0, 5}, {0, -10}}, red_style, false, true)
  end 

  for i = 1, last - first + 1 do 
      if (i == 1) then
          lib.add_straight_path(w+(i-1)*scale2, ow, {{0, -10}, {0, 15}}, style, false, false)
      else
          lib.add_straight_path(w+(i-1)*scale2, ow-5, {{0, -5}}, style, false, false)
      end
      lib.add_text(w+(i-1)*scale2, w, first + i-1, text_style)	  
  end

  lib.end_canvas()
end  

     







 
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            