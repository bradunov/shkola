include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 

marble = {"plavih", "zelenih"}

greenfactor = math.random(3) + 2
redfactor = math.random(7) + 2
redmarble = math.random(15) + 5
 
bluemarble =  redmarble * redfactor
greenmarble = bluemarble * greenfactor 

result = bluemarble + greenmarble + redmarble

if (ITEM == 1) then
    term = redfactor
else
    term = redfactor * greenfactor
end         

   
   


  

     