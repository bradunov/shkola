 
include("terms") 

brac = {"\(\big ( \)", "\(\big ) \)"}

sifra = {}
out = {}

max_range = 5

nr = 0
for i = 1,5 do
    jmax = 4
    if (i == 5) then
        jmax = 2
	end	
    for j = 1,jmax do
	    nr = nr + 1
	    sifra[nr] = 10 * i + j
    end
end	

out = lib.math.random_shuffle(sifra)            
       
                
            
