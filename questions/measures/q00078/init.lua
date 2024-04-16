
measure = {"m", "dm", "cm","mm"}
measure2 = {"m³","dm³","cm³", "mm³"}

ind = math.random(4)

min = 2;
max = 20;

edge = min + math.random(max - min);
volume = edge * edge * edge

circ1 = edge * 4
circ2 = edge * 12
factor = 1 + math.random(4)
temp = factor^3
