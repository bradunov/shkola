
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
				
text_style = {["font_size"] = "16"}	

name = {"a", "b", "c", "h", "α", "β"}
ang = {30, 45, 60}
meas = {"°", "cm", "cm²"}

r2 = lib.math.round_dec(math.sqrt(2),3)
r3 = lib.math.round_dec(math.sqrt(3),3)

val = {}
out = {}

ind = math.random(6)
val[1] = 2 + math.random(17)  

if (ind == 1) then
    fst = 3
    sec = 2	
    val[4] = val[1] / r2	
    val[2] = r2 * val[1] / r3	
    val[3] = (1+1/r3) * val[4]
end	
if (ind == 2) then
    fst = 1
    sec = 2	
    val[4] = val[1] / r2	
    val[2] = r2 * val[1]	
    val[3] = (1+r3) * val[4]
end		
if (ind == 3) then
    fst = 2
    sec = 2	
    val[4] = val[1] / r2	
    val[2] = val[1] 	
    val[3] = r2 * val[1]
end			
if (ind == 4) then
    fst = 1
    sec = 3	
    val[4] = 0.5 * r3 * val[1] 	
    val[2] = 2 * val[4] 	
    val[3] = 2 * val[1]
end		
if (ind == 5) then
    fst = 1
    sec = 1	
    val[4] = 0.5 * val[1] 	
    val[2] = val[1] 	
    val[3] = r3 * val[1]
end		
if (ind == 6) then
    fst = 3
    sec = 3	
    val[4] = 0.5 * r3 * val[1] 	
    val[2] = val[1] 	
    val[3] = val[1]
end		
val[5] = val[1] + val[2] + val[3]	
val[6] = 0.5 * val[3] * val[4]

for i = 1,4 do	
    out[i] = lib.dec_to_str(lib.math.round_dec(val[i],3))
end
circ = lib.math.round_dec(val[5],1)	
area = lib.math.round_dec(val[6],1)	
	
ch = math.random(4)
if (ch == 4) then
    quest = msg[2]
else
    quest = msg[1]	
end	

mycanvas = function(no)

  ow = 8
  w = 200
  ov = 120
  v = 32

  lib.start_canvas(270, 110, "center") 
 
  lib.add_straight_path(4*v+3, ow-2, {{w-3*v-ow-2, ov-v+2}}, style, true, false)    
  lib.add_straight_path(ov+2*ow-5, ow-2, {{-4*v+ow-2, ov-3*ow-6}}, style, true, false)  
  lib.add_straight_path(ow+2, 3*v, {{w+2*ow-2, 0}}, style, true, false)  
  lib.add_straight_path(w-ov+v+3+2*ow, ow, {{0, 2*v+3*ow}}, dif_style, true, false) 
 
  lib.add_text(ov+2*v+ow, 2*(v-ow), name[1], text_style) 
  lib.add_text(2*(v-ow), 2*(v-ow), name[2], text_style) 
  lib.add_text(ov-ow, ov-2*ow, name[3], text_style) 
  lib.add_text(w-ov+v+ow, 2*(v-ow), name[4], text_style) 
  lib.add_text(v, ov-v, name[5], text_style)   
  lib.add_text(w, ov-v, name[6], text_style)   
    
  lib.end_canvas()
end 