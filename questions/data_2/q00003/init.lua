
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0"};
		
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

blue_style = 
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "0cf",
        ["line_width"] = "3"};			

text_style = {["font_size"] = "14"}

dim = 14

x1 = 2
y1 = 2
dif1 = 8
mx = x1 + dif1/2
my = y1 + dif1/2

x2 = 4
y2 = 10
dif2 = 8
nx = x2 + dif2/2
ny = y2 - dif2/2

xaxis = 6
yaxis = 5


ax = x1 - 2 - yaxis
ay = xaxis - y1 + 2
bx = ax + dif1
by = ay - dif1
cx = x2 - 2 - yaxis
cy = xaxis - y2 + 2
dx = cx + dif2
dy = cy + dif2
mmx = mx - 2 - yaxis
mmy = xaxis - my + 2
nnx = nx - 2 - yaxis
nny = xaxis - ny + 2

ind = math.random(3)
ax = ax * ind
ay = ay * ind
bx = bx * ind
by = by * ind
cx = cx * ind
cy = cy * ind
dx = dx * ind
dy = dy * ind
mmx = mmx * ind
mmy = mmy * ind
nnx = nnx * ind
nny = nny * ind

index = math.random(4)

mycanvas = function()

  lib.start_canvas(350, 250, "center")

  w = math.floor(280/dim) 
  ow = 10
  
  for i = 2,dim do
     lib.add_line(ow+(i-1)*w, ow, 0, (dim-2)*w, style, false, false)
  end
  
  for i = 2,dim-2 do
    lib.add_line(ow, ow+(i-1)*w, dim*w, 0, style, false, false)
  end

  lib.add_line(ow, ow+(xaxis+2)*w, dim*w, 0, diff_style, false, false)
  lib.add_line(ow+(yaxis+2)*w, ow, 0, (dim-2)*w, diff_style, false, false)

  lib.add_line(ow+x1*w, ow+y1*w, dif1*w, dif1*w, red_style, false, false)
  lib.add_line(ow+x2*w, ow+y2*w, dif2*w, -dif2*w, blue_style, false, false)

  lib.add_straight_path(ow+(dim-1)*w, ow+(xaxis+2)*w-3, {{ow, ow/4}, {-ow, ow/4}}, diff_style, false, false)
  lib.add_text(ow+(dim-1)*w+5, ow+(xaxis+3)*w-3, "x", text_style) 
  lib.add_straight_path(ow+(yaxis+2)*w-3, 2*ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(yaxis+3)*w, 2*ow, "y", text_style) 

  if (index == 3) then
      pointa = "A (" .. tostring(math.floor(ax)).. "," .. tostring(math.floor(ay)) .. ")"    
      lib.add_text((x1+1)*w+ow, y1*w, pointa, text_style)    
  else 
      lib.add_text(x1*w+5, y1*w, "A (", text_style)    
      lib.add_input(x1*w+ow+3, y1*w-ow, 35, 30, lib.check_number(ax,20))
      lib.add_text((x1+1)*w+3*ow, y1*w, ",", text_style) 
      lib.add_input((x1+2)*w+ow, y1*w-ow, 35, 30, lib.check_number(ay,20)) 
      lib.add_text((x1+3)*w+2*ow+5, y1*w, ")", text_style)
  end  
  lib.add_circle (ow+x1*w, ow+y1*w, 3, red_style, false, false )

  lib.add_text((2*x1+dif1-2)*w, (2*y1+dif1-1)*w, "B (", text_style) 
  lib.add_input((2*x1+dif1-2)*w+8, (2*y1+dif1-1)*w-ow, 30, 30, lib.check_number(bx,15))
  lib.add_text((2*x1+dif1-1)*w+2*ow, (2*y1+dif1-1)*w, ",", text_style) 
  lib.add_input((2*x1+dif1)*w, (2*y1+dif1-1)*w-ow, 30, 30, lib.check_number(by,15)) 
  lib.add_text((2*x1+dif1+1)*w+ow, (2*y1+dif1-1)*w, ")", text_style)   
  lib.add_circle (ow+(2*x1+dif1-2)*w, ow+(2*y1+dif1-2)*w, 3, red_style, false, false )   
  
  pointc = "C (" .. tostring(cx).. "," .. tostring(cy) .. ")"   
  lib.add_text(x2*w+ow, 2*ow+y2*w, pointc, text_style)   
  lib.add_circle (ow+x2*w, ow+y2*w, 3, blue_style, false, false ) 

  if (index == 2) then
      pointd = "D (" .. tostring(math.floor(dx)).. "," .. tostring(math.floor(dy)) .. ")"    
      lib.add_text((x2+dif2)*w+5, (y2-dif2)*w, pointd, text_style)    
  else 
      lib.add_text((x2+dif2)*w+5, (y2-dif2)*w, "D (", text_style) 
      lib.add_input((x2+dif2)*w+ow+3, (y2-dif2)*w-ow, 35, 30, lib.check_number(dx,20))
      lib.add_text((x2+dif2+1)*w+3*ow, (y2-dif2)*w, ",", text_style) 
      lib.add_input((x2+dif2+2)*w+ow+3, (y2-dif2)*w-ow, 35, 30, lib.check_number(dy,20)) 
      lib.add_text((x2+dif2+3)*w+3*ow, (y2-dif2)*w, ")", text_style) 
  end  
  lib.add_circle (ow+(x2+dif2)*w, ow+(y2-dif2)*w, 3, blue_style, false, false ) 

  if (index == 1) then
      pointm = "M (" .. tostring(math.floor(mmx)).. "," .. tostring(math.floor(mmy)) .. ")"    
      lib.add_text((mx-2)*w+ow, my*w+ow, pointm , text_style)    
  else
      lib.add_text((mx-3)*w-ow, my*w+ow, "M (", text_style)  
      lib.add_input((mx-3)*w, my*w, 30, 30, lib.check_number(mmx,15))
      lib.add_text((mx-2)*w+ow, my*w+ow, ",", text_style) 
      lib.add_input((mx-1)*w-ow, my*w, 30, 30, lib.check_number(mmy,15)) 
      lib.add_text(mx*w, my*w+ow, ")", text_style)    
  end
  lib.add_circle (ow+mx*w, ow+my*w, 3, diff_style, false, false )  

  if (index == 4) then
      pointn = "N (" .. tostring(math.floor(nnx)).. "," .. tostring(math.floor(nny)) .. ")"    
      lib.add_text((nx+2)*w, (ny+1)*w-ow, pointn, text_style)    
  else
      lib.add_text((nx+1)*w+ow, (ny+1)*w-ow, "N (", text_style)  
      lib.add_input((nx+1)*w+ow+8, (ny+1)*w-2*ow, 30, 30, lib.check_number(nnx,15))
      lib.add_text((nx+2)*w+3*ow, (ny+1)*w-ow, ",", text_style) 
      lib.add_input((nx+3)*w+ow, (ny+1)*w-2*ow, 30, 30, lib.check_number(nny,15)) 
      lib.add_text((nx+5)*w, (ny+1)*w-ow, ")", text_style) 
  end 	  
  lib.add_circle (ow+nx*w, ow+ny*w, 3, diff_style, false, false )    

  lib.end_canvas()
end                         
                             
              
              
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
      
            
                
            
            
     
            
            
   
        
       
             
       