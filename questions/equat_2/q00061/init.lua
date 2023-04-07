
include("terms") 



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
        ["line_color"] = "000",
        ["off_line_color"] = "none",
        ["line_width"] = "2"};		

text_style = {["font_size"] = "14"}
  
rel = {" < ", " > ", " ≤ ", " ≥ ", " = ", " ≠ "}
brac = {"(", ")", "[", "]"}
space = " , \(  \ \ \ \ \ \ \)"

numb = {}
val = {}
term = {""}
bound = {""}
equ = {""}
op = {}
index = {0,0,0}
point = {}

opqu = math.random(4)
if (opqu < 3) then
    opcont = 3 - opqu
else	
    opcont = 7 - opqu
end

ind = math.random(2)
    
max_range = 6
for j = 1,2 do
	numb[j] = {}
	for i = 1,2 do	
		numb[j][i] = math.random(max_range) 	
		sg = math.random(2)	
		if (sg == 2) then
			numb[j][i] = - numb[j][i]			
		end
	end	
	val[j] = -numb[j][2]/ numb[j][1]
end	
	
for j = 1,2 do
	term[j] = ""	
	if (math.abs(numb[j][1]) ~= 1) then
		term[j] = term[j] .. tostring(numb[j][1])
    else
        if (numb[j][1] == -1) then	
		    term[j] = term[j] .. "-"
		end
	end	
	term[j] = term[j] .. " x "	
	if (numb[j][2] ~= 0) then
	    if (numb[j][2] < 0) then
			term[j] = term[j] .. " - "
		else
			term[j] = term[j] .. " + "
        end
     	term[j] = term[j] .. tostring(math.abs(numb[j][2]))	
	end 
end	
quest = "" 
if (ind == 1) then
	quest = "( " .. term[1] .. " ) * ( " .. term[2] .. " )"
else
	quest = lib.frac_start() .. term[1] .. lib.frac_mid() .. term[2] .. lib.frac_end()
end
quest = quest .. rel[opqu] .. tostring(0)

if (numb[1][1]*numb[2][1] < 0) then
    tmp = opcont
	opcont = opqu
	opqu = tmp
end	
if (numb[1][1] < 0) then
	numb[1][1] = - numb[1][1]
	numb[1][2] = - numb[1][2] 
end	
if (numb[2][1] < 0) then
	numb[2][1] = - numb[2][1]
	numb[2][2] = - numb[2][2] 
end	

for j = 1,2 do
	i = j
    if (val[1] > val[2]) then
	    i = 3 - j
	end	
	rest = val[i] - lib.math.round(val[i])	
	if (rest == 0) then
	    bound[j] = lib.check_number(val[i], 20)
	else
		bound[j] = lib.check_fraction_simple(-numb[i][2], numb[i][1])
	end
end

sing = 0
for i = 1,2 do   
	op[i] = opqu
end
for i = 1,3 do
	index[i] = 0
end		
first = val[1] 
second = val[2]
order = 1
if (val[2] < val[1]) then	
	first = val[2]
	second = val[1]	
	order = 2
end		
if (opqu == 1 or opqu == 3) then
	index[2] = 1
	if (ind == 2) then 
		if(order == 1) then	
			op[2] = 1
		else
			op[1] = 1
		end
	end	
	equ[2] = bound[1] .. " " .. lib.check_one_option_dropdown(rel, rel[op[1]]) .. " x " .. lib.check_one_option_dropdown(rel, rel[op[2]]) .. " " .. bound[2]	
else
	index[1] = 1
	index[3] = 1	
	if (ind == 1) then 
		op[1] = opcont		
	else
		if(order == 1) then
			op[1] = opcont		
			op[2] = 2
		else
			op[1] = 1
		end
	end	
	equ[2] = " x " .. lib.check_one_option_dropdown(rel, rel[op[1]]) .. " " .. bound[1] .. space .. " x " .. lib.check_one_option_dropdown(rel, rel[op[2]]) .. " " .. bound[2]				
end	
if (op[1] > 2) then
	ptfirst = 1
else
	ptfirst = 0
