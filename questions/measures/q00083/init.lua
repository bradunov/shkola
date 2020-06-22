
measure = {"m", "dm", "cm"}

edge = {}
edge_out = {}
box = {}
box_out = {}

index = {1,2,3}
ind = {}

edge[1] = 15 + math.random(10)
edge[2] = 9 + math.random(6)
edge[3] = 2 + math.random(6);

answ1 = ""
for i = 1,3 do
    edge_out[i] = {}
	edge_out[i][1] = math.floor(edge[i]/10)
	edge_out[i][2] = edge[i] - 10 * edge_out[i][1]
	if(edge_out[i][1] ~= 0) then
	   answ1 = answ1 .. tostring(math.floor(edge_out[i][1])) .. measure[2] 
	end
	if(edge_out[i][2] ~= 0) then
       answ1 = answ1 .. " " .. tostring(math.floor(edge_out[i][2])) .. measure[3] .. ", "
    else
       answ1 = answ1 .. ", "   	
	end   
end	

number = 1
for i = 1,3 do
    min = 2 * i
    max = 4 * i
    factor = min + math.random(max)
    box[i] = edge[i] * factor
    number = number * factor
end	

ind = lib.math.random_shuffle(index)

answ2 = ""
for i = 1,3 do
    j = ind[i]
    box_out[j] = {}
	box_out[j][1] = math.floor(box[j]/100)
	temp = box[j] - 100 * box_out[j][1]
	box_out[j][2] = math.floor(temp/10)
	box_out[j][3] = temp - 10 * box_out[j][2]
	if(box_out[j][1] ~= 0) then
	   answ2 = answ2 .. " " .. tostring(math.floor(box_out[j][1])) .. measure[1] 
	end
	if(box_out[j][2] ~= 0) then
	   answ2 = answ2 .. " " .. tostring(math.floor(box_out[j][2])) .. measure[2] 
	end	
	if(box_out[j][3] ~= 0) then
	   answ2 = answ2 .. " " .. tostring(math.floor(box_out[j][3])) .. measure[3] 
	end
	if (i < 3) then
        answ2 = answ2 .. ", "   
	end	   
end	
     
    
       
             	
    


     
               

