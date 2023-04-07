
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
  
rel = {" < ", " > ", " ≤ ", " ≥ "}
brac = {"(", ")", "[", "]"}
space = " , \(  \ \ \ \ \ \ \)"

numb = {}
broj = {}
imen = {}
val = {}
term = {""}
bound = {""}
op = {}
oopp = {}
out = {}
point = {}
colpt = {}
index = {}

opqu = math.random(4)
if (opqu < 3) then
    opcont = 3 - opqu
else	
    opcont = 7 - opqu
end
for i = 1,3 do   
	op[i] = opqu
end		
for i = 1,3 do
	colpt[i] = 0 
end	
for i = 1,4 do
    index[i] = 0
end	

ind = math.random(2)

sing = 0
max_range = 6

for j = 1,2 do
	numb[j] = {}
	fct = 1 + math.random(4)
	for i = 1,7 do
        min_range = 0	
	    if (ind == 1) then
     		if( i > 4) then
				min_range = 1
			else
				if (i > 1) then
					min_range = -1
				end	
			end
		else
		  	if( i == 4) then
				min_range = 1
			end			
        end 		
		numb[j][i] = min_range + math.random(max_range) 
        if (i < 5) then		
			sg = math.random(2)	
			if (sg == 2) then
				numb[j][i] = - numb[j][i]			
			end
		end
	end	
end	

if (ind == 2) then
	fct = 1 + math.random(4)
    numb[2][4] = fct * numb[1][4]   
    numb[2][7] = fct * numb[1][7] 
	for j = 1,2 do
		val[j] = -numb[j][2]/ numb[j][1]
	end
	if (val[2] == val[1]) then	
	    if (numb[2][2] < 0) then 
			numb[2][2] = numb[2][2] - math.random(3)
		else
			numb[2][2] = numb[2][2] + math.random(3)		
		end
	end
	for j = 1,2 do
		val[j] = -numb[j][2]/ numb[j][1]
		if (val[j] < 0) then
			broj[j] = -math.abs(numb[j][2])
		else
			broj[j] = math.abs(numb[j][2])	
		end		
		imen[j] = math.abs(numb[j][1])		
	end
	if (val[2] < val[1]) then
		tmp = val[1]
		val[1] = val[2]
		val[2] = tmp
		tmp = broj[1]
		broj[1] = broj[2]
		broj[2] = tmp
		tmp = imen[1]
		imen[1] = imen[2]
		imen[2] = tmp				
	end
	if (numb[1][1] * numb[2][1] > 0) then
		op[2] = opcont
	else
		op[1] = opcont
		op[3] = opcont			
	end			
end	
	
quest = ""
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
			sign = " - "
		else
			sign = " + "
        end
     	term[j] = term[j] .. sign .. tostring(math.abs(numb[j][2]))	
	end 
	if (ind == 1) then
		quest = quest .. lib.frac_start() .. term[j] .. lib.frac_mid() .. tostring(math.abs(numb[j][5])) .. lib.frac_end() 
		if (numb[j][4] ~= 0) then
			if (numb[j][4] < 0) then
				sign = " - "
			else
				sign = " + "
			end
			tmp = math.abs(numb[j][4]/numb[j][7])
			if (tmp == math.floor(tmp)) then
				quest = quest .. sign .. tostring(math.floor(tmp)) 
			else
				qq = lib.math.gcd(numb[j][4],numb[j][7])
				numb[j][4] = numb[j][4]/qq
				numb[j][7] = numb[j][7]/qq
				quest = quest .. sign .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][4]))) .. lib.frac_mid() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_end() 
			end
		end
	else
		quest = quest .. lib.frac_start() .. tostring(math.abs(numb[j][5])) .. lib.frac_mid() .. term[j] .. lib.frac_end() 
		if (numb[j][4] ~= 0) then
			if (numb[j][4] < 0) then
				sign = " - "
			else
				sign = " + "
			end
			tmp = math.abs(numb[j][7]/numb[j][4])
			if (tmp == math.floor(tmp)) then
				quest = quest .. sign .. tostring(math.floor(tmp)) 
			else
				quest = quest .. sign .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_mid() .. tostring(math.floor(math.abs(numb[j][4]))) .. lib.frac_end() 
			end
		end		
	end
	if (j == 1) then
		quest = quest .. rel[opqu]
	end
