
red_style = {["off_color"] = "fff",
         ["on_color"] = "f30",
         ["line_color"] = "000",
         ["line_width"] = "2"};
		 
orange_style = {["off_color"] = "fff",
         ["on_color"] = "ffc266",
         ["line_color"] = "000",
         ["line_width"] = "2"};		 
		 
green_style = {["off_color"] = "fff",
               ["on_color"] = "fff",
               ["line_color"] = "3c3",
               ["line_width"] = "2"};

blue_style = {["off_color"] = "e0ebeb",
               ["on_color"] = "e0ebeb",
               ["line_color"] = "000",
               ["line_width"] = "2"};

brown_style = {["off_color"] = "c60",
               ["on_color"] = "c60",
               ["line_color"] = "000",
               ["line_width"] = "2"};

                                                                                                                                                                                                                                                                                              
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["off_line_color"] = "000",
        ["line_width"] = "3"}; 

text_style = {["font_size"] = "12"}


number = 1 + math.random(5)
apple = 20 * number
orange = 16 * number
number = number * 15

	
mycanvas = function()
  
  lib.start_canvas(350, 250, "center")

  ow = 20
  ov = 50
  v = 5
  
  lib.add_straight_path(ov, ov+ow, {{5*ov-v, 0}}, line_style, false, true)
  lib.add_circle (ov+v, 3*ow, 2*v, brown_style, false, false)
  lib.add_rectangle (ow-v, ov, ov+ow+v, ow/2, brown_style, false, false)
  lib.add_circle (6*ov-2*v, 3*ow, 2*v, brown_style, false, false)
  lib.add_rectangle (5*ov+v, ov, ov+ow+v, ow/2, brown_style, false, false)
  lib.add_triangle (3*ov+ow, ov+2*ow, ov-ow, ov-ow, brown_style, false, true)
  lib.add_circle (3*ov+ow, ov+ow, v, style, false, false)

  lib.add_rectangle(ow-2, ov-ow, ow-v, ow, blue_style, false, false)
  lib.add_circle(ow+v, ow+v, v, blue_style, true, false)
  lib.add_text(ow+v, 2*ow, tostring(number), text_style, false, false)
  lib.add_rectangle(2*ow-v+2, ov-ow, ow-v, ow, blue_style, false, false)
  lib.add_circle(2*ow+4, ow+v, v, blue_style, true, false)
  lib.add_text(2*ow+4, 2*ow, tostring(number), text_style, false, false)
  lib.add_rectangle(ov+6, ov-ow, ow-v, ow, blue_style, false, false)
  lib.add_circle(3*ow+4, ow+v, v, blue_style, true, false)
  lib.add_text(3*ow+4, 2*ow, tostring(number), text_style, false, false)
  lib.add_rectangle(4*ow-v, ov-ow, ow-v, ow, blue_style, false, false)
  lib.add_circle(4*ow+3, ow+v, v, blue_style, true, false)
  lib.add_text(4*ow+3, 2*ow, tostring(number), text_style, false, false)  
   
  lib.add_circle(5*ov+ow, 2*ow, 2*v, red_style, true, false)
  lib.add_straight_path(5*ov+ow-4, ow+v, {{v, v}, {v, -v},}, green_style, true, false)   
  lib.add_circle(6*ov-v, 2*ow, 2*v, red_style, true, false)
  lib.add_straight_path(6*ov-2*v, ow+v, {{v, v}, {v, -v},}, green_style, true, false)   
  lib.add_circle(6*ov+ow, 2*ow, 2*v, red_style, true, false)
  lib.add_straight_path(6*ov+ow-4, ow+v, {{v, v}, {v, -v},}, green_style, true, false)   
   
  
  lib.add_straight_path(ov, 4*ov, {{5*ov-v, 0}}, line_style, false, true)
  lib.add_circle (ov+v, 3*ov+2*ow, 2*v, brown_style, false, false)
  lib.add_rectangle (ow-v, 4*ov-ow, ov+ow+v, ow/2, brown_style, false, false)
  lib.add_circle (6*ov-2*v, 3*ov+2*ow, 2*v, brown_style, false, false)
  lib.add_rectangle (5*ov+v, 4*ov-ow, ov+ow+v, ow/2, brown_style, false, false)
  lib.add_triangle (3*ov+ow, 4*ov+ow, ov-ow, ov-ow, brown_style, false, true)
  lib.add_circle(3*ov+ow, 4*ov, v, style, false, false)
  
  lib.add_circle(ow, 3*ov+ow, 2*v, red_style, true, false) 
  lib.add_straight_path(ow-4, 3*ov+v, {{v, v}, {v, -v},}, green_style, true, false)  
  lib.add_circle(2*ow+2, 3*ov+ow, 2*v, red_style, true, false)
  lib.add_straight_path(2*ow-2, 3*ov+v, {{v, v}, {v, -v},}, green_style, true, false)   
  lib.add_circle(3*ow+4, 3*ov+ow, 2*v, red_style, true, false)
  lib.add_straight_path(3*ow, 3*ov+v, {{v, v}, {v, -v},}, green_style, true, false)   
  lib.add_circle(4*ow+v+1, 3*ov+ow, 2*v, red_style, true, false)
  lib.add_straight_path(4*ow+2, 3*ov+v, {{v, v}, {v, -v},}, green_style, true, false)     
    
  lib.add_circle(6*ov-ow-3, 3*ov+ow, 8, orange_style, true, false)   
  lib.add_circle(6*ov-v, 3*ov+ow, 8, orange_style, true, false)  
  lib.add_circle(6*ov+ow-v-3, 3*ov+ow, 8, orange_style, true, false)
  lib.add_circle(6*ov-ow+v, 3*ov+v, 8, orange_style, true, false)
  lib.add_circle(6*ov+v, 3*ov+v, 8, orange_style, true, false)

  lib.end_canvas()
end       
      
                   
            
                      
            
               
      

         
                           
                 
            
                    
            
                      
            