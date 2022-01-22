
numb = {}
out = {}
number = {}

dim = 9 + math.random(8) 
range = 20

for i = 1,dim do
    numb[i] = math.random(range)
end
out = lib.math.argsort(numb)

nr = 1
ind = 1
sg = 0
for i = 1,dim-1 do
    if (numb[out[i]] == numb[out[i+1]]) then
	    nr = nr + 1
		if (i == dim-1) then
		    if (nr > ind) then
	            ind = nr		
		        modus = numb[out[i]]
			    sg = 1		    			
		    end
		end	
	else
		if (nr > ind) then
	        ind = nr		
		    modus = numb[out[i]]
			sg = 1
		end
        nr = 1
    end    			
end	
if (sg == 0) then
    ch = math.random(dim)
	modus = numb[ch]
end
dim = dim + 1
numb[dim] = modus	

aver = 0
for i = 1,dim do
	aver = aver + numb[i]
end
aver = lib.math.round_dec(aver/dim,2)	

out = lib.math.argsort(numb)
dimhalf = math.floor(dim/2)
if (dim - 2*dimhalf == 0) then
    med = (numb[out[dimhalf]] + numb[out[dimhalf+1]]) * 0.5
else
    med = numb[out[dimhalf+1]]
end	

number = lib.math.random_shuffle(numb)
