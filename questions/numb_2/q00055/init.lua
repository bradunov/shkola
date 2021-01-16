
include("terms")

line_blue = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "0cf",
        ["line_width"] = "3"};
		
line_green = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "6f6",
        ["line_width"] = "3"};	

	
text_style = {["font_size"] = "16"}

foot = 20 + math.random(30);
basket = 25 + math.random(25);

result = 5 + math.random(10);
resf = foot - result 
resb = basket - result 
number = foot + basket - result     
                
 mycanvas = function(no)
  lib.start_canvas(350, 220, "center")

  ov = 50
  ow = 20
  
  lib.add_ellipse(4*ov, 2*ov+ow, ov+ow, 2*ov-ow, line_blue, false, false) 
  lib.add_text(4*ov, ow, sport[2], text_style)

  lib.add_circle(2*ov+ow, 3*ov-ow, ov+ow, line_green, false, false)	  
  lib.add_text(2*ov, 2*ow, sport[1], text_style)	  

  lib.add_input(2*ov-ow, 2*(ov+ow), 40, 30, lib.check_number(resf,20))
  lib.add_input(2*(ov+ow), 2*ov+ow, 40, 30, lib.check_number(result,20))
  lib.add_input(4*ov, 2*ov, 40, 30, lib.check_number(resb,20))	  
        
  lib.end_canvas()
end                             
                  
                  
                  
        
               

