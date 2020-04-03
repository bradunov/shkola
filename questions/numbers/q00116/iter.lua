value = {"jedinica", "desetica", "stotina", "hiljada", "desetica hiljada", "stotine hiljada", "miliona"}

cifre = {}
            
dig = 3 + ITEM

cifre[dig] = math.random(9)
number = cifre[dig]
for i = 1,dig - 1  do
    cifre[dig-i] = math.random(10) - 1
	number = number  * 10 + cifre[dig-i]
end

index = math.random(dig)

result =  cifre[index]  
  