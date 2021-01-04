
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


text_style = {["font_size"] = "14"}

numb = {}
condition = {}
solution = {}
value = {}
ceo = {}
numer = {}
answ = {}

name = {"A", "B", "C", "D"}
  
first = 0
last =  2 +  math.random(3) 
part = 3 + math.random(7)
int = last * part

mid = math.floor(int/3)
numb[1] = math.random(part - 1) 
numb[2] = numb[1] + 1 + math.random(mid - numb[1])
numb[3] = numb[2] + 1 + math.random(2*mid-numb[2])
numb[4] = numb[3] + 1 + math.random(int-numb[3]-2)

for i = 1,4 do
    value[i] = numb[i]/part
	ceo[i] = math.floor(value[i]) 
    numer[i] = numb[i] - ceo[i] * part
    if (numer[i] == 0) then   
	    numb[i] = numb[i] + 1
		numer[i] = 1
	end		
	if (ceo[i] == 0) then
	    answ[i] = ""
	else	
        condition[i] = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value[i])..");"
        solution[i] = "numerator="..tostring(numer[i])..";denominator="..tostring(part)..";whole="..tostring(ceo[i])..";"	
	    answ[i] = "= " .. lib.check_fraction_condition(condition[i], true, nil, solution[i])
    end		
end		


mycanvas = function(no)
  lib.start_canvas(350, 90, "center")

  scale1 = math.floor(330/int)
  scale2 = part * scale1
  ow = 40
  w = 15
  
  lib.add_straight_path(w, ow, {{last*scale2, 0}}, style, false, true)
  
  for i = 1, last + 1 do 
      lib.add_straight_path(w+(i-1)*scale2, ow, {{0, 10}, {0, -20}}, style, false, true)
      lib.add_text(w+(i-1)*scale2, w, i-1, text_style)	  
  end
  
  for i = 1, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, ow, {{0, 5}, {0, -10}}, different_style, false, true)
  end

  for i = 1,4 do
      lib.add_circle (w+numb[i]*scale1, ow, 3, red_style, true, false)
      lib.add_text(w+numb[i]*scale1, 3*ow/2, name[i], red_style)
  end
 
  lib.end_canvas()
end   
   
 
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            