
measure = {"m", "dm", "cm", "mm"}
measure2 = {"m\(^3\)", "dm\(^3\)", "cm\(^3\)","mm\(^3\)"}
dim = {"dužina ", "širina ", "visina "}
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
answ = ""
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

         
     
     
    
       
             	
    


     
               

