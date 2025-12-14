
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"}

number = {}
numb = {}
dec = {}
dig = {}
answ = {""}
out = {""}

value = {}
mult  = {}
res = {""}
index = {}
 
number[1] = 1 + math.random(8);
number[2] = 10 + math.random(8);

dec[1] = math.random(3) - 1
if (dec[1] == 2) then
    dec[2] = 0
else	
	dec[2] = math.random(2 - dec[1])
end

decad = dec[1] + dec[2]
val = number[1] * number[2]
dig[1] = math.floor(val/10)
dig[2] = lib.math.round(val - 10*dig[1])
if (val > 100) then
	dig[3] = val - 100* math.floor(val/100)	
	dig[4] = math.floor(dig[3]/10)		
end	

if (dig[2] == 0) then
	number[2] = number[2] + 1
	val = number[1] * number[2]
	dig[1] = math.floor(val/10)
	dig[2] = lib.math.round(val - 10*dig[1])
end
numb[1] = number[1] * 10^dec[1]
numb[2] = number[2] * 10^dec[2]
prod = val * 10^decad

reply = ""
if (decad == 2) then
	if (dig[1] < 10) then	
		if (dig[1] > 4 ) then
			name = msg_thousand[1]
		else 
			name = msg_thousand[2]	
		end		
		reply = ones[dig[1]] .. " " .. name
	else
		if (dig[1] > 10) then
			reply = twents[dig[1]-10] .. " " .. msg_thousand[1]
		else
			reply = tens[1] .. " " .. msg_thousand[1]
		end
	end	
else
	if (dig[1] < 10) then			
		reply = hund[dig[1]]
	else
		if (dig[1] > 10) then
			reply = ones[1] .. " " .. msg_thousand[1] .. " " .. hund[dig[4]]
		else
			reply = ones[1] .. " " .. msg_thousand[1] 
		end	

	end
end	

if (dig[2] <= 2) then
	digit2 = msg_two[dig[2]]
else
   digit2 = ones[dig[2]]   
end

if (decad == 2) then
	reply = reply .. " " .. hund[dig[2]];
else
	reply = reply .. " " .. tens[dig[2]];
end	

if (dig[1] < 10) then
    arg = dig[1]
	if (dig[1] > 4 ) then
		name = msg_thousand[1]
	else 
		name = msg_thousand[2]	
	end	
	answ[1] = ones[arg] .. " " .. name .. " " .. digit2;
	answ[2] = ones[arg] .. " " .. name .. " " .. tens[dig[2]];	
	answ[3] = ones[arg] .. " " .. name .. " " .. hund[dig[2]];	
	answ[4] = hund[arg] .. " " .. digit2;	
	answ[5] = hund[arg] .. " " .. tens[dig[2]];		
else
	if (dig[1] > 10) then
		arg = dig[1]-10
		if (decad == 2 ) then
			answ[1] = twents[arg] .. " " .. msg_thousand[1] .. " " .. digit2;	
			answ[2] = twents[arg] .. " " .. msg_thousand[1] .. " " .. tens[dig[2]];
			answ[3] = twents[arg] .. " " .. msg_thousand[1] .. " " .. hund[dig[2]];			
			answ[4] = tens[1] .. " " .. msg_thousand[1] .. " " .. hund[dig[4]] .. " " .. digit2;	
			answ[5] = tens[1] .. " " .. msg_thousand[1] .. " " .. hund[dig[4]] .. " " .. tens[dig[2]];
		else
			answ[1] = twents[arg] .. " " .. msg_thousand[1] .. " " .. digit2;	
			answ[2] = twents[arg] .. " " .. msg_thousand[1] .. " " .. tens[dig[2]];
			answ[3] = twents[arg] .. " " .. msg_thousand[1] .. " " .. hund[dig[2]];			
			answ[4] = ones[1] .. " " .. msg_thousand[1] .. " " .. hund[dig[4]] .. " " .. digit2;	
			answ[5] = ones[1] .. " " .. msg_thousand[1] .. " " .. hund[dig[4]] .. " " .. tens[dig[2]];		
	    end
	else
		if (decad == 2) then	
			answ[1] = tens[1] .. " " .. msg_thousand[1] .. " " .. digit2;
			answ[2] = tens[1] .. " " .. msg_thousand[1] .. " " .. tens[dig[2]];	
			answ[3] = tens[1] .. " " .. msg_thousand[1] .. " " .. hund[dig[2]];
			answ[4] = hund[1] .. " " .. digit2;	
			answ[5] = tens[1] .. " " .. msg_thousand[1] .. " " .. twents[dig[2]];
			
		else
			answ[1] = tens[1] .. " " .. msg_thousand[1] .. " " .. tens[dig[2]];	
			answ[2] = tens[1] .. " " .. msg_thousand[1] .. " " .. hund[dig[2]];		
			answ[3] = ones[1] .. " " .. msg_thousand[1] .. " " .. digit2;	
			answ[4] = ones[1] .. " " .. msg_thousand[1] .. " " .. tens[dig[2]];
			answ[5] = ones[1] .. " " .. msg_thousand[1] .. " " .. hund[dig[2]];		
        end			
    end		
