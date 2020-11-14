
include("names")

r = math.random(#zensko_ime_nom)
ime = zensko_ime_nom[r] 

glass = {200, 250}
ind = math.random(2)

if (ind == 1) then
   temp = 5 
else
   temp = 4
end

number = 4+ math.random(6);

value = number * temp
                  
q = math.floor(value/10)
rest = value - 10*q
mes = "čaša"

if (q ~= 1) then
    if (rest == 1) then
        mes = "čašu"
    end  
    if (rest > 1 and rest < 5) then
        mes = "čaše"
    end	
end	









  

     