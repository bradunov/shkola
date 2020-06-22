style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
yelow_style = {["off_color"] = "ff0",
             ["on_color"] = "ff0",
             ["line_color"] = "000",
             ["line_width"] = "2"};

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};	

text_style = {["font_size"] = "14"}

term = {}
answ = {}
order = {}

edge_b = 7 + math.random (8)
edge_a = edge_b + math.random (9)
dif = math.random(3)

surface_out = edge_a * edge_b
surface_in = (edge_a-2*dif) * (edge_b-2*dif)
surface = surface_out - surface_in

term[1] = surface
term[2] = (edge_a-dif) * edge_b - surface_in 
term[3] = edge_a * (edge_b-dif) - surface_in
term[4] = surface_in
term[5] = surface_out


order = lib.math.argsort(term)
for i = 1,4 do
    if (term[order[i]] == term[order[i+1]]) then
	term[order[i]] = term[order[i]] - (5-i)
    end
end	

answ = lib.math.random_shuffle(term)

for i = 1,5 do 
    if (answ[i] == surface) then
       ind = i-1
    end
end


dima = tostring(edge_a) .. " cm"
dimb = tostring(edge_b) .. " cm"
differ = tostring(dif) .. " cm"

mycanvas = function()

  lib.start_canvas(300, 200, "center")
  
  lib.add_rectangle (10, 10, 200, 150, yelow_style, false, false)
  lib.add_rectangle (50, 50, 120, 70, style, false, false)

  lib.add_text(120, 175, dima, text_style)
  lib.add_text(235, 85, dimb, text_style)

  lib.add_straight_path(10, 85, {{40, 0}}, line_style, false, false)
  lib.add_text(30, 95, differ, text_style)

  lib.add_straight_path(170, 85, {{40, 0}}, line_style, false, false)
  lib.add_text(190, 95, differ, text_style)

  lib.add_straight_path(110, 10, {{0, 40}}, line_style, false, false)
  lib.add_text(128, 30, differ, text_style)

  lib.add_straight_path(110, 120, {{0, 40}}, line_style, false, false)
  lib.add_text(128, 140, differ, text_style)

  lib.end_canvas()
end
    