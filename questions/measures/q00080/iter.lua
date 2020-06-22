
measure = {"m", "dm", "cm", "mm"}
measure2 = {"m\(^3\)", "dm\(^3\)", "cm\(^3\)","mm\(^3\)"}
dim = {"dužina ", "širina ", "visina ", "zapremina "}
quest = {}

ind = 1 + math.random(3)

edge = {}
edge_out = {}
volume_out = {}

edge[1] = 11 + math.random(88);
edge[2] = 6 + math.random(edge[1] - 9);
edge[3] = 1 + math.random(edge[2] - 4);

volume = edge[1] * edge[2] * edge[3] 
volume_out[1] = math.floor(volume/1000)	
volume_out[2] = volume - 1000 * volume_out[1]

if (ITEM == 1) then
    request = tostring(ITEM) .. ") Izračunaj zapreminu kvadra čija je: "
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
    answ = "Zapremina je "
    if ( volume_out[1] > 999 and ind > 2) then
        vol =  math.floor(volume_out[1]/1000)
        volume_out[1] = volume_out[1] - vol * 1000
        answ = answ .. lib.check_number(vol,25) .. measure2[ind-2] .. " " 
    end

    for i = 1,2 do
        if (volume_out[i] ~= 0) then  
            answ = answ .. lib.check_number(volume_out[i],25) .. measure2[ind-2+i] .. " "   	
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
    if ( volume_out[1] > 999 and ind > 2) then
        vol =  math.floor(volume_out[1]/1000)
        volume_out[1] = volume_out[1] - vol * 1000
        quest[3] = quest[3] .. tostring(math.floor(vol)) .. measure2[ind-2] .. " " 
    end		
    if ( volume_out[1] ~= 0 ) then
        quest[3] = quest[3] .. tostring(math.floor(volume_out[1],20)) .. measure2[ind-1] 
	end
	if ( volume_out[2] ~= 0 ) then	
		quest[3] = quest[3] .. " " .. tostring(math.floor(volume_out[2],20)) .. measure2[ind] 
    end		
    answ = "Visina je "
    for i = 1,2 do
        if (edge_out[3][i] ~= 0) then  
            answ = answ .. lib.check_number(edge_out[3][i],25) .. measure[ind-2+i] .. " "   	
        end
    end	
end
     
         
     
     
    
       
             	
    


     
               

