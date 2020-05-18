include("terms")
array_decade = {}
array_value = {}

factor = math.random(10);
name = array_decname[factor]

for i = 1,10 do
    array_decade[i] = (factor-1) * 10 + i 
end	

indeks = math.random(2)
if (indeks == 1) then   
    izbor = "parne"
	for j = 1,5 do
	   array_value[j] = array_decade[2*j]
	end   
else
    izbor = "neparne"
	for j = 1,5 do
	   array_value[j] = array_decade[2*j-1]
	end  
end
                 

                  
         