end

if (ind == 1) then
	coef = numb[1][5] * numb[1][7] * numb[2][5] * numb[2][7]
	a = coef * (numb[1][1] / numb[1][5] - numb[2][1] / numb[2][5])
	b = coef * (numb[2][2] / numb[2][5] + numb[2][4] / numb[2][7] - numb[1][2] / numb[1][5] - numb[1][4] / numb[1][7])
else
	a = numb[2][1] * numb[1][5] - numb[1][1] * numb[2][5]
	b = numb[1][2] * numb[2][5] - numb[2][2] * numb[1][5] 
end
aa = lib.math.round(a)
bb = lib.math.round(b)
if (aa * bb ~= 0) then
	q = lib.math.gcd(aa,bb)
	aa = aa/q
	bb = bb/q
end	
if (aa < 0) then
	aa = - aa
	bb = - bb
	for i = 1,3 do
		if (op[i] == opqu) then
			op[i] = opcont
		else
			op[i] = opqu
		end
	end	
end

equ = ""
result = ""
if (aa ~= 0) then
	value = bb / aa
	rest = value - lib.math.round(value)	
	if (rest == 0) then
	    result = lib.check_number(value, 20)
	else
		result = lib.check_fraction_simple(bb, aa)
	end
    if (ind == 1) then	
		equ = equ .. " x " .. lib.check_one_option_dropdown(rel, rel[op[1]])		  
		if (rest == 0) then
			equ = equ .. result	  			
		else		
			equ =  equ .. result  
		end  
		if (op[1] == 1 or op[1] == 3) then
			index[1] = 1
		else
			index[2] = 1	
		end				
		if (op[1] > 2) then
			colpt[1] = 1
		end			
	else	
	    interv = 0
		if (value <= val[1]) then 
		    interv = 1
		else
			if (value <= val[2]) then 
				interv = 2
			else
				interv = 3
			end
		end	
		for i = 1,2 do
			if (broj[i] * imen[i] ~= 0) then
				q = lib.math.gcd(broj[i],imen[i])
				broj[i] = broj[i]/q
				imen[i] = imen[i]/q
			end		
			if (val[i] == lib.math.round(val[i])) then	
				bound[i] = lib.check_number(val[i],20) 		
			else
				bound[i] = lib.check_fraction_simple(broj[i], imen[i])		
			end	
		end			
		for i = 1,3 do
			oopp[i] = op[i]	
			if (op[i] < 3) then
				oopp[i] = 3 - op[i]
			else	
				oopp[i] = 7 - op[i]
			end
		end	
		if (op[1] == 1 or op[1] == 3) then
			if (interv == 1) then		
				equ = equ  .. " x " .. lib.check_one_option_dropdown(rel, rel[op[1]]) .. result
				equ = equ .. space .. bound[1] .. lib.check_one_option_dropdown(rel, rel[1]) .. " x " .. lib.check_one_option_dropdown(rel, rel[1])  .. bound[2]
                if (op[1] > 2) then
                   colpt[1] = 1
                end	
                index[1] = 1	
                index[4] = 1				
			else
				equ = equ .. " x " .. lib.check_one_option_dropdown(rel, rel[1]) .. bound[1]
				index[1] = 1				
				if (interv == 2) then		
					equ = equ .. space .. result .. lib.check_one_option_dropdown(rel, rel[oopp[2]]) .. " x " .. lib.check_one_option_dropdown(rel, rel[1])  .. bound[2]
					if (op[2] > 2) then
						colpt[2] = 1
					end	
					index[4] = 1					
				else
					equ = equ .. space .. bound[2] .. lib.check_one_option_dropdown(rel, rel[1]) .. " x " .. lib.check_one_option_dropdown(rel, rel[op[3]]) .. result	
					if (op[3] > 2) then
						colpt[3] = 1
					end						
					index[4] = 1
				end	
			end		
		else
            if (interv == 1) then
				equ = equ .. result .. lib.check_one_option_dropdown(rel, rel[oopp[1]]) .. " x " .. lib.check_one_option_dropdown(rel, rel[1]) .. bound[1]				
				equ = equ .. space .. " x " .. lib.check_one_option_dropdown(rel, rel[2]) .. bound[2]
				if (op[1] > 2) then
					colpt[1] = 1
				end	
                index[3] = 1
                index[2] = 1				
			else
				if (interv == 2) then		
					equ = equ .. bound[1] .. lib.check_one_option_dropdown(rel, rel[1]) .. " x " .. lib.check_one_option_dropdown(rel, rel[op[2]])  .. result										
					equ = equ .. space .. " x " .. lib.check_one_option_dropdown(rel, rel[2]) .. bound[2]
					if (op[2] > 2) then
						colpt[2] = 1
					end
					index[3] = 1
					index[2] = 1					
				else
					equ = equ .. bound[1] .. lib.check_one_option_dropdown(rel, rel[1]) .. " x " .. lib.check_one_option_dropdown(rel, rel[1])  .. bound[2]										
					equ = equ .. space .. " x " .. lib.check_one_option_dropdown(rel, rel[op[3]]) .. result
					if (op[3] > 2) then
						colpt[3] = 1
					end	
					index[3] = 1	
					index[2] = 1					
				end	
			end
        end			
	end
