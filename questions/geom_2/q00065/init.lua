
include("terms")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
blue_style = 
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "0cf",
        ["line_width"] = "2"};	

bl_style = 
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "0ff",
        ["line_width"] = "0.5"};		
				
text_style = {["font_size"] = "14"}	

meas = {"\(^\circ\)", "cm"}
trian = "\(\small\triangle\)"
symb = "\(\small\angle\)"
eq =  "\(\small\cong\)"
simil =  "\(\small\sim\)"
ort = "h\(\small_B\)"
ang = {"α", "β", "γ"}
name = {"DF", "FD", "EF", "FE", "FDE", "EDF", "DEH" }
rule = {"SSS", "SUS", "USU", "SSU"} 

edge = {}

value = 3 + math.random(6)
edge[3] = 2 * value
edge[1] = 3 + math.random(6)
if (edge[1] == edge[3]) then
    edge[1] = edge[1] + 1
end
edge[2] = edge[1] + math.random(20 - edge[1])	
if (edge[2] == edge[3]) then
    edge[2] = edge[2] + 1
end

reply1 = "answer == '" .. name[5] .. "' "  ..
        "|| answer == '" .. name[6] .. "'" ;
ans1 = "answer = '" .. name[5] .. "' ";

reply2 = "answer == '" .. name[1] .. "' "  ..
        "|| answer == '" .. name[2] .. "'" ;
ans2 = "answer = '" .. name[1] .. "' ";

reply3 = "answer == '" .. name[3] .. "' "  ..
        "|| answer == '" .. name[4] .. "'" ;
ans3 = "answer = '" .. name[3] .. "' ";

mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40

  lib.start_canvas(320, 170, "center") 
 
  lib.add_straight_path(2*(ow+v)+3, 3*ow-2, {{w-2*v+ow-2, ov-v+2}}, style, true, false)    
  lib.add_straight_path(ov-v-5, 3*ow-2, {{-2*v+2*ow-2, ov-3*ow-6}}, style, true, false)  
  lib.add_straight_path(v+2, ov-ow, {{w-ow-2, 0}}, style, true, false)  

  lib.add_straight_path(2*v-5, 2*v+5, {{2*v+4*ow, 0}}, dif_style, true, false) 
  lib.add_straight_path(2*(w-ov)-7, 2*v+5, {{-v+7, 2*v-2*ow-3}}, dif_style, true, false) 
  lib.add_straight_path(2*v-5, 2*v+5, {{2*v+6, 2*v-2*ow-4}}, dif_style, true, false) 
  lib.add_straight_path(w-ov+5, 3*ow, {{0, 2*v+3*ow}}, dif_style, true, false) 
  
  lib.add_straight_path(ov+v+4, 2*v+4, {{-2*v-ow, 2*v-2*ow-2}}, blue_style, true, false) 
  lib.add_straight_path(2*v-5, 2*v+5, {{v-ow+2, 2*v-2*ow-2}}, bl_style, true, false) 

  lib.add_text(w-ov+5, ow+6, "B", text_style)   
  lib.add_text(v+ow-5, ov, "C", text_style)  
  lib.add_text(w+3*ow, ov, "A", text_style)
  lib.add_text(2*v-ow-3, 2*v, "E", text_style)
  lib.add_text(ov+v+ow+2, 2*v, "D", text_style)   
  lib.add_text(ov+ow, ov, "F", text_style) 
  lib.add_text(w-ov+5, ov, "H", text_style) 
  
  lib.add_text(w-3, ov-2*ow, ang[1], text_style)   
  lib.add_text(2*v+3*ow+3, 5*ow-5, ang[2], text_style)  
  lib.add_text(6*ow, ov-2*ow, ang[3], text_style) 
   
  lib.end_canvas()
end 
  
  
  
          
            
            
            
          