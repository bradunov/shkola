
include("terms")

ans = {""}
ans_rand = {""}
value = {}
value_rand = {}
reply = {""}
reply_rand = {""}
  
numb = 1 + math.random(8);

digit = ones[numb-1];
digit_L = ones_L[numb-1];


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
reply[1] = "answer == '" .. digit .. " " .. name_1 .. " i " .. digit .. " " .. name_4 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_1 .. " i " .. digit_L .. " " .. name_4 .. "'" ;
ans[1] = "answer = '" .. digit .. " " .. name_1 .. " i " .. digit .. " " .. name_4 .. "' ";

value[2] = numb + numb/100;
reply[2] = "answer == '" .. digit .. " " .. name_1 .. " i " .. digit .. " " .. name_3 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_1 .. " i " .. digit_L .. " " .. name_3 .. "'" ;
ans[2] = "answer = '" .. digit .. " " .. name_1 .. " i " .. digit .. " " .. name_3 .. "' "; 

value[3] = numb + numb/10;
reply[3] = "answer == '" .. digit .. " " .. name_1 .. " i " .. digit .. " " .. name_2 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_1 .. " i " .. digit_L .. " " .. name_2 .. "'";
ans[3] = "answer = '" .. digit .. " " .. name_1 .. " i " .. digit .. " " .. name_2 .. "' ";
		
value[4] = numb + numb/100 + numb/1000;
reply[4] = "answer == '" .. digit .. " " .. name_1 .. ", " .. digit .. " " .. name_3 .. " i " .. digit .. " " .. name_4 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_1 .. ", " .. digit_L .. " " .. name_3 .. " i " .. digit_L .. " " .. name_4 .. "'";
ans[4] = "answer = '" .. digit .. " " .. name_1 .. ", " .. digit .. " " .. name_3 .. " i " .. digit .. " " .. name_4 .. "' ";
   	
value[5] = numb + numb/10 + numb/1000;
reply[5] = "answer == '" .. digit .. " " .. name_1 .. ", " .. digit .. " " .. name_2 .. " i " .. digit .. " " .. name_4 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_1 .. ", " .. digit_L .. " " .. name_2 .. " i " .. digit_L .. " " .. name_4 .. "'";
ans[5] = "answer = '" .. digit .. " " .. name_1 .. ", " .. digit .. " " .. name_2 .. " i " .. digit .. " " .. name_4 .. "' ";        		                     

value[6] = numb + numb/10 + numb/100;
reply[6] = "answer == '" .. digit .. " " .. name_1 .. ", " .. digit .. " " .. name_2 .. " i " .. digit .. " " .. name_3 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_1 .. ", " .. digit_L .. " " .. name_2 .. " i " .. digit_L .. " " .. name_3 .. "'";
ans[6] = "answer = '" .. digit .. " " .. name_1 .. ", " .. digit .. " " .. name_2 .. " i " .. digit .. " " .. name_3 .. "' ";   

value[7] = numb + numb/10 + numb/100 + numb/1000;
reply[7] = "answer == '" .. digit .. " " .. name_1 .. ", " .. digit .. " " .. name_2 .. ", " .. digit .. " " .. name_3 .. " i " .. digit .. " " .. name_4 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_1 .. ", " .. digit_L .. " " .. name_2 .. ", " .. digit_L .. " " .. name_3 .. " i " .. digit_L .. " " .. name_4 .. "'";
ans[7] = "answer = '" .. digit .. " " .. name_1 .. ", " .. digit .. " " .. name_2 .. ", " .. digit .. " " .. name_3 .. " i " .. digit .. " " .. name_4 .. "' "; 

value[8] = numb/1000;
reply[8] = "answer == '" .. digit .. " " .. name_4 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_4 .. "'";
ans[8] = "answer = '" .. digit .. " " .. name_4 .. "' "; 

value[9] = numb/100;
reply[9] = "answer == '" .. digit .. " " .. name_3 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_3 .. "'";
ans[9] = "answer = '" .. digit .. " " .. name_3 .. "' "; 

value[10] = numb/10;
reply[10] = "answer == '" .. digit .. " " .. name_2 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_2 .. "'";
ans[10] = "answer = '" .. digit .. " " .. name_2 .. "' ";
		
value[11] = numb/100 + numb/1000;
reply[11] = "answer == '" .. digit .. " " .. name_3 .. " i " .. digit .. " " .. name_4 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_3 .. " i " .. digit .. " " .. name_4 .. "'";
ans[11] = "answer = '" .. digit .. " " .. name_3 .. " i " .. digit .. " " .. name_4 .. "' ";
	
value[12] = numb/10 + numb/1000;
reply[12] = "answer == '" .. digit .. " " .. name_2 .. " i " .. digit .. " " .. name_4 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_2 .. " i " .. digit_L .. " " .. name_4 .. "'";
ans[12] = "answer = '" .. digit .. " " .. name_2 .. " i " .. digit .. " " .. name_4 .. "' ";         		                     

value[13] = numb/10 + numb/100;
reply[13] = "answer == '" .. digit .. " " .. name_2 .. " i " .. digit .. " " .. name_3 .. "' " .. 
          "|| answer == '" .. digit_L .. " " .. name_2 .. " i " .. digit_L .. " " .. name_3 .. "'";
ans[13] = "answer = '" .. digit .. " " .. name_2 .. " i " .. digit .. " " .. name_3 .. "' "; 

temp = {1,2,3,4,5,6,7,8,9,10,11,12,13}
out = lib.math.random_shuffle(temp)  

for i = 1,6 do
    temp = lib.math.round(value[out[i]]*1000)
    value_rand[i] = temp/1000	
	reply_rand[i] = reply[out[i]]	
	ans_rand[i] = ans[out[i]]
end
