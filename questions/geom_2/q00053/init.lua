
include("terms")
 
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
						
text_style = {["font_size"] = "14"}		

meas = {"\(^\circ\)", "'"}
symb = "\(\small\angle\)"
numb = {"α", "β", "γ"}
ang = {"BAC", "CBA", "ACB"}
name = {"BC", "AC", "AB"}
answ = {"=", "<", ">"}
quest = {""}
            
mycanvas = function(no)

  ow = 5
  w = 125
  ov = 75
  v = 20

  lib.start_canvas(320, 100, "center") 
              
    lib.add_straight_path(ow, ov+2*ow, {{w+v+4*ow, 0}, {-2*v, -ov}, {-w, ov} }, style, true, false)  

    lib.add_text(v-2*ow, ov+4*ow, "A", text_style) 
    lib.add_text(w+2*v, ov+4*ow, "B", text_style)
    lib.add_text(w-ow, ow, "C", text_style) 
	
    lib.add_text(6*ow, ov, numb[1], text_style) 
    lib.add_text(w+6*ow, ov, numb[2], text_style) 
    lib.add_text(ov+2*(v+ow), 5*ow, numb[3], text_style)	
  
    quest[1] = numb[1] .. " = " .. symb .. ang[1] 
    quest[2] = numb[2] .. " = " .. symb .. ang[2] 
    quest[3] = numb[3] .. " = " .. symb .. ang[3] 
    lib.add_input(2*(ov+ow), 0, 150, 40, quest[1]) 
    lib.add_input(2*(ov+ow), 2*v-ow, 150, 40, quest[2]) 
    lib.add_input(2*(ov+ow), 4*v-2*ow, 150, 40, quest[3])   

  lib.end_canvas()
end      

          
         