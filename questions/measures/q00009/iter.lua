
measure = {"m", "dm", "cm", "mm"}
measure2 = {"m\(^2\)", "dm\(^2\)", "cm\(^2\)","mm\(^2\)"}
dim = {"dužina ", "širina ", "visina ", "površina "}
quest = {}

ind = 1 + math.random(3)

edge = {}
edge_out = {}
surface_out = {}

edge[1] = 11 + math.random(88);
edge[2] = 6 + math.random(edge[1] - 9);
edge[3] = 1 + math.random(edge[2] - 4);

surface = (edge[1] * edge[2] + edge[1] * edge[3] + edge[2] * edge[3]) * 2 
surface_out[1] = math.floor(surface/100)	
surface_out[2] = surface - 100 * surface_out[1]

if (ITEM == 1) then
    request = tostring(ITEM) .. ") Izračunaj površinu kvadra čija je: "
    for i = 1,3 do
        quest[i] = dim[i]
        edge_out[i] = {}
        edge_out[i][1] = math.floor(edge[i]/10)
	    edge_out[i][2] = edge[i] - 10 * edge_out[i][1]
	    if ( edge_out[i][1] ~= 0) then
            quest[i] = quest[i] .. tostring(math.floor(edge_out[i][1],20)) .. measure[ind-1] 
	    end
	    if ( edge_out[i][2] ~= 0) then	
		    quest[i] = quest[i] .. " " .. tostring(math.floor(edge_out[i][2],20)) .. measure[ind] 
        end		
    end
    answ = "Površina je "
    if ( surface_out[1] > 99 and ind > 2) then
        surf =  math.floor(surface_out[1]/100)
        surface_out[1] = surface_out[1] - surf * 100
        answ = answ .. lib.check_number(surf,25) .. measure2[ind-2] .. " " 
    end

    for i = 1,2 do
        if (surface_out[i] ~= 0) then  
            answ = answ .. lib.check_number(surface_out[i],25) .. measure2[ind-2+i] .. " "   	
        end
    end	
else
    request = tostring(ITEM) .. ") Izračunaj visinu kvadra čija je: "
    for i = 1,3 do
        quest[i] = dim[i]
        edge_out[i] = {}
        edge_out[i][1] = math.floor(edge[i]/10)
	    edge_out[i][2] = edge[i] - 10 * edge_out[i][1]
	    if ( edge_out[i][1] ~= 0 and i < 3) then
            quest[i] = quest[i] .. tostring(math.floor(edge_out[i][1],20)) .. measure[ind-1] 
	    end
	    if ( edge_out[i][2] ~= 0 and i < 3) then	
		    quest[i] = quest[i] .. " " .. tostring(math.floor(edge_out[i][2],20)) .. measure[ind] 
        end		
    end
	quest[3] = dim[4]
    if ( surface_out[1] > 99 and ind > 2) then
        surf =  math.floor(surface_out[1]/100)
        surface_out[1] = surface_out[1] - surf * 100
        quest[3] = quest[3] .. tostring(math.floor(surf)) .. measure2[ind-2] .. " " 
    end		
    if ( surface_out[1] ~= 0 ) then
        quest[3] = quest[3] .. tostring(math.floor(surface_out[1],20)) .. measure2[ind-1] 
	end
	if ( surface_out[2] ~= 0 ) then	
		quest[3] = quest[3] .. " " .. tostring(math.floor(surface_out[2],20)) .. measure2[ind] 
    end		
    answ = "Visina je "
    for i = 1,2 do
        if (edge_out[3][i] ~= 0) then  
            answ = answ .. lib.check_number(edge_out[3][i],25) .. measure[ind-2+i] .. " "   	
        end
    end	
end    
         
     
         
     
     
    
       
             	
    


     
               

