	
style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
		
text_style = {["font_size"] = "16"}		

name = {"jednakokraki", "jednakostranicni", "nejednakostranicni"}
name2 = {"jednakokraki", "jednakostranični", "nejednakostranični"}
answ = { "temena", "stranice"}
reply = {}
ind = math.random(3)

reply[1] = "answer == '" .. name[1] .. "' "  ..
        "|| answer == '" .. name2[1] .. "'" ;   
reply[2] = "answer == '" .. name[2] .. "' "  ..
        "|| answer == '" .. name2[2] .. "'" ;   
reply[3] = "answer == '" .. name[3] .. "' "  ..
        "|| answer == '" .. name2[3] .. "'" ;   		
		

ow = 20
w = 5
v = 100
ov = 150

if(ind == 1) then
   x = -v+2*ow
   y = ov-3*ow/2
   z = x
end 
if(ind == 2) then
   x = -(v+ow)*0.6
   y = 1.2*(v+ow)
   z = x
end 
if(ind == 3) then
   x = -v-ow
   y = ov+v/2+w
   z = -v+ow-w
end   

mycanvas = function(no)
  lib.start_canvas(300, 240, "center")
  
  lib.add_straight_path (ov, 2*ow, {{x, v+ow}, {y, 0}, {z, -v-ow}}, style, true, false)
  lib.add_text(ov+x, v+ov/2, "A", text_style, false, false) 
  lib.add_text(ov+x+y, v+ov/2, "B", text_style, false, false) 
  lib.add_text(ov, ow+w, "C", text_style, false, false)    
  lib.add_input(ov-v+ow, ov+2*ow, 150, 30, lib.check_string(reply[ind], 120))
  
  lib.end_canvas()
end
            
        
           