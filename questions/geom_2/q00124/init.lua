
include("terms")

index = {}
ind = {}
quest = {""}
answ = {""}

for i = 1,16 do
    index[i] = i
end	
ind = lib.math.random_shuffle(index)

dim = 3

for i = 1,dim do 
   	quest[i] = title[ind[i]]		
	answ[i] = lib.check_string(reply[ind[i]], 60)	 
	if (ind[i] == 3 or ind[i] == 13 or ind[i] == 14) then
	    answ[i] = answ[i] .. "°"
	end	
end           
