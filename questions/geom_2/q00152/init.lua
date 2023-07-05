
include("terms")

index = {}
ind = {}
answ = {""}
result = {""}

for i = 1,15 do
    index[i] = i
end	
ind = lib.math.random_shuffle(index)

dim = 4

for i = 1,dim do
   	answ[i] = title[ind[i]]	  
	result[i] = reply[ind[i]]	  
end
                   
  
          