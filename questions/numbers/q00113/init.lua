include("terms")

answer = {""}
answer_rand = {""}
value = {}
value_rand = {}
  
numb = 1 + math.random(8);

digit = ones[numb-1];
digit10 = tens[numb-1];

digit2 = digit
if (numb == 2) then
   digit2 = msg_two
end

if (numb < 5) then
    name_2 = msg_hundred[1]
	name_3 = msg_thousand[1]
else 
    name_2 = msg_hundred[2]
	name_3 = msg_thousand[2]	
end	


value[1] = numb*10000 + numb;
answer[1] = digit10 .. " " .. msg_thousand[2] .. " " .. digit2

value[2] = numb*10000 + numb*10;
answer[2] = digit10 .. " " .. msg_thousand[2] .. " " .. digit10 
		
value[3] = numb*10000 + numb*10 + numb;
answer[3] = digit10 .. " " .. msg_thousand[2] .. " " .. digit10 .. " " .. digit2
	
value[4] = numb*10000 + numb*100;
answer[4] = digit10 .. " " .. msg_thousand[2] .. " " .. digit .. " " .. name_2

value[5] = numb*10000 + numb*1000 + numb*100 + numb;
answer[5] = digit10 .. " " .. digit .. " " .. name_3 .. " " .. digit .. " " .. name_2 .. " " .. digit2 

value[6] = numb*10000 + numb*100 + numb*10;
answer[6] = digit10 .. " " .. msg_thousand[2] .. " " .. digit .. " " .. name_2 .. " " .. digit10	         		                     

temp = {1,2,3,4,5,6}
out = lib.math.random_shuffle(temp)  

for i = 1,6 do
	value_rand[i] = value[out[i]]
	answer_rand[i] = answer[out[i]]
end	
     			  
