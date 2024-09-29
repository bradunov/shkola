
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "2"};

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};	
							
text_style = {["font_size"] = "16"}

grid = 2 + math.random(7)
numb = grid - 1
enum = 2*numb -1
denom = 2*numb*numb

mycanvas = function()
	 		  
  lib.start_canvas(250, 200, "center")   
  
	w = 200/grid
	ow = 5
	v = 20

	lib.add_rectangle (v, v, (grid-1)*w, (grid-1)*w, style, false, false) 
	lib.add_straight_path(v+(grid-1)*w, v, {{-(grid-1)*w,((grid-1)-1)*w}, {w,w}, {(grid-2)*w, -(grid-1)*w}}, dif_style, true, false)  

  for i = 1,grid do
    lib.add_line(v, v+(i-1)*w, (grid-1)*w, 0, grid_style, false, false)
  end
  for i = 1,grid do
    lib.add_line(v+(i-1)*w, v, 0, (grid-1)*w, grid_style, false, false)
  end  

  lib.end_canvas()
end       
