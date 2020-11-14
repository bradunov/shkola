
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

meas_style = 
	{["off_color"] = "fc8",
        ["on_color"] = "fc8",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
pen_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "2"};		


text_style = {["font_size"] = "16"}

number = {}

number[1] = 1
for i = 1, 7 do
    number[i+1] = (number[i] + 1)  
end
	

mycanvas = function(no)
  lib.start_canvas(350, 170, "center")

hscale = 1.5
vscale = 5
step = 25*hscale

ind = math.random(7) + 1
pencil = ind * step

  lib.add_rectangle(5*hscale, 5*vscale, pencil-20, 20, pen_style, false, true)
  lib.add_straight_path(5*hscale+pencil-20, 9*vscale, {{20, -10}, {-20, -10}}, meas_style, false, true)

  lib.add_rectangle(5*hscale, 20*vscale, 220*hscale, 40, meas_style, false, true)

  x = 29*hscale
  y = 25*vscale
      lib.add_straight_path(x-step/2, y-25, {{0, 5}}, style, false, true)

  for i = 1, 8 do  
      lib.add_straight_path(x, y-25, {{0, 10}}, style, false, true)
      lib.add_text(x, y+5, tostring(math.floor(number[i])), text_style) 
      lib.add_straight_path(x+step/2, y-25, {{0, 5}}, style, false, true)
      x = x + step
  end

  lib.end_canvas()
end                 
            
               
            
                               
                                                
      
            