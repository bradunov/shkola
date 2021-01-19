
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0"};
		
diff_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "3"};			

text_style = {["font_size"] = "14"}

total = 13 + math.random(5) 
k1 = 4 + math.random(6)
k2 = total - k1
if (k1 == k2) then
    k1 = k1 + 2
	k2 = k2 - 2
end	
max = k1
min = k2
if (k2 > k1) then
    max = k2
	min = k1
end	

xdim = max + 4
ydim = total + 4

xaxis = max - min + math.random(min - 2)
yaxis = min + math.random(max - 4)

ay = xaxis - max
ax = -yaxis
bx = -yaxis + min
cx = -yaxis + total

my = xaxis 
ny = xaxis - max + min

mycanvas = function()

  lib.start_canvas(350, 250, "center")

  w = math.floor(320/ydim) 
  ow = 10
  
  for i = 2,ydim do
     lib.add_line(ow+(i-1)*w, ow, 0, xdim*w, style, false, false)
  end
  
  for i = 2,xdim do
    lib.add_line(ow, ow+(i-1)*w, ydim*w, 0, style, false, false)
  end

  lib.add_line(ow, ow+(xaxis+2)*w, ydim*w, 0, diff_style, false, false)
  lib.add_line(ow+(yaxis+2)*w, ow, 0, xdim*w, diff_style, false, false)

  lib.add_line(ow+2*w, ow+2*w, 0, max*w, red_style, false, false)
  lib.add_line(ow+2*w, ow+(max+2)*w, total*w, 0, red_style, false, false)
  lib.add_line(ow+(total+2)*w, ow+(max+2)*w, 0, -min*w, red_style, false, false)
  lib.add_line(ow+2*w, ow+2*w, min*w, max*w, red_style, false, false)
  lib.add_line(ow+(min+2)*w, ow+(max+2)*w, max*w, -min*w, red_style, false, false)  

  lib.add_straight_path(ow+(total+3)*w+3, ow+(xaxis+2)*w-3, {{ow, ow/4}, {-ow, ow/4}}, diff_style, false, false)
  lib.add_text(ow+(total+3)*w+5, ow+(xaxis+3)*w-3, "x", text_style) 
  lib.add_straight_path(ow+(yaxis+2)*w-3, 2*ow, {{ow/4, -ow}, {ow/4, ow}}, diff_style, false, false)
  lib.add_text(ow+(yaxis+3)*w, 2*ow, "y", text_style) 

  pointa = "(" .. tostring(ax).. "," .. tostring(ay) .. ")"   
  lib.add_text(ow+2*w, 2*ow+(max+2)*w, pointa, text_style)   
  pointb = "(" .. tostring(bx).. "," .. tostring(ay) .. ")"   
  lib.add_text(ow+(min +2)*w, 2*ow+(max+2)*w, pointb, text_style)  
  pointc = "(" .. tostring(cx).. "," .. tostring(ay) .. ")"   
  lib.add_text(ow+(total+2)*w, 2*ow+(max+2)*w, pointc, text_style)  

  lib.add_text(ow+2*w, ow+w+3, "M", text_style) 
  lib.add_text(ow+(total+2)*w, ow+(max-min+1)*w+3, "N", text_style)  
 
  lib.end_canvas()
end       
                 
          
            
                
            
            
     
            
            
   
        
       
             
       