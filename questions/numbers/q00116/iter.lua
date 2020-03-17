value = {"jedinica", "desetica", "stotina", "hiljada", "desetica hiljada", "stotine hiljada", "miliona"}
fig = {}
cifre = {}
            
nmb1 = 5 + math.random(4);
nmb2 = 2 + math.random(3);
nmb3 = math.random(3) - 1;

ind = 0
for i = 1,7 do
    if (ind ==  nmb1 or ind ==  nmb2 or ind ==  nmb3) then 
        ind = ind + 1
    end		
    fig[i] = ind
	ind = ind + 1
end	           
 
cifre = lib.math.random_shuffle(fig) 

number = cifre[7]

for i = 1,6 do
   number = number *10 + cifre[7-i];
end

             
index = math.random(7)                  
                    
result =  cifre[index]  

   