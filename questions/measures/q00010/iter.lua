
measure = {"m", "dm", "cm", "mm"}
measure2 = {"m²", "dm²", "cm²", "mm²"}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                

ind = math.random(4)

min_range = 5
max_range = 20

edge1 = min_range + 1 + math.random(max_range - min_range)
edge2 = min_range + math.random(edge1 - min_range)
edge3 = min_range -1 + math.random(edge2 - min_range)
  
summ = 4 * (edge1 + edge2 + edge3)

surface = (edge1 * edge2 + edge1 * edge3 + edge2 * edge3) * 2 
