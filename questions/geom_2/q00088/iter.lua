
measure = {"m", "dm", "cm"}
measure2 = {"m\(^2\)", "dm\(^2\)", "cm\(^2\)"}
sign = {}

ind = math.random(3)
min_range = 3
max_range = 49

edge1 = min_range + math.random(max_range - min_range) 
edge2 = min_range -1 + math.random(edge1 - min_range)
sign[1] = math.random(2) - 1
edge1 = edge1 / 10^sign[1]	
sign[2] = math.random(2) - 1
edge2 = edge2 / 10^sign[2]	
circ = edge1 + edge2	
edge = circ/2
circ = 2 * circ
area_r = edge1 * edge2  
area_c = edge * edge
area_c = lib.math.round_dec(area_c, 4)

                 
    
