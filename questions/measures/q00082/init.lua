
measure = {"m", "dm"}
measure1 = {"m\(^3\)", "dm\(^3\)"}
measure2 = {"hl", "l"}

volume_out = {}
volw_out = {}

denom = 1 + math.random(4)
min = math.floor(15/denom)
max = 10 - min
temp = min + math.random(max) 
edge1 = temp * denom
edge2 = 7 + math.random(6)
edge3 = 14 + math.random(16);

volume = edge1 * edge2 * edge3 * 100
volume_out[1] = math.floor(volume/1000)	
volume_out[2] = volume - 1000 * volume_out[1]

answ1 = ""
if (volume_out[2] > 0) then
    answ1 = answ1 .. lib.check_number(volume_out[2] ,25) .. measure1[2]
end

volw = temp * edge2 * edge3 * 100
 
volw_out[1] = math.floor(volw/100)	
volw_out[2] = volw - 100 * volw_out[1]

answ2 = ""
if (volw_out[2] > 0) then
    answ2 = answ2 .. lib.check_number(volw_out[2] ,25) .. measure2[2]
end
   
     
    
       
             	
    


     
               

