
include("terms")

hund = math.random(9) ; 
ten = math.random(9);
unit = math.random(10) - 1;
numb_r = hund* 100 + ten * 10 + unit 

sign =  math.random(2)
diff = 2 + math.random(7)
if (sign == 1 ) then 
   znak = "<"
   numb_l = numb_r - diff
else
   znak = ">"
   numb_l = numb_r + diff
end                    

cifre = {}
cifre[1] =  math.floor(numb_l/100)
temp = numb_l - 100 * cifre[1]
cifre[2] = math.floor(temp/10)
cifre[3] = temp - 10 * cifre[2]
       
dec = math.random(3)                         
number = numb_r / 10^dec

answ = ""
if(dec == 1) then
   answ = tostring(cifre[1]) .. lib.check_number(cifre[2], 15) .. point .. tostring(cifre[3])
end
if(dec == 2) then
   answ = tostring(cifre[1]) .. point .. lib.check_number(cifre[2], 15) .. tostring(cifre[3])
end
if(dec == 3) then
   answ = "0" .. point .. tostring(cifre[1]) .. lib.check_number(cifre[2], 15) .. tostring(cifre[3])
end 
