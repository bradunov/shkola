
measure1 = {"m", "kg" , "t", "km", "l"}
measure2 = {"cm", "g", "kg", "m", "cl"}

rel = {100, 1000, 1000, 1000, 100}

denom = {2,5,10}
index = math.random(3)
imenilac = denom[index]
brojilac = math.random(imenilac-1)

res_dec = brojilac / imenilac
result = rel[ITEM] * res_dec
                  
condition = "is_ok = (numerator/denominator == " ..tostring(res_dec) .. ")"				  
solution = "numerator="..tostring(brojilac)..";denominator="..tostring(imenilac)..";"
