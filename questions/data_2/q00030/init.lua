
style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "2"};			

text_style = {["font_size"] = "16"}

include("names")
include("terms")

name = {}
heig = {}
index = {}
ind = {}

for i = 1,5 do
    index[i] = i
end
ind = lib.math.random_shuffle(index)	
for i = 1,5 do
    name[i] = musko_ime_nom[ind[i]];
end	

aver = 185 + math.random(20)
sum = 0
for i = 1,4 do
    sign = math.random(2)
	if (sign == 1) then
        heig[i] = aver + math.random(5)
	else
        heig[i] = aver - math.random(5)	
    end	
	sum = sum + heig[i]
end
heig[5]	= 5 * aver - sum


mycanvas = function()

  lib.start_canvas(350, 250, "center")
 
  v = 30
  ov = 80
  w = 120
  ow = 20
  
     lib.add_line(v, ow, 0, ow+6*v, style, false, false)
     lib.add_line(2*v+w, ow, 0, ow+6*v, style, false, false)
     lib.add_line(v+2*w, ow, 0, ow+6*v, style, false, false)
	 
  for j = 1,5 do
    lib.add_line(v, ow+(j-1)*v, 2*w, 0, style, false, false)
  end

  lib.add_line(v, ow+5*v, 2*w, 0, red_style, false, false)
  lib.add_line(v, 2*ow+6*v, 2*w, 0, red_style, false, false)
 
  lib.add_text(ov, v, name[1], text_style, false, false)
  lib.add_text(ov+w+5, v, heig[1], text_style, false, false)
  lib.add_text(ov+w+v, v, "cm", text_style, false, false)  
  lib.add_text(ov, 2*v, name[2], text_style, false, false)
  lib.add_text(ov+w+5, 2*v, heig[2], text_style, false, false)
  lib.add_text(ov+w+v, 2*v, "cm", text_style, false, false)   
  lib.add_text(ov, 3*v, name[3], text_style, false, false)
  lib.add_input(ov+w-ow, 3*v-7, 60, 30, lib.check_number(heig[3], 30))  
  lib.add_text(ov+w+v+10, 3*v, "cm", text_style, false, false) 
  lib.add_text(ov, 4*v, name[4], text_style, false, false)
  lib.add_text(ov+w+5, 4*v, heig[4], text_style, false, false)
  lib.add_text(ov+w+v, 4*v, "cm", text_style, false, false)   
  lib.add_text(ov, 5*v, name[5], text_style, false, false)
  lib.add_text(ov+w+5, 5*v, heig[5], text_style, false, false)
  lib.add_text(ov+w+v, 5*v, "cm", text_style, false, false)   
  lib.add_text(w-ow, 6*v, msg[1], text_style, false, false)
  lib.add_text(w-ow, 6*v+ow, msg[2], text_style, false, false)
  lib.add_text(ov+w+5, 2*ov+v, aver, text_style, false, false)
  lib.add_text(ov+w+v, 2*ov+v, "cm", text_style, false, false)   
  
  lib.end_canvas()
end                 
  
               
     
  
    
            
            
            
           
   
   
        
    
   
        
       
             
       