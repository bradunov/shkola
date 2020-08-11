
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

name = {"prava", "poluprava", "pocetak poluprave", "duz", "krajevi duzi"}
name2 = {"prava", "poluprava", "početak poluprave", "duž", "krajevi duži"}

reply = {}

reply[3] = "answer == '" .. name[3] .. "' "  ..
        "|| answer == '" .. name2[3] .. "'" ;

reply[4] = "answer == '" .. name[4] .. "' "  ..
        "|| answer == '" .. name2[4] .. "'" ;
		
reply[5] = "answer == '" .. name[5] .. "' "  ..
        "|| answer == '" .. name2[5] .. "'" ;
		
numb1 = 2
numb2 = 3

mycanvas = function(no)
  lib.start_canvas(310, 150, "center")
  
  lib.add_straight_path(40, 40, {{250, 100}}, line_style, true, false)
  lib.add_text(60, 35, "n", text_style, false, false)

  lib.add_text(200, 92, ".", dot_style, false, false)
  lib.add_text(200, 90, "O", text_style, false, false)
  
  lib.add_text(60, 120, ".", dot_style, false, false)
  lib.add_text(60, 118, "A", text_style, false, false)
  
  lib.add_text(150, 30, ".", dot_style, false, false)
  lib.add_text(150, 28, "J", text_style, false, false)

  lib.add_text(230, 30, ".", dot_style, false, false)
  lib.add_text(230, 28, "E", text_style, false, false)

  lib.add_straight_path(150, 40, {{80, 0}}, style, true, false)
    
  lib.end_canvas()
end
       