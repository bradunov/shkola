
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};		

text_style = {["font_size"] = "16"}

set = {2, 3, 4, 5, 6, 7, 8, 9, 10}

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}
term = {""}
ch = {}
inds = {}
enp = {}

brac = {"\(\big ( \)", "\(\big ) \)"}

oper = {" - ", " + ", ":", "*"}

sign = {"<", ">", "≤", "≥"} 
index = math.random(4) 
dif = 0.2     

max_range = 20
test = 0
for i = 1,3 do
    qq = lib.math.random_shuffle(set)
	denom[i] = qq[1]
    enum[i] = 2 + math.random(max_range);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
	end			
	fact = math.random(2)
	if (fact == 1) then
        enum[i] = - enum[i]
		test = test + 1
	end	
	value[i] = enum[i] / denom[i]	
end	

tmp = math.abs(value[2]) - math.abs(value[3])
if (math.abs(tmp) < 2) then
    if (enum[3] > 0) then
        enum[3] = enum[3] + denom[3] * (2 + math.random(3))
    else
        enum[3] = enum[3] - denom[3] * (2 + math.random(3))	
    end		
	value[3] = enum[3] / denom[3]		
end		

if (test == 0) then
    q = math.random(3)
	enum[q] = -enum[q]
    value[q] = -value[q]
end

inds[1] = math.random(4);
if (inds[1] < 3) then
    inds[2] = 2 + math.random(2)
else
    inds[2] = math.random(2)
end

choice = math.random(4)

if (choice < 3) then
    if (inds[1] < 3) then
        imenilac = denom[1] * denom[2] 
        if (inds[1] == 1) then
            brojilac = enum[1] * denom[2] - enum[2] * denom[1]
        else
            brojilac = enum[1] * denom[2] + enum[2] * denom[1]	
        end 
    else
        if (inds[1] == 3) then
	        imenilac = enum[2] * denom[1]
            brojilac = enum[1] * denom[2] 
        else
	        brojilac = enum[1] * enum[2]
            imenilac = denom[1] * denom[2] 
        end    	
    end	
    if (inds[2] < 3) then
        denom[4] = imenilac * denom[3] 
        if (inds[2] == 1) then
            enum[4] = brojilac * denom[3] - imenilac * enum[3] 
        else
            enum[4] = brojilac * denom[3] + imenilac * enum[3] 	
        end
    else
        if (inds[2] == 4) then
	        denom[4] = imenilac * denom[3] 
            enum[4] = brojilac * enum[3] 
        else
	        denom[4] = imenilac * enum[3] 
            enum[4] = brojilac * denom[3] 
        end    	
    end	
else
    if (inds[1] < 3) then
        imenilac = denom[2] * denom[3] 
        if (inds[1] == 1) then
            brojilac = enum[2] * denom[3] - enum[3] * denom[2]
        else
            brojilac = enum[2] * denom[3] + enum[3] * denom[2]	
        end
    else
        if (inds[1] == 3) then
	        imenilac = enum[3] * denom[2]
            brojilac = enum[2] * denom[3] 
        else
            imenilac = denom[2] * denom[3] 
	        brojilac = enum[2] * enum[3]		
        end    	
    end	
    if (inds[2] < 3) then
        denom[4] = imenilac * denom[1] 
        if (inds[2] == 1) then
            enum[4] = enum[1] * imenilac  - denom[1] * brojilac
        else
            enum[4] = enum[1] * imenilac  + denom[1] * brojilac 	
        end
    else
        if (inds[2] == 4) then
	        denom[4] = imenilac * denom[1] 
            enum[4] = brojilac * enum[1] 
        else
	        enum[4] = imenilac * enum[1] 
            denom[4] = brojilac * denom[1] 
        end    	
    end	
end
 
if (denom[4] < 0) then
    denom[4] = - denom[4]
    enum[4]	= - enum[4]
end

--[[ stampanje nejednacine ]]--
	
