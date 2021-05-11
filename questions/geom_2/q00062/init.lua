
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
					
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "14"}	
letter_style = {["font_size"] = "16"}	

meas = "\(^\circ\)"
symb = "\(\angle\)"
trian = "\(\small\triangle\)"
eq =  "\(\small\cong\)"

numb = {}
ang = {}
index = {}
out = {}

ang = {"α", "β", "γ"}
name = {"CEF", "DEF", "ADF", "BED", "ABC"}

sign = math.random(3)
numb[1] = 80 +(2 - sign) * math.random(20)
sign = math.random(3)
numb[2] = 40 +(2 - sign) * math.random(20)
numb[3] = 180 - numb[1] - numb[2] 

ind = math.random(4)
small = name[ind]

for i = 1,4 do
    index[i] = i
end
out = lib.math.random_shuffle(index)	

small_1 = name[out[1]]
small_2 = name[out[2]]

reply = "answer == '" .. numb[1] .. "," .. numb[2] .. "," .. numb[3] .. "' "  ..
        "|| answer == '" .. numb[1] .. "," .. numb[3] .. "," .. numb[2] .. "' "  ..
        "|| answer == '" .. numb[2] .. "," .. numb[1] .. "," .. numb[3] .. "' "  ..
        "|| answer == '" .. numb[2] .. "," .. numb[3] .. "," .. numb[1] .. "' "  ..
        "|| answer == '" .. numb[3] .. "," .. numb[1] .. "," .. numb[2] .. "' "  ..
        "|| answer == '" .. numb[3] .. "," .. numb[2] .. "," .. numb[1] ..  "'" ;
ans = "answer = '" .. numb[1] .. "," .. numb[2] .. "," .. numb[3] .. "' ";

mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40

  lib.start_canvas(320, 170, "center")

    lib.add_straight_path(2*(ow+v)+3, 3*ow-2, {{w-2*v+ow-2, ov-v+2}}, style, true, false)  
    lib.add_straight_path(ov-v-3, 2*ow+6, {{-2*v+2*ow-4, ov-3*ow-3}}, style, true, false)  
    lib.add_straight_path(v, ov-ow, {{w-ow, 0}}, style, true, false)  
    lib.add_straight_path(2*v-5, 2*v+5, {{2*v+4*ow, 0}}, style, true, false) 
    lib.add_straight_path(ov+v+3, 2*v+5, {{-v+ow, 2*v-2*ow-4}}, style, true, false)  
    lib.add_straight_path(2*v-ow+4, 2*v+5, {{ov-v-2*ow, 2*v-2*ow-4}}, style, true, false)  

    lib.add_text(6*ow, ov-2*ow, ang[1], text_style) 
    lib.add_text(w-3, ov-2*ow, ang[2], text_style) 
    lib.add_text(2*v+3*ow, 5*ow-5, ang[3], text_style)  

    lib.add_text(v+ow-5, ov-2*ow-2, ".", dot_style)  
    lib.add_text(v+ow-5, ov+5, "A", letter_style) 
    lib.add_text(w+3*ow, ov-2*ow-2, ".", dot_style)  
    lib.add_text(w+3*ow, ov+5, "B", letter_style)
    lib.add_text(w-ov+5, 2*ow-2, ".", dot_style)   
    lib.add_text(w-ov+5, ow+3, "C", letter_style)   
    lib.add_text(ov+ow+5, ov+5, "D", letter_style) 
    lib.add_text(ov+v+5, 2*v-5, "E", letter_style)   
    lib.add_text(2*v-ow-3, 2*v-5, "F", letter_style)
	
  lib.end_canvas()
end 
  
     
     
  
          
            
            
            
          