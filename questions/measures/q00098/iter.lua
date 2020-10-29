
measure = {"m","dm","cm"}
numb = {}

indr = 1 + math.random(2)
indl = indr-1

numb[1] = math.random(9) 
numb[2] = math.random(10) - 1 	
valueleft = numb[1] * 10 + numb[2]
valueright = 10 + math.random(89)
    
answ = ""

mes = measure[indl]
for i = 1,2 do
    if (numb[i] ~= 0) then    
        answ = answ .. " " .. tostring(math.floor(numb[i])) .. mes
    end
    mes = measure[indr]
end	                                                       

if (valueleft == valueright) then
   sign = "="
else
  if (valueleft > valueright) then
      sign = ">"
  else
      sign = "<"
  end
end
      