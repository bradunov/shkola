
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

text_style = {["font_size"] = "16"}


meas2 = "cm\(^2\)"

x = 5 + math.random(12)
y = math.floor(x*5/2)

edge_a = 5 * y
edge_b = x + 3*y
left = 3 * y
right = 3 * x

circ = 2 * (edge_a + left + right) 
area = edge_a * right + edge_b * left

mycanvas = function()

  lib.start_canvas(360, 280, "center")
  
  v = 5
  ow = 20
  ov = 50

dimup = tostring(edge_a) .. " cm"
dimdown = tostring(edge_b) .. " cm"
dimleft = tostring(left) .. " cm"
dimright = tostring(right) .. " cm"  
  
  lib.add_straight_path(ov-ow, ov-ow, {{5*ov,0}, {0,3*ow}, {-2*ow,0}, {0,3*ov}, {-3*ov-ow,0}, {0,-3*ov}, {-2*ow,0}, {0,-3*ow}}, line_style, false, false)
  lib.add_text(3*ov+v, ow-v, dimup, text_style)
  lib.add_text(3*ov+v, 5*ov, dimdown, text_style)
  lib.add_text(ov-v, 3*ov, dimleft, text_style)
  lib.add_text(6*ov+v, 3*ow, dimright, text_style)


  lib.end_canvas()
end
  