
style = {["off_color"] = "f9c",
                ["on_color"] = "f9c",
                ["line_color"] = "000",
                ["line_width"] = "2"};

text_style = {["font_size"] = "14"}

term = {}
out = {}
answ = {}


edge_a = 21 + math.random (19)
edge_b = 11 + math.random (9)
circ = (edge_a + edge_b) * 2

term[1] = circ
term[3] = math.floor((edge_a * edge_b)/9)
term[2] = term[1] + term[3] - math.random(term[3]-5);
temp = term[3] - term[1]
if (temp < 0) then
    temp = -temp
end	
term[4] = term[3] + 10 + math.random(temp);

out = lib.math.argsort(term)

for i = 2,4 do
    if (term[out[i]] == term[out[i-1]]) then
	    term[out[i]] = term[out[i]] + 1 
	end	 
end	

answ = lib.math.random_shuffle(term)

for i = 1,4 do 
    if (answ[i] == circ) then
       ind = i-1
    end
end	

dima = "a = " .. tostring(edge_a) .. "cm"
dimb = "b = " .. tostring(edge_b) .. "cm"

mycanvas = function()

  lib.start_canvas(250, 150, "center")

  w = 20
  ow = 15
  
  lib.add_rectangle (20, 20, 150, 100, style, false, true)
  lib.add_text(90, 130, dima, text_style)
  lib.add_text(210, 60, dimb, text_style)

  lib.end_canvas()
end
                                      
           
                         
