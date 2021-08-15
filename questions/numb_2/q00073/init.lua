
style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["opacity"] = "0.5",
        ["line_width"] = "1"};

dif_style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "0cf",
        ["line_width"] = "1"};			

text_style = {["font_size"] = "14"}

v = -25

w = 30
ow = 70
y = w + ow
grad = 1

min_range = 100
max_range = 249
  
value = min_range - math.random(max_range);  

mycanvas = function()
  lib.start_canvas(330, 210, "center")
  
  lib.add_rectangle (v+w+w/2+5, w-10, w+10, w-5, dif_style, false, false)
           lib.add_input(v+2*w-15, w+w/2-25, 50, 30, tostring(value))

  for i = 1,6 do
      add = min_range - math.random(max_range);
	  value = value + add
      ind = math.random(2)   
      x = i*(w +w/2) 
      lib.add_straight_path (v+x+w/2+10, y-grad*ow+(1+grad)*(w/2-10), {{w, grad*(y+w)}}, style, false, false) 
      if (grad == 1) then
         lib.add_straight_path (v+x+w/2+22, ow+3*w/4+15, {{4, 7}, {2, -7}}, style, false, false) 
         if (ind == 1) then
             lib.add_rectangle (v+x+w/2-5, ow+3*w/4-20, w+10, w-5, dif_style, false, false)  
             lib.add_input(v+x+w/2-10, ow+3*w/4-15, 50, 30, tostring(add))		 
         else
             lib.add_input(v+x+w/2-10, ow+3*w/4-20, 50, 30, lib.check_number(add,30))
         end
      else 
         lib.add_straight_path (v+x+w/2+21, ow+3*w/4+17, {{4, -7}, {2, 7}}, style, false, false) 
         if (ind == 1) then 
             lib.add_rectangle (v+x+w/2, 3*(2*ow+w)/4-5, w+10, w-5, dif_style, false, false) 
             lib.add_input(v+x+w/2-5, 3*(2*ow+w)/4-5, 50, 30, tostring(add))  
         else 
             lib.add_input(v+x+w/2, 3*(2*ow+w)/4-5, 50, 30, lib.check_number(add,30))   
         end
      end
      if (ind == 1) then
          lib.add_input(v+x+w+5, y+grad*ow, 50, 50, lib.check_number(value)) 
	  else
         lib.add_rectangle (v+x+w+5, y+grad*(ow+5)-5, w+10, w-5, dif_style, false, false) 
         lib.add_input(v+x+w, y+grad*(ow+7)-5, 50, 50, tostring(value)) 	  
     end
         grad = -grad
  end  

  lib.end_canvas()
end

             
       
       
      