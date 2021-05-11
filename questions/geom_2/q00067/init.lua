
include("terms")

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};	
colour_style = 
	{["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "2"};			
		
text_style = {["font_size"] = "16"}		

ind = math.random(7)	

mycanvas = function()

  if (ind == 1) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 0 && result[12] == 1 && result[13] == 0"
  end	
  if (ind == 2) then
      results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 1 && result[4] == 0 && result[5] == 1 && result[6] == 0 && result[7] == 1 && result[8] == 1 && result[9] == 0 && result[10] == 0 && result[11] == 0 && result[12] == 0 && result[13] == 1"
  end	
  if (ind == 3) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 1 && result[10] == 0 && result[11] == 1 && result[12] == 0 && result[13] == 0"
  end	
  if (ind == 4) then
      results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 0 && result[12] == 0 && result[13] == 0"
  end	
  if (ind == 5) then
      results = "result[0] == 1 && result[1] == 0 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 1 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 0 && result[12] == 1 && result[13] == 0"
  end	
  if (ind == 6) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 1 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 0 && result[12] == 0 && result[13] == 0"
  end	  
  if (ind == 7) then
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 1 && result[7] == 0 && result[8] == 0 && result[9] == 0 && result[10] == 0 && result[11] == 0 && result[12] == 0 && result[13] == 0"
  end	
  
  lib.start_canvas(350, 300, "center", results)  
  
  w = 20
  ow = 10

  lib.add_straight_path (2*w, 3*w, {{3*w, 0}, {0, 3*w}, {-3*w, 0}, {0, -3*w}}, colour_style, false, true)       --[[AEFB;1,4,5 ]]--
  lib.add_straight_path (2*w, 6*w, {{3*w, 0}, {0, 2*w},  {-3*w, 2*w},  {0, -4*w} }, colour_style, false, true)    --[[BFGC;2 ]]--
  lib.add_straight_path (2*w, 10*w, {{3*w, -2*w}, {0, 3*w}, {-3*w, 2*w}, {0, -3*w}}, colour_style, false, true)      --[[CGDH; 5]]--
  lib.add_straight_path (5*w, 3*w, {{2*w, 2*w}, {0, 3*w}, {-2*w, 3*w}, {0, -8*w}},  colour_style, false, true)   --[[EJKH  2]]--
  lib.add_straight_path (5*w, 11*w, {{2*w, -3*w}, {0, 2*w}, {w+5, w}, {-3*w-5, 0}}, colour_style, false, true)  --[[KLMH 6]]--
  lib.add_straight_path (2*w, 13*w, {{3*w, -2*w}, {3*w+5, 0},  {3*w-5, 2*w}, {-9*w, 0}}, colour_style, false, true)     --[[DHMR; 2]]--
  lib.add_straight_path (5*w, 3*w, {{3*w, 0}, {2*w, 2*w}, {-3*w, 0}, {-2*w, -2*w}}, colour_style, false, true)     --[[EINJ; 5]]--
  lib.add_straight_path (8*w, 3*w, {{4*w, 0}, {-w, 2*w}, {-w, 0}, {-2*w, -2*w}}, colour_style, false, true)     --[[IPQN; 2]]--
  lib.add_straight_path (7*w, 5*w, {{4*w, 0}, {-2*w, 3*w}, {-2*w, 0}, {0, -3*w}}, colour_style, false, true)     --[[JNOK; 2]]-- 
  lib.add_straight_path (7*w, 8*w, {{2*w, 0}, {2*w, 5*w}, {-4*w, -3*w}, {0, -2*w}}, colour_style, false, true)   --[[KOLR;3 ]]--
  lib.add_straight_path (12*w, 3*w, {{w, 0}, {0, 5*w}, {-2*w, -3*w}, {w, -2*w}}, colour_style, false, true)  --[[PSTQ; ]]--
  lib.add_straight_path (11*w, 13*w, {{-2*w, -5*w}, {2*w, -3*w}, {2*w, 3*w}, {-2*w, 5*w} }, colour_style, false, true)  --[[QTRO 3]]--
  lib.add_straight_path (13*w, 3*w, {{2*w, 0}, {0, 5*w}, {-2*w, 0}, {0, -5*w}}, colour_style, false, true)  --[[SXYT; 1, 5 ]]--
  lib.add_straight_path (11*w, 13*w, {{2*w, -5*w}, {2*w, 0},  {0, 5*w}, {-4*w, 0}}, colour_style, false, true)  --[[TYRZ; 2]]--

--[[
  lib.add_text(w+ow, 2*w+ow, "A", text_style)
  lib.add_text(w+ow, 5*w+ow, "B", text_style)	
  lib.add_text(w+ow, 9*w+ow, "C", text_style)
  lib.add_text(w+ow, 13*w+ow, "D", text_style)
  lib.add_text(5*w+ow, 2*w+ow, "E", text_style)    
  lib.add_text(5*w+ow, 5*w+ow, "F", text_style) 
  lib.add_text(5*w+ow, 7*w+ow, "G", text_style)
  lib.add_text(5*w+ow, 11*w+ow, "H", text_style)
  lib.add_text(8*w+ow, 2*w+ow, "I", text_style)
  lib.add_text(13*w+ow, 2*w+ow, "S", text_style)
  lib.add_text(7*w+ow, 7*w+ow, "K", text_style)
  lib.add_text(7*w+ow, 9*w+ow, "L", text_style)
  lib.add_text(8*w+ow, 11*w+ow, "M", text_style)  
  lib.add_text(10*w+ow, 4*w+ow, "N", text_style)
  lib.add_text(9*w+ow, 8*w+ow, "O", text_style)
  lib.add_text(11*w+ow, 2*w+ow, "P", text_style)  
  lib.add_text(11*w+ow, 4*w+ow, "Q", text_style)
  lib.add_text(11*w+ow, 13*w+ow, "R", text_style)
  lib.add_text(7*w+ow, 4*w+ow, "J", text_style)
  lib.add_text(13*w+ow, 7*w+ow, "T", text_style)	 
  lib.add_text(15*w+ow, 2*w+ow, "X", text_style)
  lib.add_text(15*w+ow, 7*w+ow, "Y", text_style)
  lib.add_text(15*w+ow, 13*w+ow, "Z", text_style)
]]--

	 
    for i = 1,16 do
    lib.add_line(w, i*w, 15*w, 0, style, false, false)
  end

  for i = 1,16 do
    lib.add_line(i*w, w, 0, 15*w, style, false, false)
  end
	
  lib.end_canvas()
end 
       
          
          
          
          
         
          
            
            
            
          
         
            
            
            
            
            
            
            
            
            
            
            
            
            
     