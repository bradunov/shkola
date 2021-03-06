
answ = {"=", "<", ">"}

measure = {"mm","cm","dm","m", "km"}
index = {1,2,3,4,5}
ind = lib.math.random_shuffle(index)

if (ind[1] == 5 or ind[2] == 5) then
    ind[1] = 5
    ind[2] = 4
    numleft = 1
    numright = 600 + math.random(600)
    factleft = 1000
    factright = 1
else
    if (ind[1] < ind[2]) then 
        factleft = 1
        factright = 10^(ind[2]-ind[1])
    else
        factleft = 10^(ind[1]-ind[2])
        factright = 1
    end	
 
    minleft = 101-25*ind[1]
    if (ind[1] == 4) then
        maxleft = 5
    else
        maxleft = 10^(4-ind[1])
    end
    numleft = math.random(maxleft) + minleft  

    minright = 101-25*ind[2]
    if (ind[2] == 4) then
        maxright = 5
    else
        maxright = 10^(4-ind[2])
    end
    numright = math.random(maxright) + minright   
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
      
        