ones = {"dve", "tri", "četiri", "pet", "šest", "sedam", "osam", "devet"}
tens = {"dvadeset", "trideset", "četrdeset", "pedeset", "šezdeset", "sedamdeset", "osamdeset", "devedeset"}
ones_L = {"dve", "tri", "cetiri", "pet", "sest", "sedam", "osam", "devet"}
tens_L = {"dvadeset", "trideset", "cetrdeset", "pedeset", "sezdeset", "sedamdeset", "osamdeset", "devedeset"}

value = {}
  
numb = 1 + math.random(8);

digit = ones[numb-1];
digit10 = tens[numb-1];

digit_L = ones_L[numb-1];
digit10_L = tens_L[numb-1];

digit2 = digit
digit2_L = digit_L
if (numb == 2) then
   digit2 = "dva"
   digit2_L = "dva"
end

if (numb < 5) then
    name_2 = "stotine"
	name_3 = "hiljade"
else 
    name_2 = "stotina"
	name_3 = "hiljada"	
end	

value[1] = numb*10000 + numb;
value[2] = numb*10000 + numb*10;		
value[3] = numb*10000 + numb*10 + numb;
value[4] = numb*10000 + numb*100;
value[5] = numb*10000 + numb*1000 + numb*100 + numb;
value[6] = numb*10000 + numb*100 + numb*10;

	
            
    			  
