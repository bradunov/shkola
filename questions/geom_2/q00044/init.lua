                                                                                                                                                                                               
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};
		
blue_style = 
        {["line_color"] = "0cf",
        ["off_line_color"] = "0cf",
        ["line_width"] = "1"};		
		
red_style = 
	{["line_color"] = "f30",
        ["off_line_color"] = "f30",
        ["line_width"] = "2"};			
						
		
dot_style = {["font_size"] = "40"}
		
text_style = {["font_size"] = "16"}		


y = {}
mark = {"a", "b", "s"}
symb = "\(\angle\)"

ow = 20
ov = 150
v = 10

x = 11 * ow
tmp = math.random(5)
ang = 11 - tmp
tng = math.tan(math.pi/ang) 
tng2 =  2*tng/(1 - tng*tng)

y[1] = 10 * ow * tng
y[2] = 10 * ow * tng2

ind = math.random(4)
if (ind == 1) then
    reply = msg[1]
else
    reply = msg[2]	
end	

mycanvas = function(no)
  lib.start_canvas(320, 300, "center")
  
  if (ind == 1) then
      lib.add_line(2*ow, 2*ov-ow-v, x, -y[1], red_style, false, false)
      lib.add_text(2*(ov-ow), 2*(ov-ow)-y[1], "s", text_style, false, false)	 	  
      lib.add_line(2*ow, 2*ov-ow-v, x, -y[2], style, false, false) 
      pos = 2*ov-ow-y[2]
      if (pos < ow) then
          pos = ow
      end
      lib.add_text(x, pos, "b", text_style, false, false) 
      xs = 8*ow/(1+tng*tng2)
      ys = xs * tng2	  
      lib.add_line(10*ow, 2*ov-ow-v, -8*ow+xs+3, -ys+3, blue_style, true, false)  
      lib.add_line(10*ow-4+(-8*ow+xs)/4, 2*ov-ow-v+(-ys+3)/4, v, 0, blue_style, false, false)    
      lib.add_line(10*ow-4+3*(-8*ow+xs)/4, 2*ov-ow-v+3*(-ys+3)/4, v, 0, blue_style, false, false)     
  end  
  if (ind == 2) then
      lib.add_line(2*ow, 2*ov-ow-v, x, -y[2]/2, red_style, false, false)
	  lib.add_text(2*(ov-ow), 2*(ov-ow)-y[2]/2, "s", text_style, false, false) 
      lib.add_line(2*ow, 2*ov-ow-v, x, -y[2], style, false, false)
      lib.add_text(5*ow, 2*ov-ow-y[2]/2, "b", text_style, false, false) 
      tmp = -y[2]*8*ow/x  
	  lib.add_line(10*ow, 2*ov-ow-v, 0, tmp, blue_style, true, false) 
      lib.add_line(10*ow-5, 2*ov-ow-v+tmp/4, v, 0, blue_style, false, false)    
      lib.add_line(10*ow-5, 2*ov-ow-v+3*tmp/4, v, 0, blue_style, false, false)      	  
  end  
  if (ind == 3) then
      lib.add_line(2*ow, 2*ov-ow-v, x, -y[1], style, false, false)
      lib.add_text(2*(ov-ow), 2*(ov-ow)-y[1], "b", text_style, false, false)	 	  
      lib.add_line(2*ow, 2*ov-ow-v, x, -y[2], red_style, false, false) 
      pos = 2*ov-ow-y[2]
      if (pos < ow) then
          pos = ow
      end
      lib.add_text(x, pos, "s", text_style, false, false)	
      xs = 8*ow/(1+tng*tng2)
      ys = xs * tng2	  
      lib.add_line(10*ow, 2*ov-ow-v, -8*ow+xs+3, -ys+3, blue_style, true, false)  
      lib.add_line(10*ow-4+(-8*ow+xs)/4, 2*ov-ow-v+(-ys+3)/4, v, 0, blue_style, false, false)    
      lib.add_line(10*ow-4+3*(-8*ow+xs)/4, 2*ov-ow-v+3*(-ys+3)/4, v, 0, blue_style, false, false)     
  end    

 if (ind == 4) then	  
      lib.add_line(2*ow, 2*ov-ow-v, x, -y[2], style, false, false) 
      lib.add_text(5*ow, 2*ov-ow-y[2]/2, "b", text_style, false, false)	  
      xs = 8*ow/(1+tng2*tng2)
      ys = xs * tng2
      lib.add_line(10*ow, 2*ov-ow-v, -8*ow+xs+3, -ys+3, blue_style, true, false) 
      lib.add_line(10*ow-4+(-8*ow+xs)/4, 2*ov-ow-v+(-ys+3)/4, v, 0, blue_style, false, false)    
      lib.add_line(10*ow-4+3*(-8*ow+xs)/4, 2*ov-ow-v+3*(-ys+3)/4, v, 0, blue_style, false, false) 
	  tmp = 0.5*(ys+ow)*x/(6*ow+xs/2)
      lib.add_line(2*ow, 2*ov-ow-v, x, -tmp, red_style, false, false)
	  lib.add_text(2*(ov-ow), 2*ov-ys/2-tmp, "s", text_style, false, false) 	  
  end			
  
  lib.add_line(2*ow, 2*(ov-ow)+v, ov+4*ow, 0, style, true, false)
  lib.add_text(2*(ov-ow), 2*(ov-ow), "a", text_style, false, false)
   			 
  lib.add_text (2*ow, 2*(ov-ow), ".", dot_style, false, false)
  lib.add_text(2*ow, 2*ov-ow+3, "O", text_style, false, false)
 
  for i = 1,15 do
    lib.add_line(ow, v+(i-1)*ow, 14*ow, 0, grid_style, false, false)
  end

  for i = 1,15 do
    lib.add_line(ow+(i-1)*ow, v, 0, 14*ow, grid_style, false, false)
  end  
 		
  lib.end_canvas()
end