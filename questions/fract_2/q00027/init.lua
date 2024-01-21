
include("terms")

answer = {""}
answer_rand = {""}
value = {}
value_rand = {}
  
numb = 1 + math.random(8);

digit = ones[numb-1];
digit10 = tens[numb-1];

if (numb < 5) then
    name_1 = msg_one[1]
	name_2 = msg_ten[1]
    name_3 = msg_hundred[1]
	name_4 = msg_thousand[1]
else 
    name_1 = msg_one[2]
	name_2 = msg_ten[2]
    name_3 = msg_hundred[2]
	name_4 = msg_thousand[2]
end	


value[1] = numb + numb/1000;
answer[1] = digit .. " " .. name_1 .. ad .. digit .. " " .. name_4

value[2] = numb + numb/100;
answer[2] = digit .. " " .. name_1 .. ad .. digit .. " " .. name_3 

value[3] = numb + numb/10;
answer[3] = digit .. " " .. name_1 .. ad .. digit .. " " .. name_2
		
value[4] = numb + numb/100 + numb/1000;
ind = math.random(2)
if (ind == 1) then
   answer[4] = digit .. " " .. name_1 .. ", " .. digit .. " " .. name_3 .. ad .. digit .. " " .. name_4
else
   answer[4] = digit .. " " .. name_1 .. ad .. digit10 .. " " .. name_4 
end   
   	
value[5] = numb + numb/10 + numb/1000;
answer[5] = digit .. " " .. name_1 .. ", " .. digit .. " " .. name_2 .. ad .. digit .. " " .. name_4        		                     

value[6] = numb + numb/10 + numb/100;
ind = math.random(2)ind = math.random(2)
if (ind == 1) then
   answer[6] = digit .. " " .. name_1 .. ", " .. digit .. " " .. name_2 .. ad .. digit .. " " .. name_3 
else
   answer[6] = digit .. " " .. name_1 .. ad .. digit10 .. " " .. name_3 
end   

value[7] = numb + numb/10 + numb/100 + numb/1000;
answer[7] = digit .. " " .. name_1 .. ", " .. digit .. " " .. name_2 .. ", " .. digit .. " " .. name_3 .. ad .. digit .. " " .. name_4 

value[8] = numb/1000;
answer[8] = digit .. " " .. name_4 

value[9] = numb/100;
answer[9] = digit .. " " .. name_3 

value[10] = numb/10;
answer[10] = digit .. " " .. name_2
		
value[11] = numb/100 + numb/1000;
ind = math.random(2)
if (ind == 1) then
   answer[11] = digit .. " " .. name_3 .. ad .. digit .. " " .. name_4
else
   answer[11] = digit10 .. " " .. name_4
end 
	
value[12] = numb/10 + numb/1000;
answer[12] = digit .. " " .. name_2 .. ad .. digit .. " " .. name_4         		                     

value[13] = numb/10 + numb/100;
ind = math.random(2)
if (ind == 1) then
   answer[13] = digit .. " " .. name_2 .. ad .. digit .. " " .. name_3 
else
   answer[13] = digit10 .. " " .. name_3
end 


temp = {1,2,3,4,5,6,7,8,9,10,11,12,13}
out = lib.math.random_shuffle(temp)  

for i = 1,6 do
	value_rand[i] = lib.math.round_dec(value[out[i]],3)
	answer_rand[i] = answer[out[i]]
end	
