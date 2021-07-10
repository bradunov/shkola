
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
		
text_style = {["font_size"] = "14"}
meas = {"cm", "cm\(\small^2\)"}
sp = "\(   \) "
	
name = {"ABFE", "BCGF", "CDHG", "EHKJ", "DRMH", "EJNI", "INQP", "JKOQ", "ORTQ", "STYX", "TRZY"}
area = {4.5, 4.5, 4.5, 5.5, 6, 3, 2.5, 4.5, 8, 5, 7.5}

ch = {}
dim = 11
qq = {}
answ = {""}

for i = 1,dim do
    ch[i] = i
end	

qq = lib.math.random_shuffle(ch)

for i = 1,4 do
    answ[i] = name[qq[i]] .. sp .. sp .. sp .. lib.check_number(area[qq[i]],20) .. meas[2]
end	


mycanvas = function()
	 		  
  lib.start_canvas(350, 300, "center")  
  
  w = 20
  ow = 10
  
  
  lib.add_straight_path (2*w, 3*w, {{3*w, 0}, {0, 3*w}, {-3*w, 0}, {0, -3*w}}, colour_style, false, true)	  --[[AEFB;1 ]]--
  for j = 1,4 do
      if (ch[1] == qq[j]) then
          lib.add_straight_path (2*w, 3*w, {{3*w, 0}, {0, 3*w}, {-3*w, 0}, {0, -3*w}}, colour_style, true, true)	
      end
  end	    
  lib.add_straight_path (2*w, 6*w, {{3*w, 0}, {0, 2*w},  {-3*w, 2*w},  {0, -4*w} }, colour_style, false, true)    --[[BFGC;2 ]]--
  for j = 1,4 do
      if (ch[2] == qq[j]) then
          lib.add_straight_path (2*w, 6*w, {{3*w, 0}, {0, 2*w},  {-3*w, 2*w},  {0, -4*w} }, colour_style, true, true) 	  
      end
  end	 
  lib.add_straight_path (2*w, 10*w, {{3*w, -2*w}, {0, 3*w}, {-3*w, 2*w}, {0, -3*w}}, colour_style, false, true)      --[[CGDH; 3]]--
  for j = 1,4 do
      if (ch[3] == qq[j]) then
          lib.add_straight_path (2*w, 10*w, {{3*w, -2*w}, {0, 3*w}, {-3*w, 2*w}, {0, -3*w}}, colour_style, true, true)
      end
  end	    

  lib.add_straight_path (5*w, 3*w, {{2*w, 2*w}, {0, 3*w}, {-2*w, 3*w}, {0, -8*w}},  colour_style, false, true)   --[[EJKH; 4]]--
  for j = 1,4 do
      if (ch[4] == qq[j]) then
          lib.add_straight_path (5*w, 3*w, {{2*w, 2*w}, {0, 3*w}, {-2*w, 3*w}, {0, -8*w}},  colour_style, true, true) 
      end
  end	
  
  lib.add_straight_path (2*w, 13*w, {{3*w, -2*w}, {3*w+5, 0},  {3*w-5, 2*w}, {-9*w, 0}}, colour_style, false, true)     --[[DHMR; 5]]--
  for j = 1,4 do
      if (ch[5] == qq[j]) then
         lib.add_straight_path (2*w, 13*w, {{3*w, -2*w}, {3*w+5, 0},  {3*w-5, 2*w}, {-9*w, 0}}, colour_style, true, true)   
      end
  end	
  
  lib.add_straight_path (5*w, 3*w, {{3*w, 0}, {2*w, 2*w}, {-3*w, 0}, {-2*w, -2*w}}, colour_style, false, true)     --[[EINJ; 6]]--
  for j = 1,4 do
      if (ch[6] == qq[j]) then
         lib.add_straight_path (5*w, 3*w, {{3*w, 0}, {2*w, 2*w}, {-3*w, 0}, {-2*w, -2*w}}, colour_style, true, true)    
      end
  end	

  lib.add_straight_path (8*w, 3*w, {{4*w, 0}, {-w, 2*w}, {-w, 0}, {-2*w, -2*w}}, colour_style, false, true)     --[[IPQN; 7]]--
  for j = 1,4 do
      if (ch[7] == qq[j]) then
         lib.add_straight_path (8*w, 3*w, {{4*w, 0}, {-w, 2*w}, {-w, 0}, {-2*w, -2*w}}, colour_style, true, true)    
      end
  end

  lib.add_straight_path (7*w, 5*w, {{4*w, 0}, {-2*w, 3*w}, {-2*w, 0}, {0, -3*w}}, colour_style, false, true)     --[[JQOK; 8]]-- 
  for j = 1,4 do
      if (ch[8] == qq[j]) then
          lib.add_straight_path (7*w, 5*w, {{4*w, 0}, {-2*w, 3*w}, {-2*w, 0}, {0, -3*w}}, colour_style, true, true)       
      end
  end
  
  lib.add_straight_path (11*w, 13*w, {{-2*w, -5*w}, {2*w, -3*w}, {2*w, 3*w}, {-2*w, 5*w} }, colour_style, false, true)  --[[QTRO 9]]--
  for j = 1,4 do
      if (ch[9] == qq[j]) then
          lib.add_straight_path (11*w, 13*w, {{-2*w, -5*w}, {2*w, -3*w}, {2*w, 3*w}, {-2*w, 5*w} }, colour_style, true, true)      
      end
  end

  lib.add_straight_path (13*w, 3*w, {{2*w, 0}, {0, 5*w}, {-2*w, 0}, {0, -5*w}}, colour_style, false, true)  --[[SXYT; 10 ]]--
  for j = 1,4 do
      if (ch[10] == qq[j]) then
          lib.add_straight_path (13*w, 3*w, {{2*w, 0}, {0, 5*w}, {-2*w, 0}, {0, -5*w}}, colour_style, true, true)     
      end
  end

  lib.add_straight_path (11*w, 13*w, {{2*w, -5*w}, {2*w, 0},  {0, 5*w}, {-4*w, 0}}, colour_style, false, true)  --[[TYRZ; 11]]--
  for j = 1,4 do
      if (ch[11] == qq[j]) then
          lib.add_straight_path (11*w, 13*w, {{2*w, -5*w}, {2*w, 0},  {0, 5*w}, {-4*w, 0}}, colour_style, true, true)  --[[TYRZ; 11]]--
      end
  end


  lib.add_straight_path (7*w, 8*w, {{2*w, 0}, {2*w, 5*w}, {-4*w, -3*w}, {0, -2*w}}, colour_style, false, false)   --[[KOLR;3 ]]--
  lib.add_straight_path (5*w, 11*w, {{2*w, -3*w}, {0, 2*w}, {w+5, w}, {-3*w-5, 0}}, colour_style, false, false)  --[[KLMH 6]]--
  lib.add_straight_path (12*w, 3*w, {{w, 0}, {0, 5*w}, {-2*w, -3*w}, {w, -2*w}}, colour_style, false, false)  --[[PSTQ; ]]--
  
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
  lib.add_text(9*w+ow, 8*w, "O", text_style)
  lib.add_text(11*w+ow, 2*w+ow, "P", text_style)  
  lib.add_text(11*w+ow, 5*w, "Q", text_style)
  lib.add_text(11*w+ow, 13*w+ow, "R", text_style)
  lib.add_text(7*w+ow, 4*w+ow, "J", text_style)
  lib.add_text(13*w+ow, 7*w+ow, "T", text_style)	 
  lib.add_text(15*w+ow, 2*w+ow, "X", text_style)
  lib.add_text(15*w+ow, 7*w+ow, "Y", text_style)
  lib.add_text(15*w+ow, 13*w+ow, "Z", text_style)
	 
    for i = 1,16 do
    lib.add_line(w, i*w, 15*w, 0, style, false, false)
  end

  for i = 1,16 do
    lib.add_line(i*w, w, 0, 15*w, style, false, false)
  end
	
  lib.end_canvas()
end 
     
            
            
          
         
            
            
            
            
            
            
            
            
            
            
            
            
            
     