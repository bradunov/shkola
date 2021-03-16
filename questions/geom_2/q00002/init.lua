
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

index = {}
answ = {}

answ = {"a \(\cap\) d = O",
  "O \(\in\) a", 
  "O \(\not\in\) d",  
  "b \(\ni\) N", 
  "b \(\not\ni\) M",   
  "a \(\parallel\) c", 
  "a \(\not\parallel\) d",   
  "b \(\parallel\) a", 
  "b \(\perp\) c",  
  "d \(\perp\) c",  
  "d \(\not\parallel\) c",  
  "M \(\in\) d", 
  "{P, Q} \(\subset\) b", 
  "{P, Q} \(\supset\) b",
  "N \(\in\) c",
  "M \(\not\in\) a \(\cup\) b \(\cup\) c \(\cup\) d",   
  "{N, P, Q} \(\subset\) b \(\cup\) c",   
  "Q = b \(\cap\) c" 
}

for i = 1,18 do
    index[i] = i
end
out = lib.math.random_shuffle(index)

ow = 10
w = 250
ov = 150
v = 40


mycanvas = function(no)
  lib.start_canvas(300, 180, "center")
  
  lib.add_straight_path(ow, v-ow, {{w, 0}}, style, true, false)
  lib.add_straight_path(ow, ov-v, {{w, 0}}, style, true, false)  
  lib.add_straight_path(2*v, ow/2, {{0, ov}}, style, true, false)  
  lib.add_straight_path(ov+v, ow/2, {{0, ov}}, style, true, false)  

  lib.add_text(5*ow/2, 2*ow, "a", text_style, false, false)  
  lib.add_text(5*ow/2, 2*(v+ow), "b", text_style, false, false)
  lib.add_text(2*v+ow, ov-ow, "c", text_style, false, false)
  lib.add_text(w-v-ow, ov-ow, "d", text_style, false, false)

  lib.add_text(ov+v, 2*ow-2, ".", dot_style, false, false)
  lib.add_text(ov+v+ow, ow+5, "O", text_style, false, false)
  lib.add_text(ov, 5*ow+3, ".", dot_style, false, false)
  lib.add_text(ov, 5*ow, "M", text_style, false, false)
  lib.add_text(2*v, ov/2, ".", dot_style, false, false)
  lib.add_text(2*v+ow+5, ov/2+ow, "N", text_style, false, false)
  lib.add_text(w-ow, 2*(v+ow), ".", dot_style, false, false)
  lib.add_text(w-ow, 3*v+5, "P", text_style, false, false)
  lib.add_text(v+ow, 2*(v+ow), ".", dot_style, false, false)
  lib.add_text(v+ow, 3*v+5, "Q", text_style, false, false)
    
  lib.end_canvas()
end
      
       
         
            