
include("names")
include("terms")

index_ime = math.random(#zensko_ime_nom);    
name = zensko_ime_nom[index_ime]; 
advb = zensko_pridev[index_ime];  

number = 12

max3 = math.floor(number/3)
numb3 = math.random(max3)
max4 = math.floor(number/2)
numb4 = math.random(max4)

numb5 = number - numb3 - numb4

aver = (3 * numb3 + 4 * numb4 + 5 * numb5)/number
aver = lib.math.round_dec(aver, 2)

if (numb3 == 1) then
    pad3 = msg1[1]
else 
    if (numb3 < 5) then 
        pad3 = msg2[1]	
	else
	    pad3 = msg5[1]
	end
end

if (numb4 == 1) then
    pad4 = msg1[2]
else 
    if (numb4 < 5) then 
        pad4 = msg2[2]	
	else
	    pad4 = msg5[2]
	end
end

if (numb5 == 1) then
    pad5 = msg1[3]
else 
    if (numb5 < 5) then 
        pad5 = msg2[3]	
	else
	    pad5 = msg5[3]
	end
end                   

            