else
	sing = 1
    if (ind == 1) then	
		if (bb == 0) then
			if (opqu > 2) then
				equ = lib.check_one_option_dropdown(msg, msg[2])
				index[1] = 1	
				index[2] = 1					
			else
				equ = lib.check_one_option_dropdown(msg, msg[1])			
			end	
		else    
			if (opqu == 1 or opqu == 3) then
				if (bb > 0) then
					equ = lib.check_one_option_dropdown(msg, msg[2])
					index[1] = 1	
					index[2] = 1						
				else
					equ = lib.check_one_option_dropdown(msg, msg[1])				
				end
			else	
				if (bb > 0) then
					equ = lib.check_one_option_dropdown(msg, msg[1])				
				else
					equ = lib.check_one_option_dropdown(msg, msg[2])
					index[1] = 1	
					index[2] = 1						
				end	
			end
		end
	else
		for i = 1,2 do
			if (broj[i] * imen[i] ~= 0) then
				q = lib.math.gcd(broj[i],imen[i])
				broj[i] = broj[i]/q
				imen[i] = imen[i]/q
			end		
			if (val[i] == lib.math.round(val[i])) then	
				bound[i] = lib.check_number(val[i],20) 		
			else
				bound[i] = lib.check_fraction_simple(broj[i], imen[i])		
			end	
		end			
		if (bb >= 0) then		
			if (op[1] == 1 or op[1] == 3) then					
				equ = equ  .. " x " .. lib.check_one_option_dropdown(rel, rel[1]) .. bound[1]
				equ = equ .. space .. " x " .. lib.check_one_option_dropdown(rel, rel[2])  .. bound[2]
				index[1] = 1	
				index[2] = 1				
			else		
				equ = equ .. bound[1] .. lib.check_one_option_dropdown(rel, rel[1]) .. " x " .. lib.check_one_option_dropdown(rel, rel[1])  .. bound[2]
				index[3] = 1					
			end	
        else	
			if (op[1] == 1 or op[1] == 3) then	
				equ = equ .. bound[1] .. lib.check_one_option_dropdown(rel, rel[1]) .. " x " .. lib.check_one_option_dropdown(rel, rel[1])  .. bound[2]
				index[3] = 1
            else				
				equ = equ  .. " x " .. lib.check_one_option_dropdown(rel, rel[1]) .. bound[1]
				equ = equ .. space .. " x " .. lib.check_one_option_dropdown(rel, rel[2])  .. bound[2]
				index[1] = 1
				index[2] = 1				
			end
        end			
	end	
end

--[[parametri slike   ]]--

