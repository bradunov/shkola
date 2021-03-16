
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

index = {}
quest = {}
reply = {}
ans = {}

quest[1] = "a \(\cap\) d " 
quest[2] = "f \(\cap\) a " 
quest[3] = "a \(\cap\) c " 
quest[4] = "b \(\cap\) d " 
quest[5] = "c \(\cap\) b "
quest[6] = "b \(\cap\) f " 
quest[7] = "f \(\cap\) d " 
quest[8] = "c \(\cap\) f " 
quest[9] = "EG \(\cup\) FP "
quest[10] = "EG \(\cap\) FP " 
quest[11] = "DH \(\cup\) CD "
quest[12] = "BG \(\cap\) BD " 
quest[13] = "CF \(\cap\) DH "
quest[14] = "CF \(\cup\) DH " 
quest[15] = "EP \(\cup\) EG "
quest[16] = "BG \(\cap\) CF " 
quest[17] = "BG \(\cap\) EP " 
quest[18] = "(CF \(\cup\) EF) \(\cap\) BG "
quest[19] = "(a \(\cap\) b) \(\cup\) f "
quest[20] = "(a \(\cap\) c) \(\cup\) AE " 


reply[1] = "answer == '" .. "B" .. "' "  ..
        "|| answer == '" .. "B" .. "'" ;
ans[1] = "answer = '" .. "B" .. "' ";
reply[2] = "answer == '" .. "C" .. "' "  ..
        "|| answer == '" .. "C" .. "'" ;
ans[2] = "answer = '" .. "C" .. "' ";
reply[3] = "answer == '" .. "A" .. "' "  ..
        "|| answer == '" .. "A" .. "'" ;
ans[3] = "answer = '" .. "A" .. "' ";
reply[4] = "answer == '" .. "G" .. "' "  ..
        "|| answer == '" .. "G" .. "'" ;
ans[4] = "answer = '" .. "G" .. "' ";
reply[5] = "answer == '" .. "E" .. "' "  ..
        "|| answer == '" .. "E" .. "'" ;
ans[5] = "answer = '" .. "E" .. "' ";
reply[6] = "answer == '" .. "F" .. "' "  ..
        "|| answer == '" .. "F" .. "'" ;
ans[6] = "answer = '" .. "F" .. "' ";
reply[7] = "answer == '" .. "D" .. "' "  ..
        "|| answer == '" .. "D" .. "'" ;
ans[7] = "answer = '" .. "D" .. "' ";
reply[8] = "answer == '" .. "H" .. "' "  ..
        "|| answer == '" .. "H" .. "'" ;
ans[8] = "answer = '" .. "H" .. "' ";
reply[9] = "answer == '" .. "EP" .. "' "  ..
        "|| answer == '" .. "PE" .. "'" ;
ans[9] = "answer = '" .. "EP" .. "' ";
reply[10] = "answer == '" .. "FG" .. "' "  ..
        "|| answer == '" .. "GF" .. "'" ;
ans[10] = "answer = '" .. "FG" .. "' ";
reply[11] = "answer == '" .. "CH" .. "' "  ..
        "|| answer == '" .. "HC" .. "'" ;
ans[11] = "answer = '" .. "CH" .. "' ";
reply[12] = "answer == '" .. "BD" .. "' "  ..
        "|| answer == '" .. "DB" .. "'" ;
ans[12] = "answer = '" .. "BD" .. "' ";
reply[13] = "answer == '" .. "DF" .. "' "  ..
        "|| answer == '" .. "FD" .. "'" ;
ans[13] = "answer = '" .. "DF" .. "' ";
reply[14] = "answer == '" .. "CH" .. "' "  ..
        "|| answer == '" .. "HC" .. "'" ;
ans[14] = "answer = '" .. "CH" .. "' ";
reply[15] = "answer == '" .. "EP" .. "' "  ..
        "|| answer == '" .. "PE" .. "'" ;
ans[15] = "answer = '" .. "EP" .. "' ";
reply[16] = "answer == '" .. "D" .. "' "  ..
        "|| answer == '" .. "D" .. "'" ;
ans[16] = "answer = '" .. "D" .. "' ";
reply[17] = "answer == '" .. "G" .. "' "  ..
        "|| answer == '" .. "G" .. "'" ;
ans[17] = "answer = '" .. "G" .. "' ";
reply[18] = "answer == '" .. "D" .. "' "  ..
        "|| answer == '" .. "D" .. "'" ;
ans[18] = "answer = '" .. "D" .. "' ";
reply[19] = "answer == '" .. "f" .. "' "  ..
        "|| answer == '" .. "f" .. "'" ;
ans[19] = "answer = '" .. "f" .. "' ";
reply[20] = "answer == '" .. "AE" .. "' "  ..
        "|| answer == '" .. "EA" .. "'" ;
ans[20] = "answer = '" .. "AE" .. "' ";

for i = 1,20 do
    index[i] = i
end
out = lib.math.random_shuffle(index)

ow = 10
w = 250
ov = 150
v = 40


mycanvas = function(no)
  lib.start_canvas(300, 180, "center")
  
  lib.add_straight_path(ow, v, {{w, 0}}, style, true, false)
  lib.add_straight_path(ow, w-ov, {{w, 0}}, style, true, false)  
  lib.add_straight_path(v-ow, ow/2, {{3*v/2, ov}}, style, true, false)  
  lib.add_straight_path(ov-v, ow/2, {{3*v/2, ov}}, style, true, false) 
  lib.add_straight_path(ow, ov+ow/2, {{w, -ov}}, style, true, false)   

  lib.add_text(2*ow, v+ow/2, "a", text_style, false, false)  
  lib.add_text(2*ow, 3*v-ow, "b", text_style, false, false)
  lib.add_text(2*v+3*ow/2, ov-ow, "c", text_style, false, false)
  lib.add_text(ov+5*ow/2, ov-ow, "d", text_style, false, false)
  lib.add_text(w, 2*ow, "f", text_style, false, false)

  lib.add_text(v+3, 3*ow-2, ".", dot_style, false, false)
  lib.add_text(v+ow, 5*ow/2+3, "A", text_style, false, false)
  lib.add_text(ov-5*ow/2, 3*ow-2, ".", dot_style, false, false)
  lib.add_text(ov-2*ow, 5*ow/2+3, "B", text_style, false, false)
  lib.add_text(2*(w-ov+1), 3*ow-2, ".", dot_style, false, false)
  lib.add_text(2*(w-ov), 5*ow/2+3, "C", text_style, false, false)
  lib.add_text(ov-ow, 6*ow+5, ".", dot_style, false, false)
  lib.add_text(ov-ow+3, 6*ow+3, "D", text_style, false, false)
  lib.add_text(2*(v-ow)+7, 2*v+8, ".", dot_style, false, false)
  lib.add_text(2*v-ow, 2*v+7, "E", text_style, false, false)
  lib.add_text(2*(v+ow)+2, 2*v+8, ".", dot_style, false, false)
  lib.add_text(2*(v+ow)+5, 2*v+7, "F", text_style, false, false)
  lib.add_text(ov-2, 2*v+8, ".", dot_style, false, false)
  lib.add_text(ov+3, 2*v+7, "G", text_style, false, false)
  lib.add_text(2*v-5, ov-v-5, ".", dot_style, false, false)
  lib.add_text(2*v-ow, ov-2*ow, "H", text_style, false, false)
  lib.add_text(w-ow, 2*v+ow-2, ".", dot_style, false, false)
  lib.add_text(w-ow, 3*v-5, "P", text_style, false, false)
    
  lib.end_canvas()
end

          