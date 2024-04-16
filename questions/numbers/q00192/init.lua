
include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 


bank = 100 * (math.random(2890) + 8510)
car = 100 * (math.random(2000) + 6000)

value = bank - car 
diff =  30010 + math.random(value - 30010) 
  
value1 = value + diff
value2 = value - diff            
      