end		
if (op[2] > 2) then
	ptsecond = 1
else
	ptsecond = 0
end	
	
if (val[1] == val[2]) then
    sing = 1
end	

if (sing == 0 ) then
	answ = msg[1]
else
	if (ind == 2) then	
	    if (opqu == 1 or opqu == 3) then
		    answ = msg[2]
			index[1] = 0
			index[3] = 0				
		else
		    answ = msg[3]
			index[1] = 1
			index[3] = 1				
        end
		ptfirst = 0
	else
	    if (opqu == 2 or opqu == 4) then
		    answ = msg[3]
			if (opqu == 4) then
			   	ptfirst = 1
            else
				ptfirst = 0		
			end
			index[1] = 1
			index[3] = 1					
		else	
		    if (opqu == 3) then
				answ = msg[1]
				ptfirst = 1
				index[1] = 0
				index[3] = 0	
            else
				answ = msg[2]
				ptfirst = 0
				index[1] = 0
				index[3] = 0					
			end
		end
	end	
end	
equ[1] = lib.check_one_option_dropdown(msg, answ)

if (sing == 0) then
	numbl = second - first
	int = numbl
	dif = int/4 				
	int = int + 2*dif	
	point[1] = lib.math.round_dec(first, 2)	
	point[2] = lib.math.round_dec(second, 2)
else
	numbl = 0
	dif = 3 				
	int = 2*dif	
	point[1] = lib.math.round_dec(val[1], 2)	
end	

mycanvas = function()

  results = ""
  
    for i = 1,3 do 
      j = i - 1
      if (j > 0) then
	     results = results .. "&& "
      end
      results = results .. "result[" .. tostring(j) .. "] == "	.. tostring(index[i])    
    end	                                
	if (ptfirst == 1) then
		results = results .. " && result[3] == 1"
	else
		results = results .. "  && result[3] == 0"
	end	
    if (sing == 0) then	
		if (ptsecond == 1) then
			results = results .. " && result[4] == 1"
		else
			results = results .. " && result[4] == 0"
		end	
    end		

  lib.start_canvas(310, 100, "center", results)

  scale = math.floor(300/int)
  
  ow = 30
  v = 20
  ov = 5

--[[ bojenje intervala ]]--
  lib.add_rectangle (ov, 2*(ow-v), dif*scale, 2*v, area_style, false, true)
  lib.add_rectangle (ov + dif*scale, 2*ow-v, numbl*scale, v, area_style, false, true)
  lib.add_rectangle (ov + (int - dif)*scale, 2*(ow-v), dif*scale, 2*v, area_style, false, true)

--[[ brojevna prava ]]--
  lib.add_straight_path(ov, 2*ow, {{int*scale, 0}}, style, false, false)

--[[ intervali ]]--  
  lib.add_straight_path(ov + dif*scale, 2*ow, { {0, -v}, {numbl*scale, 0}, {0, v}}, style, false, false)  
  lib.add_straight_path(ov + (int - dif)*scale, 2*ow, {{0, -2*v},{dif*scale, 0}}, style, false, false)
  lib.add_straight_path(ov-3 + int*scale, v-3, {{8, 3}, {-8, 3}}, style, false, false) 	  
  lib.add_straight_path(ov + dif*scale, 2*ow, {{0, -2*v}, {-dif*scale, 0}}, style, false, false)
  lib.add_straight_path(ov+3, v-3, {{-8, 3}, {8, 3}}, style, false, false)   
	  
--[[bojenje leva/desne tacke]]--
  lib.add_input(dif*scale-2*ov, 4*v, 50, 50, lib.check_number(point[1], 30)) 
  lib.add_circle (ov + dif*scale, 2*ow, 4, dif_style, false, true)
  if (sing == 0) then
	  lib.add_input((dif+numbl)*scale-2*ov, 4*v, 50, 50, lib.check_number(point[2], 30))
      lib.add_circle (ov + (numbl + dif)*scale, 2*ow, 4, dif_style, false, true)	  
  end	
  
  lib.end_canvas()
end    
         
         