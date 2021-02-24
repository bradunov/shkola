
include("names")

index_ime = math.random(#musko_ime_nom);    
ime = musko_ime_nom[index_ime];                   
padez = musko_pridev[index_ime];

reply = {""}
out = {""}
test = {}
qq = {}

deo = 5 + math.random(13);
deo1 = 1 + math.random(deo - 4)
deo2 = deo - deo1
temp = (math.random(10)) * 35;
put = temp * deo;
put1 = temp * deo1
put2 = temp * deo2

out[1] = "(1 - \(\frac{" .. deo1 .. "}{" .. deo .. "}\)) x = " .. put2
out[2] = "\(\frac{" .. deo1 .. "}{" .. deo .. "}\) x = " .. put2 
out[3] = "x : \(\frac{" .. deo1 .. "}{" .. deo .. "}\) = " .. put2
out[4] = "\(\frac{" .. deo1 .. "}{" .. deo .. "}\) x - 1 = " .. put2
out[5] = "x - \(\frac{" .. deo1 .. "}{" .. deo .. "}\) = " .. put2

test = {1,2,3,4,5}
qq = lib.math.random_shuffle(test)
for i = 1,5 do
    reply[i] = out[qq[i]]
	if (qq[i] == 1) then
	    ind = i - 1
	end
end	

putkm = lib.math.round_dec(put/1000,3)
       