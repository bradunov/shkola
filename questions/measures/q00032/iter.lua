
measure2 = {"mm²", "cm²", "dm²", "m²"} 
measure = {"mm","cm","dm","m"}


indl = 1 + math.random(3)
indr = math.random(indl-1)

factor = 100^(indl-indr)

numleft = math.random(99)
numright = numleft * factor	            

index = math.random(2)

if (index == 2) then
    temp = numleft
    numleft = numright
    numright = temp
    temp = indl
    indl = indr
    indr = temp
end	
   
