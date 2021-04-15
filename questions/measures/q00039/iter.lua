
answ = {"=", "<", ">"}

measure = {"cm","dm","m"}
ind = {}

ind[1] = math.random(3)
if (ind[1] == 1 or ind[1] == 3) then
    ind[2] = 2
else
    sign = math.random(2)
    if (sign == 1) then
       ind[2] = 1
    else
       ind[2] = 3
    end
end       

if (ind[1] < ind[2]) then 
    temp = ind[2]-ind[1]
	factleft = 1
    factright = 10^temp
	numleft = math.random(100) * 10^(temp-1)
	numright = math.random(10)
else
    temp = ind[1]-ind[2]
    factleft = 10^temp
    factright = 1
	numleft = math.random(10) 
	numright = math.random(100) * 10^(temp-1)	
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
 