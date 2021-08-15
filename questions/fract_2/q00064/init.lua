
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = 
	{["off_color"] = "fff",
        ["on_color"] = "faf",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};


red_style = 
	{["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "f30",
        ["line_width"] = "1"};

text_style = {["font_size"] = "16"}

numb = {}
quest = {}

name = {"A", "B", "C", "D"}

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

for i = 1,4 do 	
	dec = math.floor(numb[i]/part)
    rest = numb[i] - dec*part
	if (rest == 0) then
		quest[i] = lib.check_number(dec, 20)
	else
        ind = math.random(2)		
	    dec1 = math.floor(numb[i]*10/part)
		rest = numb[i]*10 - dec1*part
		if (rest == 0 and ind == 2) then
		    tmp = numb[i]/part
		    quest[i] = lib.check_number(tmp, 30)
	    else
            quest[i] = lib.check_fraction_simple(numb[i], part)
        end	
	end	
end		


mycanvas = function(no)
  lib.start_canvas(370, 90, "center")

  scale1 = math.floor(330/int)
  scale2 = part * scale1
  ow = 40
  w = 15
  
  lib.add_straight_path(w, ow, {{(last-first)*scale2, 0}}, style, false, false)  
  
  for i = 2, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, ow, {{0, 5}, {0, -10}}, different_style, false, true)
  end 

  for i = 1, last - first + 1 do 
      if (i == 1) then
          lib.add_straight_path(w+(i-1)*scale2, ow, {{0, -10}, {0, 15}}, style, false, false)
      else
          lib.add_straight_path(w+(i-1)*scale2, ow-5, {{0, -5}}, style, false, false)
      end
      lib.add_text(w+(i-1)*scale2, w, first + i-1, text_style)	  
  end

  for i = 1,4 do
      lib.add_circle (w+(numb[i]-first*part)*scale1, ow, 3, red_style, true, false)
      lib.add_text(w+(numb[i]-first*part)*scale1, 3*ow/2, name[i], red_style)
  end
  
  lib.end_canvas()
end  
 

   
     







 
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            