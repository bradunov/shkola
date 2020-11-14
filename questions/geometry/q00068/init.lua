
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f90",
        ["line_width"] = "2"};

line_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "6f6",
        ["line_width"] = "2"};			
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

prava = {"a", "b"}
poluprava = {"Oa", "Na", "Mb", "Ob", "Pb"}
duz = {"OM", "MO", "OP", "PO", "MP", "PM", "ON", "NO"}
tacka ={"M", "N", "O", "P"}

reply = {}
ans = {}

reply[1] = "answer == '" .. prava[1] .. "' "  ..
        "|| answer == '" .. prava[2] .. "'" ;
ans[1] = "answer = '" .. prava[1] .. "' ";

reply[2] = "answer == '" .. poluprava[1] .. "' "  ..
           "|| answer == '" .. poluprava[2] .. "'" ..
           "|| answer == '" .. poluprava[3] .. "'" ..
           "|| answer == '" .. poluprava[4] .. "'" ..		   
           "|| answer == '" .. poluprava[5] .. "'" ; 
ans[2] = "answer = '" .. poluprava[1] .. "' ";

reply[3] = "answer == '" .. duz[1] .. "' "  ..
           "|| answer == '" .. duz[2] .. "'" ..
           "|| answer == '" .. duz[3] .. "'" ..
           "|| answer == '" .. duz[4] .. "'" ..	
           "|| answer == '" .. duz[5] .. "'" ..
           "|| answer == '" .. duz[6] .. "'" ..
           "|| answer == '" .. duz[7] .. "'" ..			   
           "|| answer == '" .. duz[8] .. "'" ; 
ans[3] = "answer = '" .. duz[1] .. "' ";
		   
reply[4] = "answer == '" .. tacka[1] .. "' "  ..
           "|| answer == '" .. tacka[2] .. "'" ..
           "|| answer == '" .. tacka[3] .. "'" ..	   
           "|| answer == '" .. tacka[4] .. "'" ;
ans[4] = "answer = '" .. tacka[1] .. "' ";
		

mycanvas = function(no)
  lib.start_canvas(330, 160, "center")
  
  lib.add_straight_path(40, 40, {{250, 100}}, line_style, true, false)
  lib.add_text(270, 140, "a", text_style, false, false)
  lib.add_straight_path(60, 140, {{230, -120}}, style, true, false)
  lib.add_text(270, 40, "b", text_style, false, false)

  lib.add_text(160, 75, ".", dot_style, false, false)
  lib.add_text(160, 72, "O", text_style, false, false)
  
  lib.add_text(90, 112, ".", dot_style, false, false)
  lib.add_text(90, 109, "M", text_style, false, false)
  
  lib.add_text(60, 36, ".", dot_style, false, false)
  lib.add_text(60, 33, "N", text_style, false, false)

  lib.add_text(230, 40, ".", dot_style, false, false)
  lib.add_text(230, 37, "P", text_style, false, false)
   
  lib.end_canvas()
end
          
                   