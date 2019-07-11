deo = ITEM+1
put = 600*deo/(deo-1)
put1 = put/deo
put2 = put - put1


imenilac = 1000
brojilac = put
putkm = put/imenilac

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(putkm)..");"       

index_ime = math.random(#niz_ime);    
ime = niz_ime[index_ime];                   
padez = niz_padez[index_ime];                  
