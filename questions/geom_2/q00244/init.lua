
include("terms")

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "3"};

red_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f30",
        ["line_width"] = "2"};

blue_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "0cf",
        ["line_width"] = "2"};
		
green_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "3c3",
        ["line_width"] = "2"};		
				
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};	

text_style = {["font_size"] = "16"}

							
ind = math.random(2)
dir = direction[ind]

sg = math.random(3)
ang = sg * 90

if (ind == 1) then
	ch = sg
else
    ch = 4 - sg
end	


mycanvas = function()
	 		  
  lib.start_canvas(200, 200, "center")   
  
   w = 40
   v = 10

--[[red]]--   
   lib.add_straight_path (v, v, {{w, w}, {2*w,0}, {0, w}, {-w,0}}, red_style, false, false)
   lib.add_curved_path (v+2*w, v+2*w, {{0, 2*w, 2*w, 2*w}}, red_style, false, false)

--[[blue]]-- 
   lib.add_curved_path (v+2*w, v+2*w, {{2*w, 0, 2*w, -2*w}}, blue_style, false, false)
   lib.add_straight_path (v, v+4*w, {{w, -w}, {0, -2*w}, {w, 0},{0, w}}, blue_style, false, false)

--[[green]]-- 
   lib.add_curved_path (v, v, {{2*w, 0, 2*w, 2*w}}, green_style, false, false)
   lib.add_straight_path ( v+4*w, v+4*w, {{-w, -w}, {-2*w, 0}, {0, -w},{w, 0}}, green_style, false, false)

--[[black]]-- 
   lib.add_curved_path (v, v+4*w, {{0, -2*w,  2*w, -2*w}}, style, false, false)
   lib.add_straight_path (v+2*w, v+2*w, {{0, w}, {w, 0}, {0, -2*w}, {w, -w}}, style, false, false)

   lib.add_circle (v+2*w, v+2*w, 3, style, false, false)
   lib.add_text(2*w, 2*w, "O", text_style, false, false)

  for i = 1,5 do
    lib.add_line(v, v+(i-1)*w, 4*w, 0, grid_style, false, false)
  end
  for i = 1,5 do
    lib.add_line(v+(i-1)*w, v, 0, 4*w, grid_style, false, false)
  end

  lib.end_canvas()
end    
                          