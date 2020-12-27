include("terms")

measure = {"m", "dm", "cm", "mm"}
measure2 = {"m\(^2\)", "dm\(^2\)", "cm\(^2\)","mm\(^2\)"}
ind = math.random(4)

quest = {}
answ = {}
surface1 = {}

index = math.random(2)

min_range = 5
max_range = 15

edge1_b = min_range + 2 + math.random(max_range - min_range)
edge2_b = min_range + 1 + math.random(edge1_b - min_range - 2)
edge3_b = min_range + math.random(edge2_b - min_range - 1)

dif = 1 + math.random(min_range-1)
edge1 = edge1_b * dif
edge2 = edge2_b * dif
edge3 = edge3_b * dif

surface = 2 * (edge1 * edge2 + edge1 * edge3 + edge2 * edge3)              
        
     