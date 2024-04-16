
measure = {"mm²", "cm²", "dm²", "m²"}

indl = 1 + math.random(3)
indr = math.random(indl-1)

factor = 100^(indl-indr)

numleft = math.random(99)
numright = numleft * factor	            
