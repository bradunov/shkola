
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "0cf",
        ["line_width"] = "1"};				
				
text_style = {["font_size"] = "14"}	

meas = "\(^\circ\)"
trian = "\(\small\triangle\)"
symb = "\(\small\angle\)"
ang = {"α", "β", "γ"}
 
name = {"BAH", "CAH", "BCT", "CTM"}

numb = {}
phi = {}

numb[1] = {}
phi[1] = 15 + math.random(20)
numb[1][1] = 90 - phi[1]
numb[1][2] = 2*phi[1]

numb[2] = {}
phi[2] = 2*(10 + math.random(20))
numb[2][2] = 90 - phi[2]
numb[2][1] = (90 + phi[2])/2

numb[3] = {}
phi[3] = 15 + math.random(20)
numb[3][2] = 2*phi[3]
numb[3][1] = 90 - phi[3]

numb[4] = {}
phi[4] = 10 + math.random(20)
numb[4][1] = 90 - phi[4]
numb[4][2] = 2*phi[4]

mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40

  lib.start_canvas(320, 190, "center") 
 
  lib.add_straight_path(ov-v-4, 3*ow-2, {{w-2*v-ow, ov-2*ow+2}}, style, true, false)    
  lib.add_straight_path(ov-v-4, 3*ow-2, {{-v-5, ov-2*ow+2}}, style, true, false)  
  lib.add_straight_path(v+2*ow, ov+ow, {{w-v-3, 0}}, style, true, false)  
  lib.add_straight_path(ov-v-3, 3*ow-2, {{0, ov-2*ow+3}}, dif_style, true, false)  
  lib.add_straight_path(w+2*ow-3, ov+ow, {{-ov-v+5, -2*v+ow+5}}, dif_style, true, false)    
  lib.add_straight_path(2*v, 2*v+ow+5, {{2*(v+ow)+5, 0}}, dif_style, true, false)    
  
  lib.add_text(w-ov+ow, ow+8, "A", text_style)   
  lib.add_text(v+2*ow, ov+2*ow, "B", text_style)  
  lib.add_text(w+ow, ov+2*ow, "C", text_style)
  lib.add_text(w-ov+ow, ov+2*ow, "H", text_style) 
  lib.add_text(v+3*ow, 2*(v+ow)-5, "T", text_style) 
  lib.add_text(2*(w-ov)+5, 2*(v+ow)-5, "M", text_style) 
    
  lib.add_text(2*v+3*ow+3, 5*ow-5, ang[1], text_style)  
  lib.add_text(2*v-5, ov, ang[2], text_style) 
  lib.add_text(w-5, ov, ang[3], text_style) 
   
  lib.end_canvas()
end 
     
  
  
          
            
            
            
          