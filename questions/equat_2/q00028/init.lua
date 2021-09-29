
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

sign = {"<", ">", "≤", "≥"}
index = math.random(4) 

choice = math.random(2)      --[[ 1 x brojilac, 2 x imenilac]]--

max_range = 20
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
	denom[i] = qq[1]
    enum[i] = 2 + math.random(max_range);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
	end	
	if (i == 2 and fact == 2) then
	    fact = 1
    else		
	    fact = math.random(2)
	end	
	if (fact == 1) then
        enum[i] = - enum[i]
	end	
	value[i] = enum[i] / denom[i]	
end	

if (choice == 1) then
    enum[3] = enum[1] * denom[2]
    denom[3] = denom[1] * enum[2] 
else
    enum[3] = enum[2] * denom[1]
    denom[3] = denom[2] * enum[1] 
end	

if (denom[3] < 0) then
    enum[3] = - enum[3]
    denom[3] = - denom[3]
end	


for i = 1,3 do
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
    if (i == 1) then
        sht = enum_p[1]
    end
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
answ1 = ""
answ2 = ""

if (ch[1] == 1) then	
        answ1 = lib.check_number(value[1],30)	
else 
    if (whl[1] ~= 0) then
        answ1 = lib.check_number(whl[1],20)  
    end
	tmp = enum_p[1]/denom[1]	
 	condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
    sln2 = "numerator="..tostring(enum_p[1])..";denominator="..tostring(denom[1])..";"
    answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)
end

fact = 2
if (choice == 1) then 
    neq = "x : " .. "(" .. term[2] .. ")" .. sign[index] .. " " .. term[3]	
	if (value[2] < 0) then
        fact = 1
    end
else
    neq = "( " .. term[2] .. ") : x " .. sign[index] .. " " .. term[3]		
    if (value[1] * value[3] > 0) then	
        fact = 1
    end		
end
  	
if (fact == 1) then
    if (index < 3) then
        if (index == 1) then
            ind = 2
        else
            ind = 1
        end	
	else	
        if (index == 3) then
            ind = 4
        else
            ind = 3
		end	
    end		
else
 	ind = index 
end 

reply = "x " .. lib.check_one_option_dropdown(sign, sign[ind]) .. " " .. answ1 .. answ2

zero = 0
if (choice == 2) then
    if (value[1] < 0 ) then
	    if (ind == 2 or ind == 4) then
            reply = lib.check_number(0,20) .. " " .. lib.check_one_option_dropdown(sign, sign[2]) .. " " .. reply 	
            zero = 2
		end	
	else	
        if ( ind == 1 or ind == 3) then
            reply = lib.check_number(0,20) .. " " .. lib.check_one_option_dropdown(sign, sign[1]) .. " " .. reply
            zero = 1
	    end	
	end	
end	

step = 1
dist = 2 * step
leng = 2 * dist
part = denom[1] 	
first = whl[1] - dist
last =  whl[1] + dist
int = leng * part

if (ind < 3) then
    if (ind == 2) then
        results = "result[0] == 0 && result[1] == 1 && result[2] == 0" 
    else
        results = "result[0] == 1 && result[1] == 0 && result[2] == 0"	
    end
else
    if (ind == 4 ) then
        results = "result[0] == 0 && result[1] == 1 && result[2] == 1" 
    else
        results = "result[0] == 1 && result[1] == 0 && result[2] == 1"	
    end	
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
  
  if (zero == 1 and first <= 0 and last > 0) then
      if (whl[1] >= 0 and whl[1] <= 2 and sht >= 0) then      
          if (whl[1] == 2) then
              lib.add_straight_path(w, 2*ow, {{mark, 0}, {0, -ow}, {-mark, 0}, {0, ow} }, dif_style, false, true)  
	      else
              if (whl[1] == 1) then
	              mark = step*scale2 + sht*scale1 
                  lib.add_straight_path(w+step*scale2, 2*ow, {{mark, 0}, {0, -ow}, {-mark, 0}, {0, ow} }, dif_style, false, true)  
	          else       
	  	          mark =  sht*scale1 
                  lib.add_straight_path(w+dist*scale2, 2*ow, {{mark, 0}, {0, -ow}, {-mark, 0}, {0, ow} }, dif_style, false, true)
              end	
          end
      else
          lib.add_straight_path(w, 2*ow, {{mark, 0}, {0, -ow}, {-mark, 0}}, dif_style, false, true)
          lib.add_straight_path(w+8, ow-3, {{-8, 3}, {8, 3}}, style, false, false) 	  
      end
  else
      lib.add_straight_path(w, 2*ow, {{mark, 0}, {0, -ow}, {-mark, 0}}, dif_style, false, true)
      lib.add_straight_path(w+8, ow-3, {{-8, 3}, {8, 3}}, style, false, false) 
  end
  mark = dist*scale2 + sht*scale1 
  if (zero == 2 and first < 0 and last >= 0) then
      if (whl[1] <= 0 and whl[1] >= -2 and sht <= 0) then    
          if (whl[1] == -2) then
	              mark = -dist*scale2 + sht*scale1		  
              lib.add_straight_path(w + (leng-dist)*scale2, 2*ow, {{mark, 0}, {0, -2*v}, {-mark, 0}, {0, 2*v} }, dif_style, false, true)  
	      else
              if (whl[1] == -1) then
	              mark = -step*scale2 + sht*scale1 
                  lib.add_straight_path(w + (leng-step)*scale2, 2*ow, {{mark, 0}, {0, -2*v}, {-mark, 0}, {0, 2*v} }, dif_style, false, true)  
	          else 
	  	          mark =  sht*scale1 
                  lib.add_straight_path(w + leng*scale2, 2*ow, {{mark, 0}, {0, -2*v}, {-mark, 0}, {0, 2*v} }, dif_style, false, true)
              end
          end			  
      else  
	      lib.add_straight_path(w + leng*scale2, 2*ow, {{-leng*scale2+mark, 0}, {0, -2*v}, {leng*scale2-mark, 0}}, dif_style, false, true)
          lib.add_straight_path(w+leng*scale2-8, 2*(ow-v)-3, {{8, 3}, {-8, 3}}, style, false, false) 
      end
  else	  
      lib.add_straight_path(w + leng*scale2, 2*ow, {{-leng*scale2+mark, 0}, {0, -2*v}, {leng*scale2-mark, 0}}, dif_style, false, true)
      lib.add_straight_path(w+leng*scale2-8, 2*(ow-v)-3, {{8, 3}, {-8, 3}}, style, false, false) 
  end

  lib.add_straight_path(w, 2*ow, {{leng*scale2, 0}}, style, false, false)     
  
  for i = 2, int + 1 do 
      lib.add_straight_path(w+(i-1)*scale1, 2*ow, {{0, 5}, {0, -10}}, style, false, false)
  end 

  for i = 1, leng + 1 do 
      number = first + i - 1
      lib.add_straight_path(w+(i-1)*scale2, 2*ow, {{0, 10}, {0, -20}}, style, false, false)
      lib.add_input(2+(i-1)*scale2, 2*(ow+w)-ov, 40, 30, lib.check_number(number, 25))	  
  end

  mark = dist*scale2 + sht*scale1    
  lib.add_circle (w+mark, 2*ow, 4, dif_style, false, true)

  lib.end_canvas()
end     



  


  
