
include("names")
include("shapes")

shade_style = 
	{["off_color"] = "d6d6c2",
        ["on_color"] = "d6d6c2",
        ["line_color"] = "d6d6c2",
        ["line_width"] = "1"};

green_style = 
	{["off_color"] = "3c3",
        ["on_color"] = "3c3",
        ["line_color"] = "000",
        ["line_width"] = "1"};

brown_style = 
	{["off_color"] = "c90",
        ["on_color"] = "c90",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
pink_style = {["off_color"] = "f9c",
             ["on_color"] = "f9c",
             ["line_color"] = "000",
             ["line_width"] = "1"};			

r = math.random(#zensko_ime_nom);
ime = zensko_ime_nom[r];

girl = {}
tree = {}
quest = ""
ans = ""

meas = {"m", "cm"}
space = "\( \ \ \) "

girl[1] = {}
girl[2] = {}
girl[1][2] = 140 + math.random(30)
girl[2][2] = 10*(20 + math.random(20))
if (girl[2][2] - 100 * math.floor(girl[2][2]/100) == 0) then
	girl[2][2] = girl[2][2] + math.random(5)
end		
numb = girl[1][2]

tree[1] = {}
tree[2] = {}
tree[2][2] = 30 *(25 + math.random(15))
tree[1][2] = tree[2][2] * girl[1][2] / girl[2][2]

for i = 1,2 do
	girl[i][1] = math.floor(girl[i][2]/100)
	girl[i][2] = girl[i][2] - 100 * girl[i][1]
end	

for i = 1,2 do
	tree[i][1] = math.floor(tree[i][2]/100)
	tree[i][2] = tree[i][2] - 100 * tree[i][1]		
end
if (tree[2][2] == 0) then
	quest = ""
else
	quest =  tree[2][2] .. meas[2]	
end	
ans = lib.check_number(tree[1][1],20) .. meas[1] 
if (tree[1][2] ~= 0) then
    tree[1][2] = lib.math.round(tree[1][2])
	ans = ans .. space .. lib.check_number(tree[1][2],20) .. meas[2]
end	

mycanvas = function(no)

  w = 250
  ov = 150
  v = 40
  ow = 10

  lib.start_canvas(320, 180, "center")

  lib.add_straight_path (v, ov+2*ow, {{0, -ov}, {w-v, ov}, {v-w, 0}}, shade_style, true, false)
  lib.add_straight_path (v+ow, ov+2*ow, {{-2*ow, 0}, {0, -2*v}, {2*ow, 0}, {0, 2*v}}, brown_style, true, false)
  leaf(lib, v, 2*ow, 2, green_style, false, false)
  
  lib.add_straight_path (w-v, 2*v, {{0, -v-2*ow}, {2*v+ow, v+2*ow}, {-2*v-ow, 0} }, shade_style, true, false)
  lib.add_triangle(w-v, v+2*ow-5, v-ow, v+ow, pink_style, false, false)
  lib.add_circle(w-v, v-ow-2, 8, pink_style, false, false)   

  lib.end_canvas()
end    