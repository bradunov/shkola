 
include("terms") 

rel = {" < ", " > ", " ≤ ", " ≥ "}			

sifra = {}
out = {}

max_range = 5

nr = 0
for i = 1,4 do
    for j = 1,4 do
	    nr = nr + 1
	    sifra[nr] = 10 * i + j
    end
end	

out = lib.math.random_shuffle(sifra)                  
