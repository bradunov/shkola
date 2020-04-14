measure = {"cm","dm","m"}
index = {1,2,3}
ind = lib.math.random_shuffle(index)

if (ind[1] < ind[2]) then 
    temp = ind[2]-ind[1]
	factleft = 1
    factright = 10^temp
	numleft = math.random(9) * 10^(temp-1)
	numright = math.random(9)
else
    temp = ind[1]-ind[2]
    factleft = 10^temp
    factright = 1
	numleft = math.random(9) 
	numright = math.random(9) * 10^(temp-1)	
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
 