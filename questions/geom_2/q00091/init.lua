
measure = {"m", "dm", "cm"}
measure2 = {"m²", "dm²", "cm²"}

ind = 3
dim = 10^2
dim2 = dim*dim

edge1 = (35 + math.random(20)) * 10
edge2 = (25 + math.random(20)) * 10
edge3 = (21 + math.random(10)) * 10

window1 = (10 + math.random(5)) * 5
window2 = (12 + math.random(8)) * 5
window = window1 * window2

door1 = (15 + math.random(5)) * 5
door2 = (35 + math.random(5)) * 5
door = door1 * door2

surface = 2 * (edge1 * edge3 + edge2 * edge3) - window - door 
surface_m = math.floor(surface/dim2)
surface_d = math.floor((surface - surface_m * dim2)/dim)
surface_c = surface - (surface_m * dim2 + surface_d * dim)
