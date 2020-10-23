
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["off_line_color"] = "000",
        ["line_width"] = "2"}; 

dot_style = {["font_size"] = "30"}
	
place = {"pravu", "polupravu", "duž"}

ind = math.random(3)
name = place[ind]

  mycanvas = function()
  
  if (ind == 1) then
     results = "result[0] == 1 && result[1] == 0 && result[2] == 0" 
  end
  if (ind == 2) then   
     results = "result[0] == 0 && result[1] == 1 && result[2] == 0"
  end
  if (ind == 3) then
     results = "result[0] == 0 && result[1] == 0 && result[2] == 1"
  end


  lib.start_canvas(320, 220, "center", results)
  
  lib.add_straight_path(30, 30, {{100, 150}}, line_style, false, true)
  
  lib.add_straight_path(170, 92, {{120, 100}}, line_style, false, true)
  lib.add_text(172, 85, ".", dot_style, false, false)

  lib.add_straight_path(150, 40, {{100, 0}}, line_style, false, true)
  lib.add_text(150, 30, ".", dot_style, false, false)
  lib.add_text(250, 30, ".", dot_style, false, false)   

  lib.end_canvas()
end  
          
                
            