
include("terms")
value = {}
  
numb = 1 + math.random(8);

digit = ones[numb-1];
digit10 = tens[numb-1];

digit_L = ones_L[numb-1];
digit10_L = tens_L[numb-1];

digit2 = digit
digit2_L = digit_L
if (numb == 2) then
   digit2 = msg_two
   digit2_L = msg_two
end

if (numb < 5) then
    name_2 = msg_hundred
	name_3 = msg_thousand[1]
else 
    name_2 = msg_hundred
	name_3 = msg_thousand[2]	
end	

value[1] = numb*10000 + numb;
value[2] = numb*10000 + numb*10;		
value[3] = numb*10000 + numb*10 + numb;
value[4] = numb*10000 + numb*100;
value[5] = numb*10000 + numb*1000 + numb*100 + numb;
value[6] = numb*10000 + numb*100 + numb*10;

	
            
    			  
