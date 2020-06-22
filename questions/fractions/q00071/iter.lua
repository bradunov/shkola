
measure1 = {"m", "kg" , "t", "km", "l"}
measure2 = {"cm", "g", "kg", "m", "cl"}

rel = {100, 1000, 1000, 1000, 100}

imenilac = rel[ITEM]
brojilac = 10 + math.random(89)

if (ITEM > 1 and ITEM < 5) then 
    brojilac = brojilac * 10
end	

res_dec = brojilac / imenilac
result = brojilac
                  
condition = "is_ok = (numerator/denominator == " ..tostring(res_dec) .. ")"				  
solution = "numerator="..tostring(brojilac)..";denominator="..tostring(imenilac)..";"

   