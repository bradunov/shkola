
measure = {"m", "dm", "cm", "mm"}
measure2 = {"m²", "dm²", "cm²","mm²"}

ind = math.random(3)

min = 11;
max = 20;

edge2 = 3 + math.random(6);
edge1 = math.random(edge2 - 3);

edge = edge1 * 10 + edge2
surface = edge * edge * 5

surface1 = math.floor(surface/100)
surface2 = surface - surface1 * 100
