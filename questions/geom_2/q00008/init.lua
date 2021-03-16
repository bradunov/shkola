
yelow_style = 
	{["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "1"};

red_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
green_style = 
	{["off_color"] = "cf9",
        ["on_color"] = "cf9",
        ["line_color"] = "000",
        ["line_width"] = "1"};	

dot_style = {["font_size"] = "20"}	
text_style = {["font_size"] = "16"}

meas = "cm"

rad_a = 2 + math.random(5)
rad_c = rad_a + 2 + math.random(10 - rad_a)
rad_b = rad_c + 2 + math.random(15 - rad_c)

circ = (rad_a + rad_b + rad_c) * 2

mycanvas = function(no)
  lib.start_canvas(300, 220, "center")

  ov = 50
  ow = 20
   
  lib.add_circle(3*ov-4, 2*ow, ov-ow, red_style, true, false)
  lib.add_text(2*ov+5, ov-ow, "a")
  lib.add_text(3*ov-4, 2*ow-5, ".", dot_style, false, false)
  lib.add_text(3*ov-4, ov-ow-1, "A", text_style)
  lib.add_circle(3*(ov+ow)+3, ov+2*ow-4, ov, yelow_style, false, false) 
  lib.add_text(5*ov, 3*ov-ow+5, "c")
  lib.add_text(3*(ov+ow)+3, ov+2*ow-9, ".", dot_style, false, false)
  lib.add_text(3*(ov+ow)+3, ov+ow+5, "C", text_style)
  lib.add_circle(2*ov, 3*ov-ow, ov+ow, green_style, false, false)	  
  lib.add_text(ow, 2*ov+ow, "b")
  lib.add_text(2*ov, 3*ov-ow-4, ".", dot_style, false, false)	
  lib.add_text(2*ov, 2*ov+ow-1, "B", text_style)  
		       
  lib.end_canvas()
end           
       
    

        
          
                   
         
        
       
            
    
          
          
    
    
                  
                
                