for i = 1,4 do
    term[i] = ""
    q = lib.math.gcd(enum[i], denom[i])
    denom[i] = denom[i] / q
    enum[i] = enum[i] / q
    value[i] = enum[i]/denom[i]
    tmp = math.floor(value[i] * 10)
	rest = value[i] * 10 - tmp	
    if (value[i] > 0) then
        whl[i] = math.floor(value[i])
    else 
        whl[i] = math.ceil(value[i])
    end
    enum_p[i] = enum[i]	- whl[i] * denom[i]   
    enp[i] = enum_p[i]
    if (rest == 0) then	
	    term[i] = lib.dec_to_str(lib.math.round_dec(value[i], 1))
        ch[i] = 1
	else		
        if (whl[i] ~= 0) then
            term[i] = term[i] .. tostring(whl[i])  
			enum_p[i] = math.abs(enum_p[i])
        end
        term[i] = term[i] .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	
        ch[i] = 2
	end
end

neq = ""
if (choice == 1) then
    neq = brac[1] .. "x " .. oper[inds[1]] .. " ("  .. term[2] .. ") " .. brac[2] .. " " .. oper[inds[2]] .. " ("  ..  term[3] .. ") " .. sign[index] .. " " .. term[4]
end
if (choice == 2) then
    neq = brac[1] .. " ("  .. term[1] .. ") ".. oper[inds[1]]  .. " x" .. brac[2] .. " " .. oper[inds[2]] .. " ("  ..  term[3] .. ") " .. sign[index] .. " " .. term[4]
end
if (choice == 3) then
    neq = " ("  .. term[1] .. ") " .. oper[inds[2]] .. " " .. brac[1] .. "x " .. oper[inds[1]] .. " ("  ..  term[3] .. ") " .. brac[2] .. " " .. sign[index] .. " " .. term[4]
end
if (choice == 4) then
    neq = " ("  .. term[1] .. ") " .. oper[inds[2]] .. " " .. brac[1] .. " ("  ..  term[2] .. ") " .. oper[inds[1]] .. " x ".. brac[2] .. " " .. sign[index] .. " " .. term[4]
end


--[[ test znaka]]--

if (choice == 1) then
    test = value[1] - dif
	add = value[2]
	bdd = value[3]
end
if (choice == 2) then
    test = value[2] - dif
	add = value[1]
	bdd = value[3]
end
if (choice == 3) then
    test = value[2] - dif
	add = value[3]
	bdd = value[1]
end	   
if (choice == 4) then
    test = value[3] - dif
	add = value[2]
	bdd = value[1]	
end		   
if (test == 0) then
	dif = dif + 1
	test = test - 1
end		
if (inds[1] == 1) then
	tmp = test - add
	if (choice == 2 or choice == 4) then
        tmp = - tmp
    end
end	
if (inds[1] == 2) then
	tmp = test + add
end	
if (inds[1] == 3) then
    tmp = test / add
	if (choice == 2 or choice == 4) then
        tmp = 1/ tmp
    end	
end	
if (inds[1] == 4) then
	tmp = test * add
end	
if (inds[2] == 1) then
	res = tmp - bdd
	if (choice > 2) then
        res = - res
    end
end	
if (inds[2] == 2) then
	res = tmp + bdd
end	
if (inds[2] == 3) then
	res = tmp / bdd
	if (choice > 2) then
        res = 1/ res
    end
end	
if (inds[2] == 4) then
	res = tmp * bdd	
end
  	
if (value[4] - res > 0) then
    ind = index
else	
    if (index == 1 or index == 3) then
        ind = index + 1
    else
        ind = index - 1
	end	
end 

--[[ stampanje resenja ]]--

answ1 = ""
answ2 = ""

choiceold = choice
if (choice > 2) then
   choice = choice - 1
end

if (ch[choice] == 1) then	
    answ1 = lib.check_number(value[choice],30)	
else 
    if (whl[choice] ~= 0) then
        answ1 = lib.check_number(whl[choice],20)  
    end
	tmp = enum_p[choice]/denom[choice]	
 	condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
    sln2 = "numerator="..tostring(enum_p[choice])..";denominator="..tostring(denom[choice])..";"
    answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)
end

reply = "x " .. lib.check_one_option_dropdown(sign, sign[ind]) .. " " .. answ1 .. answ2	

--[[iskljucivanje deljenja nulom]]--

bound1 = 0
bound2 = 0
if (inds[1] == 3) then
    if (choiceold == 2 or choiceold == 4) then
        if (ind == 1 or ind == 3) then
	        if (value[choice] >= 0) then
		        reply = lib.check_number(0, 20) .. " " .. lib.check_one_option_dropdown(sign, "<") .. " " .. reply
                bound1 = 1
			end			
        else
	        if (value[choice] <= 0) then
		        reply = lib.check_number(0, 20) .. " " .. lib.check_one_option_dropdown(sign, ">") .. " " .. reply
                bound2 = 1
			end	
		end		
    end	