if (ind == 1) then
	dif = 4
	numbl = 0
	numbd = numbl 
	int = 2 * dif
    if (sing == 0) then   	
		point[1] = lib.math.round_dec(value, 2)	
    else
 	tmp = numb[2][2]/numb[2][5] + numb[2][4]/numb[2][7] - numb[1][2]/numb[1][5] - numb[1][4]/numb[1][7]	
point[1] = lib.math.round_dec(tmp, 2)	
    end       	
else
    if (sing == 0) then 	
		val[3] = value  
		out =  lib.math.argsort(val) 	
		for i = 1,3 do
			point[i] = lib.math.round_dec(val[out[i]], 2)	
		end			
		numbl = val[out[2]] - val[out[1]] 
		numbd = val[out[3]] - val[out[2]]
		int = val[out[3]] - val[out[1]]	
		dif = int/5 		
    else
		for i = 1,2 do
			point[i] = lib.math.round_dec(val[i], 2)	
		end			
		numbl = val[2] - val[1] 
		numbd = 0
		int = numbl
		dif = int/4 		
	end		
	int = int + 2*dif	
end

if (ind == 1) then	
	if (sing == 0) then
		if (index[1] == 1) then	
			results = "result[0] == 1 &&"       	
		else 
			results = "result[0] == 0 &&" 
		end		
		if (index[2] == 1) then	
			results = results .. "result[1] == 1 &&"       	
		else 
			results = results .. "result[1] == 0 &&" 
		end	
		if (colpt[1] == 1) then	
			results = results .. "result[2] == 1"       	
		else 
			results = results .. "result[2] == 0" 
		end	
	else
		if (index[1] * index[2] == 1) then
			results = "result[0] == 1 && result[1] == 1 && result[2] == 1 "       	
		else 
			results = "result[0] == 0 && result[1] == 0 && result[2] == 0 " 
		end	
	end			
else
	if (index[1] == 1) then	
		results = "result[0] == 1 &&"       	
	else 
		results = "result[0] == 0 &&" 
	end		
	if (index[2] == 1) then	
		results = results .. "result[1] == 1 &&"       	
	else 
		results = results .. "result[1] == 0 &&" 
	end		
	if (colpt[1] == 1) then	
		results = results .. "result[2] == 1 &&"       	
	else 
		results = results .. "result[2] == 0 &&" 
	end		
	if (index[3] == 1) then
		results = results .. "result[3] == 1 &&"
	else
		results = results .. "result[3] == 0 &&"
	end	
	if (index[4] == 1) then
		results = results .. "result[4] == 1 &&"
	else
		results = results .. "result[4] == 0 &&"
	end	
	if (sing == 0) then		
		if (colpt[2] == 1) then	
			results = results .. "result[5] == 1 &&"       	
		else 
			results = results .. "result[5] == 0 &&" 
		end	
		if (colpt[3] == 1) then	
			results = results .. "result[6] == 1"       	
		else 
			results = results .. "result[6] == 0" 
		end	
	else
		if (colpt[2] == 1) then	
			results = results .. "result[5] == 1"       	
		else 
			results = results .. "result[5] == 0" 
		end	
	end	
end	



mycanvas = function()

  lib.start_canvas(330, 120, "center", results)

  scale = math.floor(300/int)
  
  ow = 30
  v = 20
  ov = 5
  
  --[[ intervali ]]--  
  lib.add_straight_path(ov + (int - dif)*scale, 2*ow, {{0, -2*v},{dif*scale, 0}}, style, false, false)
  lib.add_straight_path(ov -3 + int*scale, v-3, {{8, 3}, {-8, 3}}, style, false, false) 	  
  lib.add_straight_path(ov + dif*scale, 2*ow, {{0, -v}, {-dif*scale, 0}}, style, false, false)
  lib.add_straight_path(ov+3, 2*v-3, {{-8, 3}, {8, 3}}, style, false, false)  
  if (ind == 2) then
      if (sing == 0) then	  
		  lib.add_straight_path(ov + dif*scale, 2*ow, { {0, -2*v}, {numbl*scale, 0}, {0, 2*v}}, style, false, false)  
		  lib.add_straight_path(ov + (numbl+dif)*scale, 2*ow, { {0, -v}, {numbd*scale, 0}, {0, v}}, style, false, false)  
      else
		  lib.add_straight_path(ov + dif*scale, 2*ow, { {0, -ow}, {numbl*scale, 0}, {0, ow}}, style, false, false)  	  
      end 
  end
  
