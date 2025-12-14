
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

line_red = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "f90",
        ["line_width"] = "3"};
	
numb = {}
numb[1] = 100 + math.random(100);   
numb[2] = 200 + math.random(100)    
numb[3] = 50 + math.random(numb[1]-80)      
numb[4] = 20 + math.random(30);  

total = numb[1] + numb[2] - numb[3] + numb[4]
 
mycanvas = function(no)
  lib.start_canvas(300, 80, "center")

  ov = 32
  ow = 8
  w = 40
  
  lib.add_ellipse(3*ov+ow, w, 2*(ov-ow), ov-ow,  line_green, false, false) 
  lib.add_ellipse(2*ov-ow, w, 2*(ov-ow), ov-ow, line_red, false, false)	  
  lib.add_ellipse(7*ov, w, 2*(ov-ow), ov-ow, line_blue, false, false)	  
  
  lib.end_canvas()
end           