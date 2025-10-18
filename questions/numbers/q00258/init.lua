
include("terms")

value = {}
answ = {""}
index = {}
out = {""}
temp = {}

for i = 1,14 do
	index[i] = i
end
index = lib.math.random_shuffle(index)	
ind = index[1] 
 
numb = 1 + math.random(8);

digit = ones[numb-1];
digit10 = tens[numb-1];
digit100 = hund[numb-1];
digit2 = digit
if (numb == 2) then
   digit2 = msg_two
end
if (numb < 5) then
	name_3 = msg_thousand[1]
else 
	name_3 = msg_thousand[2]	
end	

value[1] = numb*10000 + numb;
value[2] = numb*10000 + numb*10;	
value[3] = numb*10000 + numb*100;	
value[4] = numb*10000 + numb*10 + numb;
value[5] = numb*10000 + numb*100 + numb;
value[6] = numb*10000 + numb*100 + numb*10;
value[7] = numb*10000 + numb*100 + numb*10 + numb;		
answ[1] = digit10 .. " " .. msg_thousand[2] .. " + " .. digit2;
answ[2] = digit10 .. " " .. msg_thousand[2] .. " + " .. digit10;
answ[3] = digit10 .. " " .. msg_thousand[2] .. " + " .. digit100;	
answ[4] = digit10 .. " " .. msg_thousand[2] .. " + " .. digit10 .. " + " .. digit2;	
answ[5] = digit10 .. " " .. msg_thousand[2] .. " + " .. digit100 .. " + " .. digit2;
answ[6] = digit10 .. " " .. msg_thousand[2] .. " + " .. digit100 .. " + " .. digit10; 
answ[7] = digit10 .. " " .. msg_thousand[2] .. " + " .. digit100 .. " + " .. digit10 .. " + " .. digit2; 

value[8] = numb*10000 + numb*1000 + numb;
value[9] = numb*10000 + numb*1000 + numb*10;	
value[10] = numb*10000 + numb*1000 + numb*100;	
value[11] = numb*10000 + numb*1000 + numb*10 + numb;
value[12] = numb*10000 + numb*1000 + numb*100 + numb;
value[13] = numb*10000 + numb*1000 + numb*100 + numb*10;
value[14] = numb*10000 + numb*1000  + numb*100 + numb*10 + numb;	
for i = 8,14 do
	if (lang == 2) then
		answ[i] = digit2 .. "in" .. digit10 .. " " .. name_3
	else
		answ[i] = digit10 .. " " .. digit .. " " .. name_3		
	end
end
answ[8] = answ[8] .. " + " .. digit2;
answ[9] = answ[9] .. " + " .. digit10;
answ[10] = answ[10] .. " + " .. digit100;	
answ[11] = answ[11] .. " + " .. digit10 .. " + " .. digit2;
answ[12] = answ[12] .. " + " .. digit100 .. " + " .. digit2;
answ[13] = answ[13] .. " + " .. digit100 .. " + " .. digit10; 
answ[14] = answ[14] .. " + " .. digit100 .. " + " .. digit10  .. " + " .. digit2; 

for i = 1, 6 do
    temp[i] = index[i]
end		
temp = lib.math.random_shuffle(temp)
for i = 1, 6 do
    out[i] = answ[temp[i]]
end	  
     