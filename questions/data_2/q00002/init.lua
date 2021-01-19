
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
diff_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

red_style = 
	{["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "f30",
        ["line_width"] = "3"};			

text_style = {["font_size"] = "16"}

blue_style = 
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "0cf",
        ["line_width"] = "3"};			

text_style = {["font_size"] = "16"}


dim = 16

x1 = 2
y1 = 2
dif1 = dim - 2 - x1
mx = x1 + dif1/2
my = y1 + dif1/2

x2 = 2 + math.random(3)
y2 = dim -1 - math.random(3)

x3 = 2 * mx - x2
y3 = 2 * my - y2
dif2 = x3 - x2
dif3 = y2 - y3


min = 2
max = dim - 4 - min
xaxis = min + math.random(max - min)
yaxis = min + math.random(max - min)

ax = x1 - 2 - yaxis
ay = xaxis - y1 + 2
bx = ax + dif1
by = ay - dif1
cx = x2 - 2 - yaxis
cy = xaxis - y2 + 2
dx = x3 - 2 - yaxis
dy = xaxis - y3 + 2
mmx = mx - 2 - yaxis
mmy = xaxis - my + 2

mycanvas = function()

  lib.start_canvas(300, 280, "center")

  w = math.floor(270/dim) 
  ow = 10
  
  for i = 2,dim do
     lib.add_line(ow+(i-1)*w, ow, 0, dim*w, style, false, false)
  end
  
  for i = 2,dim do
    lib.add_line(ow, ow+(i-1)*w, dim*w, 0, style, false, false)
  end

  lib.add_line(ow, ow+(xaxis+2)*w, dim*w, 0, diff_style, false, false)
  lib.add_line(ow+(yaxis+2)*w, ow, 0, dim*w, diff_style, false, false)

  lib.add_line(ow+x1*w, ow+y1*w, dif1*w, dif1*w, red_style, false, false)
  lib.add_line(ow+x2*w, ow+y2*w, dif2*w, -dif3*w, blue_style, false, false)

  lib.add_straight_path(ow+(dim-1)*w, ow+(xaxis+2)*w-3, {{ow, ow/4}, {-ow, ow/4}}, diff_style, false, false)
  lib.add_text(ow+(dim-1)*w+5, ow+(xaxis+3)*w-3, "x", text_style) 
  lib.add_straight_path(ow+(yaxis+2)*w-3, 2*ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(yaxis+3)*w, 2*ow, "y", text_style) 
  
  lib.add_text(x1*w, y1*w, "A", text_style)  
  lib.add_circle (ow+x1*w, ow+y1*w, 3, red_style, false, false ) 
   
  lib.add_text((2*x1+dif1-2)*w, (2*y1+dif1)*w-ow, "B", text_style) 
  lib.add_circle (ow+(2*x1+dif1-2)*w, ow+(2*y1+dif1-2)*w, 3, red_style, false, false )   
   
  lib.add_text(x2*w, 2*ow+y2*w, "C", text_style) 
  lib.add_circle (ow+x2*w, ow+y2*w, 3, blue_style, false, false ) 
  
  lib.add_text(x3*w, y3*w, "D", text_style)   
  lib.add_circle (ow+x3*w, ow+y3*w, 3, blue_style, false, false ) 
  
  lib.add_text(mx*w-ow, my*w+ow, "M", text_style)
  lib.add_circle (ow+mx*w, ow+my*w, 3, diff_style, false, false )  

  lib.end_canvas()
end                                 
                                    
                                  
     
              
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
      
            
                
            
            
     
            
            
   
        
       
             
       