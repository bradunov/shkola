
max_range = 3
stampa = 5
nr = 1 + math.random(stampa - 1)
numb = math.random(max_range)

quest = ""
sum = 0
for i = 1,nr do
    sg = math.random(2)
    if (sg == 1) then
        numb = -numb
    end 
    grd = 1 + math.random(5)
    ch = math.random(2)	
	if (ch == 1) then
	    sum = sum + numb ^ grd
	    if (i == 1) then
	        sg = ""	   
	    else	   
	        sg = " + "
		end   
	else	  
	   sum = sum - numb ^ grd
	   sg = " - "	
	end   
    quest = quest .. sg .. " (" .. numb .. ") " .. "\(^" .. tostring(grd) .. "\)"
end
   
