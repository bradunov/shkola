
include("terms")
include("names")

index_m = math.random(#musko_ime_nom);    
mnam = musko_ime_nom[index_m];  
mdativ = musko_ime_dativ[index_m];                 
mpridev = musko_mpridev[index_m];

index_f = math.random(#zensko_ime_nom);    
fnam = zensko_ime_nom[index_f];                   
fdativ = zensko_ime_dativ[index_f];
fgen = zensko_ime_gen[index_f];

factor = {}
answ = {""}
qq = {}
out = {}
reply = {""}

ind = math.random(2)
tmp = 500 * (1 + math.random(5))
if (dec == 0) then
	tmp = lib.math.round(tmp * conv)
	numb = lib.math.round(2 * tmp )
	numb2 = lib.math.round(2 * numb)	
else
	tmp = lib.math.round_dec(tmp * conv,dec)
	numb = lib.math.round_dec(2 * tmp ,dec)
	numb2 = lib.math.round_dec(2 * numb ,dec)
end

answ[1] = "2 \(\small{\it{x}}\) - " .. tostring(numb2)  
answ[2] = "\(\frac{x}{2}\) + " .. tostring(tmp)         
answ[3] = "2 \(\small{\it{x}}\) - " .. tostring(numb)
answ[4] = "\(\frac{x}{2}\) + " .. tostring(numb) 

for i = 1,4 do
    qq[i] = i
end

out = lib.math.random_shuffle(qq)
for i = 1,4 do
    reply[i] = answ[out[i]]
	if (ind == out[i]) then
	    index = i
	end	
end 
      