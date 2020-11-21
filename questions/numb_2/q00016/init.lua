
include("names")

r = math.random(#musko_ime_nom)
imem = musko_ime_nom[r] 

r = math.random(#zensko_ime_nom)
imez = zensko_ime_nom[r] 

answ = {""}
out = {""}

number1 = 10 + math.random(39)
number2 = 50 + math.random(39) 

factor = 50 + math.random(449)

prod1 = number1 * factor
prod2 = number2 * factor
result = prod1 + prod2

sign = "*"               
out[1] = tostring(math.floor(number1)) .. " " .. sign .. " x " .. " + " .. tostring(math.floor(number2)) .. " " .. sign .. " x " .. " = " .. tostring(math.floor(result))
out[2] = tostring(math.floor(number1)) .. " " .. sign .. " (x " .. " + " .. tostring(math.floor(number2)) .. ") = " .. tostring(math.floor(result))               
out[3] = "(" .. tostring(math.floor(number1)) .. " + x) " .. sign .. " " .. tostring(math.floor(number2)) .. " = " .. tostring(math.floor(result))                
out[4] = tostring(math.floor(number1)) .. " " .. sign .. " " .. tostring(math.floor(number2)) .. " " .. sign .. " x " .. " = " .. tostring(math.floor(result))

index = {1, 2, 3, 4} 
q = {}                         
q = lib.math.random_shuffle(index)     

for i = 1,4 do  
    answ[i] = out[q[i]]
    if ( q[i] == 1) then 
        ind = i - 1
    end
end	
   
                                                        
       
            
       