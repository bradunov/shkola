
number = {}
term = {}

term[3] = math.random(3);
term[1] = math.random(6 - term[3]) + 1

temp = term[1] + term[3]

diff = math.random(2)
ind = math.random(2)

term[1] = 10 * term[1] + diff * (-1)^ind 
term[3] = 10 * term[3] - diff * (-1)^ind 
value =  term[1] + term[3] 

term[2] = math.random(8 - temp) + 1 ;
term[2] = 10 * term[2] + (diff + 4) * (-1)^ind

result = value + term[2]           
      



          
         
                     