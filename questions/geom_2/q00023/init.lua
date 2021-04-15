
include("terms")
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
style = 
	{["off_color"] = "fff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "2"};												
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

ang = {"aOb", "bOc", "cOd", "dOf", "fOg", "gOa"}

symb = "\(\angle\)"

ind = math.random(5)

reply = ""
answ = "" 
if (ind == 1) then
    first = ang[4]
	second = ang[5]
    results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 1 && result[5] == 0"
    reply = "answer == '" .. msg[1] .. "' "  ..
            "|| answer == '" .. msg[6] .. "'" ;
    ans = "answer = '" .. msg[1] .. "' ";	
end
if (ind == 2) then
    first = ang[6]
	second = ang[1]
    results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0 && result[5] == 1"
    reply = "answer == '" .. msg[2] .. "' "  ..
            "|| answer == '" .. msg[5] .. "'" ;
    ans = "answer = '" .. msg[2] .. "' ";		
end
if (ind == 3) then
    first = ang[1]
	second = ang[5]
    results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 1 && result[5] == 0"
    reply = "answer == '" .. msg[3] .. "' "  ..
            "|| answer == '" .. msg[6] .. "'" ;
    ans = "answer = '" .. msg[3] .. "' ";		
end
if (ind == 4) then
    first = ang[2]
	second = ang[5]
    results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 0 && result[4] == 1 && result[5] == 0"
    reply = "answer == '" .. msg[4] .. "' "  ..
            "|| answer == '" .. msg[4] .. "'" ;
    ans = "answer = '" .. msg[4] .. "' ";		
end
if (ind == 5) then
    first = ang[4]
	second = ang[6]
    results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 0 && result[5] == 1"
    reply = "answer == '" .. msg[5] .. "' "  ..
            "|| answer == '" .. msg[5] .. "'" ;
    ans = "answer = '" .. msg[5] .. "' ";		
end

mycanvas = function(no)

  lib.start_canvas(300, 220, "center", results)
 
  ow = 15
  ov = 140
  v = 90 
  
  lib.add_straight_path(2*ov, 2*ow, {{-ov+ow, v-ow}, {ov, 0}}, style, false, true)
  lib.add_text(2*ov, v, "a", text_style, false, false)
  
  lib.add_straight_path(ow+ov, ow, {{0, v}, {ov-ow, -v+ow}}, style, false, true) 
  lib.add_text(2*ov-ow, 2*ow, "b", text_style, false, false) 
  lib.add_straight_path(ow+ov, ow, {{0, v}, {-ov+ow, -v+ow}}, style, false, true)
  lib.add_text(ov+5, 2*ow, "c", text_style, false, false)  
  
  lib.add_straight_path(2*ow, 2*ow, {{ov-ow, v-ow}, {-ov+ow, 0}}, style, false, true)  
  lib.add_text(3*ow, 3*ow, "d", text_style, false, false) 
  
  lib.add_straight_path(2*ow, ow+v, {{ov-ow, 0}, {-ov+ow, v-ow}}, style, false, true)
  lib.add_text(3*ow, v+2*ow-5, "f", text_style, false, false)
  lib.add_straight_path(2*ow, 2*v, {{ov-ow, -v+ow}, {ov, 0}}, style, false, true)
  lib.add_text(3*ow, 2*v, "g", text_style, false, false) 

  lib.add_text(ow+ov, v+2, ".", dot_style, false, false)
  lib.add_text(ow+ov, v+2*ow, "O", text_style, false, false)
 		
  lib.end_canvas()
end                

                    
              
       
            