end	

edge = ""
znak = 0

if (choiceold > 2 and inds[1] < 3) then
    if (choiceold == 3) then
	    sol = value[2]
	    gran = value[3]
	    gran_whl = whl[3]
	    gran_enum = enum_p[3]
	    gran_denom = denom[3]
	    forma = ch[3]
    else
	    sol = value[3]	
        gran = value[2]
        gran_whl = whl[2]
	    gran_enum = enum_p[2]
	    gran_denom = denom[2]
	    forma = ch[2]	
    end	
    if (ind == 1 or ind == 3) then	
		if (inds[1] == 1) then
		    if (sol > gran) then
				znak = 2
			end
		else
		    if (sol > -gran) then			
				znak = 1
            end				
        end			
    else	
	    if (inds[1] == 1) then
 	        if (sol < gran) then
				znak = 2
			end	
		else	
 	        if (sol < -gran) then
				znak = 1    
            end	
        end	
    end		
    if (znak > 0) then 
        if ((znak == 1 and gran > 0) or (znak == 2 and gran < 0)) then
            edge = lib.check_string("-", 10)
	    end
	    if (forma == 1) then	
            edge = edge .. " " .. lib.check_number(math.abs(gran),30)	
        else 
            if (gran_whl ~= 0) then
                edge = edge .. " " .. lib.check_number(math.abs(gran_whl),20)  
			end
            tmpbr = math.abs(gran_enum)
            edge = edge .. lib.check_fraction_simple(tmpbr,gran_denom)	
        end
		if (ind == 1 or ind == 3) then
		    reply = edge .. " " .. lib.check_one_option_dropdown(sign, "<") .. " " .. reply	
	    else
		    reply = edge .. " " .. lib.check_one_option_dropdown(sign, ">") .. " " .. reply		
        end			
    end
end	

	
dist = 2
leng = 2 * dist
part = denom[choice] 	
first = whl[choice] - dist
last =  whl[choice] + dist
int = leng * part
sht = enp[choice]

if (ind == 2 or ind == 4) then
    results = "result[0] == 0 && result[1] == 1 &&" 
else
    results = "result[0] == 1 && result[1] == 0 &&" 	
end
if (ind > 2) then
	results = results .. "result[2] == 1"
else
	results = results .. "result[2] == 0"
end	


mycanvas = function()
  lib.start_canvas(340, 120, "center", results)

  ow = 40
  w = 15
  v = 30
  ov = 5

  scale1 = math.floor(300/int)
  scale2 = part * scale1
  mark = dist*scale2 + sht*scale1 
  
  admark1 = 0
  admark2 = 0	  
  for i = 1, leng + 1 do 
      number = first + i - 1
      lib.add_straight_path(w+(i-1)*scale2, 2*ow, {{0, 10}, {0, -20}}, style, false, false)
      lib.add_input(2+(i-1)*scale2, 2*(ow+w-ov), 40, 30, lib.check_number(number, 25))	  	  
	  if (number == 0) then
	      if (bound1 == 1) then
	          admark1 = (i-1)*scale2
		  end  
	      if (bound2 == 1) then
	          admark2 = last*scale2
	      end 		  
	  end	  
  end
  
  lib.add_straight_path(w+admark1, 2*ow, {{mark-admark1, 0}, {0, -ow}, {-mark+admark1, 0}}, dif_style, false, true)
  lib.add_straight_path(w+8+admark1, ow-3, {{-8, 3}, {8, 3}}, style, false, false) 
  lib.add_straight_path(w + leng*scale2-admark2, 2*ow, {{-leng*scale2+mark+admark2, 0}, {0, -2*v}, {leng*scale2-mark-admark2, 0}}, dif_style, false, true)
  lib.add_straight_path(w+leng*scale2-admark2-8, 2*(ow-v)-3, {{8, 3}, {-8, 3}}, style, false, false) 

  lib.add_straight_path(w, 2*ow, {{leng*scale2, 0}}, style, false, false)     
  
  for i = 2, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, 2*ow, {{0, 5}, {0, -10}}, style, false, false)
  end 
  
  lib.add_circle (w+mark, 2*ow, 4, dif_style, false, true)

  lib.end_canvas()
end   


  
