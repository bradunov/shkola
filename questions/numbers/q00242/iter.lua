
solution = ""
ind = math.random(9)
for i = 0, 9 do
    if i < ind then
       solution = solution.."solution["..tostring(i).."]=1;"
    else
       solution = solution.."solution["..tostring(i).."]=0;"
    end
end
out =  "sum(result) == " .. ind

if (ITEM == 1) then
    style = blue_style  
    image = "circle"                                                                                                                                                                                                                                                                            
end            

if (ITEM == 2) then
    style = red_style  
    image = "triangle"                                                                                                                                                                                                                                                                             
end 

if (ITEM == 3) then
    style = green_style  
    image = "square"                                                                                                                                                                                                                                                                             
end             
     
if (ind == 1) then
    quest = name[1]
else
    if (ind < 5) then   
        quest = name[2] 
    else
        quest = name[3] 	
	end
end	         
  