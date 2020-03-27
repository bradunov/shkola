
green_style = {["off_color"] = "6f6",
                ["on_color"] = "6f6",
                ["line_color"] = "000",
                ["line_width"] = "2"};

text_style = {["font_size"] = "14"}

term = {}
answ = {}


edge_a = 21 + math.random (19)
edge_b = 11 + math.random (9)
surface = edge_a * edge_b

term[1] = surface
term[3] = (edge_a + edge_b) * 2
term[2] = term[1] + term[3] - math.random(term[3]-5);
term[4] = term[3] + 10 + math.random(term[1] - term[3]);


answ = lib.math.random_shuffle(term)

for i = 1,4 do 
    if (answ[i] == surface) then
       ind = i-1
    end
end	

dima = "a = " .. tostring(edge_a) .. "cm"
dimb = "b = " .. tostring(edge_b) .. "cm"

mycanvas = function()

  lib.start_canvas(250, 150, "center")

  w = 20
  ow = 15
  
  lib.add_rectangle (20, 20, 150, 100, green_style, false, true)
  lib.add_text(90, 130, dima, text_style)
  lib.add_text(210, 60, dimb, text_style)

  lib.end_canvas()
end
                      
           
                         
