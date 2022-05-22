
numb = 1 + math.random(8)
grd = 1 + math.random(13-numb)
ch = math.random(2)

if (ch == 1) then 
    base = -numb
else
    base = numb
end	
value = base
for i = 2, grd do
    value = value * base
end	       
                   