
include("terms")

index = {}
ind = {}
quest = {""}
answ = {""}

for i = 1,17 do
    index[i] = i
end	
ind = lib.math.random_shuffle(index)

dim = 4

for i = 1,dim do 
   	quest[i] = title[ind[i]]		
	answ[i] = lib.check_string(reply[ind[i]], 50)	 
	if (ind[i] == 3 or ind[i] == 14 or ind[i] == 15) then
	    answ[i] = answ[i] .. "°"
	end	
end           
  
  
          