
include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 
padez = musko_ime_dativ[r]

measure = {"m", "dm", "cm"}
measure2 = {"m\(^2\)", "dm\(^2\)", "cm\(^2\)"}

ind = 3
number = 4 + math.random(8)

min = 7;
max = 20;

edge = min + math.random(max - min);
height = 3 + math.random(edge - 5);

base = edge ^ 2

surface = 4 * edge * height + base

result = number * surface
     
