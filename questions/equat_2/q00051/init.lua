
style = 
       {["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};	

area_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "none",
        ["off_line_color"] = "none",
        ["line_width"] = "2"};		

text_style = {["font_size"] = "14"}

elem = " ∈ "   
infty = {" ( -∞ , ", " , ∞ )"}
rel = {" < ", " > ", " ≤ ", " ≥ ", " ∪ "}
brac = {"(", ")", "[", "]"}
space = ", \(  \ \ \ \ \ \)"

ineq = ""
set = ""

dim = 8
ind = math.random(dim)

dif = 3
ptfirst = 0
ptlast = 0
ptfirst2 = 0
ptlast2 = 0

numbl = 0
numbd = 0

if (ind == 1) then
	ineq = "x " .. lib.check_one_option_dropdown(rel,rel[1]) .. lib.check_number(numbd,20)
	set = "x " .. elem .. lib.check_one_option_dropdown(infty,infty[1]) .. lib.check_number(numbd,20) .. lib.check_string(brac[2],10)
 	numbd = numbl	
    index = 1
end                
if (ind == 2) then
	ineq = "x " .. lib.check_one_option_dropdown(rel,rel[2]) .. lib.check_number(numbl,20)
	set = "x " .. elem .. lib.check_string(brac[1],10) .. lib.check_number(numbl,20) .. lib.check_one_option_dropdown(infty,infty[2])
 	numbd = numbl	
    index = 3	
end                  
if (ind == 3) then
	ineq = "x " .. lib.check_one_option_dropdown(rel,rel[4]) .. lib.check_number(numbl,20)
	set = "x " .. elem .. lib.check_string(brac[3],10) .. lib.check_number(numbl,20) .. lib.check_one_option_dropdown(infty,infty[2])
 	numbd = numbl	
    index = 3
	ptfirst = 0
	ptlast = 1
end              
if (ind == 4) then
	numbl = - math.random(10)
	ineq = lib.check_number(numbl,20) .. lib.check_one_option_dropdown(rel,rel[1]) .. "x " .. lib.check_one_option_dropdown(rel,rel[1]) .. lib.check_number(numbd,20)
	set = "x " .. elem .. lib.check_string(brac[1],10) .. lib.check_number(numbl,20) .. " , " .. lib.check_number(numbd,20) .. lib.check_string(brac[2],10)
    index = 4
end   
if (ind == 5) then
	numbl = - math.random(10)
	ineq = lib.check_number(numbl,20) .. lib.check_one_option_dropdown(rel,rel[3]) .. " x " .. lib.check_one_option_dropdown(rel,rel[3]) .. lib.check_number(numbd,20)
	set = "x " .. elem .. lib.check_string(brac[3],10) .. lib.check_number(numbl,20) .. " , " .. lib.check_number(numbd,20) .. lib.check_string(brac[4],10)
	index = 4
	ptfirst = 1
	ptlast = 1
end   
if (ind == 6) then
	numbd = math.random(10)
	ineq = lib.check_number(numbl,20) .. lib.check_one_option_dropdown(rel,rel[3]) .. " x " .. lib.check_one_option_dropdown(rel,rel[1]) .. lib.check_number(numbd,20)
	set = "x " .. elem .. lib.check_string(brac[3],10) .. lib.check_number(numbl,20) .. " , " .. lib.check_number(numbd,20) .. lib.check_string(brac[2],10)	
	index = 4
	ptfirst = 1
	ptlast = 0		
end   
if (ind == 7) then
	numbd = math.random(10) 
	ineq = lib.check_number(numbl,20) .. lib.check_one_option_dropdown(rel,rel[1]) .. " x " .. lib.check_one_option_dropdown(rel,rel[3]) .. lib.check_number(numbd,20)
	set = "x " .. elem .. lib.check_string(brac[1],10) .. lib.check_number(numbl,20) .. " , " .. lib.check_number(numbd,20) .. lib.check_string(brac[4],10)
	index = 4
	ptfirst = 0
	ptlast = 1	
end   
if (ind == 8) then
	numbd = math.random(10)
	ineq = lib.check_number(numbl,20) .. lib.check_one_option_dropdown(rel,rel[3]) .. " x " .. lib.check_one_option_dropdown(rel,rel[3]) .. lib.check_number(numbd,20)
	set = "x " .. elem .. lib.check_string(brac[3],10) .. lib.check_number(numbl,20) .. " , " .. lib.check_number(numbd,20) .. lib.check_string(brac[4],10)
	index = 4
	ptfirst = 1
	ptlast = 1	
end 
    
	if (index < 5) then
		first = numbl - 1 - dif
	else
	    dif = 1	
		first = -numbd - dif - 1
	end
	last =  numbd + 1 + dif	
	int = last - first	
	
	if (index < 5) then
		if (index < 3) then	
			results = "result[0] == 1 && result[1] == 0 &&"	
			if (index == 1) then
				results = results .. "result[2] == 0 &&"
			else
				results = results .. "result[2] == 1 &&"
			end			
		else
			results = "result[0] == 0 &&"	
			if (index == 3) then
				results = results .. "result[1] == 0 && result[2] == 1 &&"
			else
				results = results .. "result[1] == 1 && result[2] == 0 &&"
			end			
		end
		if (ptfirst == 1) then
			results = results .. "result[3] == 1 &&"
		else
			results = results .. "result[3] == 0 &&"
		end		
		if (ptlast == 1) then
			results = results .. "result[4] == 1"
		else
			results = results .. "result[4] == 0"
		end	
	else
		results = "result[0] == 0 && result[1] == 1 && result[2] == 0 &&"                                     
		if (ptfirst == 1) then
			results = results .. "result[3] == 1 &&"
		else
			results = results .. "result[3] == 0 &&"
		end		
		if (ptlast == 1) then
			results = results .. "result[4] == 1 &&"
		else
			results = results .. "result[4] == 0 &&"
		end					
			results = results .. "result[5] == 1 &&"	
		if (ptfirst2 == 1) then
			results = results .. "result[6] == 1 &&"
		else
			results = results .. "result[6] == 0 &&"
		end
		if (ptlast2 == 1) then
			results = results .. "result[7] == 1"
		else
			results = results .. "result[7] == 0"
		end	
	end	


mycanvas = function()

  lib.start_canvas(310, 100, "center", results)

  scale = math.floor(300/int)
  
  ow = 30
  v = 20
  ov = 5

--[[ bojenje intervala ]]--
  lib.add_rectangle (ov + scale, 2*(ow-v), dif*scale, 2*v, area_style, false, true)
  lib.add_rectangle (ov + (dif+1)*scale, 2*ow-v, (numbd - numbl)*scale, v, area_style, false, true)
  lib.add_rectangle (ov + (int - dif - 1)*scale, 2*(ow-v), dif*scale, 2*v, area_style, false, true)


--[[ brojevna prava ]]--
  lib.add_straight_path(ov, 2*ow, {{int*scale, 0}}, style, false, false)

--[[ intervali ]]--  
  if (index < 5) then
	  lib.add_straight_path(ov + (dif+1)*scale, 2*ow, { {0, -v}, {(numbd - numbl)*scale, 0}, {0, v}}, style, false, false)  
	  lib.add_straight_path(ov + (int - dif - 1)*scale, 2*ow, {{0, -2*v},{dif*scale, 0}}, style, false, false)
	  lib.add_straight_path(ov + (int-1)*scale, v-3, {{8, 3}, {-8, 3}}, style, false, false) 	  
	  lib.add_straight_path(ov + (dif+1)*scale, 2*ow, {{0, -2*v}, {-dif*scale, 0}}, style, false, false)
	  lib.add_straight_path(ov+scale, v-3, {{-8, 3}, {8, 3}}, style, false, false)  
  else
  lib.add_straight_path(ov + (dif+1)*scale, 2*ow, { {0, -v}, {(numbd - numbl)*scale, 0}, {0, v}}, style, false, false)  
  lib.add_straight_path(ov + (dif+numbd-numbl+1)*scale, 2*ow, { {0, -2*v}, {2* numbl*scale, 0}, {0, 2*v}}, style, false, false)  
  lib.add_straight_path(ov + (numbd+numbl+dif + 1)*scale, 2*ow, { {0, -v}, {(numbd - numbl)*scale, 0}, {0, v}}, style, false, false)  
  lib.add_straight_path(ov + (int - dif -1)*scale, 2*ow, {{0, -2*v}, {scale, 0}}, style, false, false)
  lib.add_straight_path(ov + (int-1)*scale, v-3, {{8, 3}, {-8, 3}}, style, false, false) 	  
  lib.add_straight_path(ov + (dif+1)*scale, 2*ow, {{0, -2*v}, {-scale, 0}}, style, false, false)
  lib.add_straight_path(ov+scale, v-3, {{-8, 3}, {8, 3}}, style, false, false)  
  end
  
  for i = 2, int  do 
      number = first + i - 1
      lib.add_straight_path(ov+(i-1)*scale, 2*ow, {{0, 3}, {0, -6}}, style, false, false)
	  if (i == dif+2 or i == int - dif) then
	      lib.add_input((i-1)*scale-2*ov, 4*v-ov, 40, 40, lib.check_number(number, 20))	
	  end
	  if (index == 5) then
		  area = numbd-numbl
		  if (i == dif+2+area or i == int-dif-area) then
			 lib.add_input((i-1)*scale-2*ov, 4*v-ov, 40, 40, lib.check_number(number, 20))	
		  end
	  end			  
  end 
  
--[[bojenje leva/desne tacke]]--
  lib.add_circle (ov + (dif+1)*scale, 2*ow, 4, dif_style, false, true)
  lib.add_circle (ov + (int - dif - 1)*scale, 2*ow, 4, dif_style, false, true) 
  if (index == 5) then
      lib.add_rectangle (ov + (numbd+numbl+dif + 1)*scale, 2*ow-v, (numbd - numbl)*scale, v, area_style, false, true)
	  lib.add_circle (ov + (dif+numbd-numbl+1)*scale, 2*ow, 4, dif_style, false, true)
	  lib.add_circle (ov + (numbd+numbl+dif + 1)*scale, 2*ow, 4, dif_style, false, true) 
  end
  
  lib.end_canvas()
end    

       
--[[
Broj x 
    je negativan             						   x < 0  			        ind = 1
	je pozitivan             						   x > 0				    ind = 2
	je nenegativan          						   x >= 0				    ind = 3
	je veci od @numb[l]@ i negativan je                numb[l] < x < 0          ind = 4
	nije manji od @numb[l]@	i nije pozitivan           numb[l] <= x <= 0        ind = 5
	je nenegativan i manji od @numb[d]@                0 <= x < numb[d]         ind = 6
	je pozitivan i nije veci od @numb[d]@              0 < x <= numb[d]	        ind = 7
	je nenegativan i nije veci od @numb[d]@            0 <= x <= numb[d]	    ind = 8	
]]--
            
            
