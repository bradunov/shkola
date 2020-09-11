
include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 

food = {"paradajz", "sir", "masline", "šunku", "pečurke", "salamu"}

ind = 2 + math.random(4)

index = {}
for i = 1,ind do
    index[i] = i
end	 

out = lib.math.random_shuffle(index)

quest = ""
for i = 1,ind-1 do
    quest = quest .. food[out[i]] .. ", "
end
quest = quest .. food[out[ind]] .. "."	

answ = {3, 6, 10, 15}
            
result = answ[ind-2]
  
   



       

            

   


  

     