end

out = lib.math.random_shuffle(answ)

if (dec[1] == 2) then
	ch = 1
else
	if (dec[2] == 2) then
		ch = 2
	else 
		ch = 3
	end
end	          
      
if (ch < 3) then 
	value[1] = number[1] * 10;
	value[2] = number[2] * 10;	
	if (ch == 1) then
		value[3] = number[1];
		value[4] = number[2] * 100;		
		value[11] = number[1] * 50;
		value[12] = number[2] * 2;		
		value[13] = number[1] * 25;
		value[14] = number[2] * 4;				
	else
		value[3] = number[1] * 100;
		value[4] = number[2];
		value[11] = number[1] * 2;
		value[12] = number[2] * 50;	
		value[13] = number[1] * 4;
		value[14] = number[2] * 25;			
	end
	value[5] = number[1];
	value[6] = number[2] * 10;
	value[7] = number[1] * 10;
	value[8] = number[2];
	value[9] = number[1];
	value[10] = number[2];
else
	value[1] = number[1];
	value[2] = number[2] * 100;	
	value[3] = number[1] * 100;
	value[4] = number[2];	
	value[11] = number[1] * 5;
	value[12] = number[2] * 20;	
	value[13] = number[1] * 2;
	value[14] = number[2] * 5;		
	if (decad == 1) then	
		if (dec[1] == 1) then
			value[5] = number[1];
			value[6] = number[2] * 10;
		else
			value[5] = number[1] * 10;
			value[6] = number[2];	
		end
	else
		value[5] = number[1];
		value[6] = number[2] * 10;
	end
	value[7] = number[1] * 5;
	value[8] = number[2] * 2;
	value[9] = number[1];
	value[10] = number[2];
end
            
for i = 1,7 do
	index[i] = i 
	mult[i] = value[2*i-1] * value[2*i]
	res[i] = tostring(value[2*i-1]) .. " * " .. tostring(value[2*i])
end
index = lib.math.random_shuffle(index)  

results = ""

  for i = 1, 6 do
      if i > 1 then
         results = results .. " && "
      end
      results = results .. "result[" .. tostring(i-1) .. "] == "
      if (mult[index[i]] == prod ) then
          results = results .. "1"
      else
          results = results .. "0"
      end	
  end          
            
 mycanvas = function(no) 

 lib.start_canvas(280, 130, "center", results)
 
    w = 40
    ow = 50
    v = 5
	
	for i = 1,3 do
	    lib.add_input((i-1)*2*ow, 2*v, 100, 30, res[index[i]])
		lib.add_circle (ow+(i-1)*2*ow, w, 5, style, false, true)
	end
 	for i = 4,6 do
	    lib.add_input((i-4)*2*ow, 2*w, 100, 30, res[index[i]])
		lib.add_circle (ow+(i-4)*2*ow, 3*w-v, 5, style, false, true)
	end 

    lib.end_canvas()
end      