--[[ bojenje intervala i granicnih tacaka ]]--
  lib.add_rectangle (ov , 2*ow-v, dif*scale, v, area_style, false, true)
  lib.add_rectangle (ov + (int - dif)*scale, 2*(ow-v), dif*scale, 2*v, area_style, false, true) 
  lib.add_circle (ov + dif*scale, 2*ow, 4, dif_style, false, true)
  if (ind == 1) then
     if (sing == 0) then
	    lib.add_input(dif*scale-2*ov, 4*v-ov, 50, 50, lib.check_number(point[1], 30))
     else
		lib.add_text(dif*scale-2*ov, 4*v-ov, point[1], text_style, false, false)
     end 
  else
	  lib.add_input(dif*scale-2*ov, 3*ow-v, 50, 50, lib.check_number(point[1], 30)) 
	  lib.add_input((dif+numbl)*scale-2*ov, 3*ow+ov, 50, 50, lib.check_number(point[2], 30))
      if (sing == 0) then		  
		  lib.add_input((int - dif)*scale-2*ov, 3*ow-v, 50, 50, lib.check_number(point[3], 30)) 
      end
  end	  
  if (ind == 2) then
      mid = 2*v
	  if (sing == 1) then
	      mid = ow
	  end	  
      lib.add_rectangle (ov + dif*scale, 2*ow-mid, numbl*scale, mid, area_style, false, true)
	  lib.add_rectangle (ov + (numbl+dif)*scale, 2*ow-v, numbd*scale, v, area_style, false, true)
  	  lib.add_circle (ov + (dif+numbl)*scale, 2*ow, 4, dif_style, false, true)
	  if (sing == 0) then
		  lib.add_circle (ov + (int - dif)*scale, 2*ow, 4, dif_style, false, true)  
      end	  
  end	  

--[[ brojevna prava ]]--
  lib.add_straight_path(ov, 2*ow, {{int*scale, 0}}, style, false, false)

  lib.end_canvas()
end    
              

--[[
n(j,1)=/=0,  n(j,2)}, n(j,3), n(j,4)   proizvoljan znak 
n(j,5), n(j,6)}, n(j,7)                 > 1

##  ind = 1
{n(1,1)x+n(1,2)}/n(1,5)+n(1,4)/n(1,7) = {n(2,1)x+n(2,2)}/n(2,5)+n(2,4)/n(2,7)                       


##  ind = 2
n(1,5)/{n(1,1)x+n(1,2)}+n(1,7)/n(1,4) = n(2,5)/{n(2,1)x+n(2,2))+n(2,7)/n(2,4) 

----------------------------------------------------------------------------------
              | (-infty, val[1])   |   (val[1],val[2])    |   (val[2],infty)
---------------------------------------------------------------------------------
numb[1][1]>0  |     -         opqu       +     opcont            +    opqu
numb[2][1]>0  |     -                    -                       +
----------------------------------------------------------------------------------
numb[1][1]>0  |     -         opcont     +     opqu              +    opcont
numb[2][1]<0  |     +                    +                       -
----------------------------------------------------------------------------------
numb[1][1]<0  |     +         opcont     -     opqu              -    opcont
numb[2][1]>0  |     -                    -                       +
----------------------------------------------------------------------------------
numb[1][1]<0  |     +         opqu       -     opcont            -    opqu
numb[2][1]<0  |     +                    +                       -
----------------------------------------------------------------------------------


##  specijalan slucaj aa = 0 
0*x >=< bb   ind = 3   Rešenje je svaki realan broj.    
0*x >=< bb   ind = 4   Nema rešenja.
]]--
            