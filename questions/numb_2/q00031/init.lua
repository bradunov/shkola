

include("terms")

index = {1,2,3,4,5,6,7, 8, 9, 10}
ind = lib.math.random_shuffle(index)

answ = {""}
result = {""}

dim = 5

for i = 1,dim do
   	answ[i] = title[ind[i]]	  
	result[i] = reply[ind[i]]	  
end 
                   
  
          