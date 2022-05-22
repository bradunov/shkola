
letter = {"a", "b", "c", "m", "n", "p", "x", "y", "z"}

stampa = 6
numb = 1 + math.random(9)
grd = 1 + math.random(stampa-1)

ch = math.random(2)
if (ch == 1) then
    base = tostring(numb)
else	
    base = letter[numb-1]
end	

answ = lib.check_string(base,15)
for i = 2, stampa do
    if (i > grd) then
        reply = ""
	else
        reply = base
    end		
    answ = answ .. " * " .. lib.check_string(reply,15) 
end	    
            

