design = math.random(2)

factor1 = math.random(8) + 1
factor2 = math.random(9)

if (design == 1) then
	ladd1 = factor1 * 10
	ladd2 = factor2
else
	ladd1 = factor2
	ladd2 = factor1 * 10
end
leftsumm = ladd1 + ladd2

factor3 = math.random(8) + 1
factor4 = math.random(9)

if (design == 2) then
	dadd1 = factor3 * 10
	dadd2 = factor4
else
	dadd1 = factor3
	dadd2 = factor4 * 10
end
rightsumm = dadd1 + dadd2

sign = "="   
if (leftsumm > rightsumm) then sign = ">"	
end
if (leftsumm < rightsumm) then sign = "<"
end
                  
                  

                  
                  

                                  
