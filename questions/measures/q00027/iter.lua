
answ = {"=", "<", ">"}

measure = {"mm²", "cm²", "dm²", "m²"}
index = {1,2,3,4}
ind = lib.math.random_shuffle(index)

if(ind[1] < ind[2]) then
   inddif = ind[2] - ind[1]
else
   inddif = ind[1] - ind[2]
end

temp = 100^inddif

if (ind[1] < ind[2]) then 
    factleft = 1
    factright = temp
    numleft = temp + math.random(50*temp)
    numright = math.random(50)
else
    factleft = temp
    factright = 1
    numleft = math.random(50)
    numright = temp + math.random(50*temp)
end		
 
valueleft = factleft * numleft
valueright = factright * numright

if (valueleft == valueright) then
   sign = "="
else
  if (valueleft > valueright) then
      sign = ">"
  else
      sign = "<"
  end
end
 