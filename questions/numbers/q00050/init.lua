style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["opacity"] = "0.5",
        ["line_width"] = "1"};

text_style = {["font_size"] = "16"}

value = math.random(60) + 10;
w = 30
ow = 70
y = w + ow
grad = 1

mycanvas = function(no)
  lib.start_canvas(400, 200, "center")

  lib.add_rectangle (w+w/2-5, w-5, w, w, style, false, false)
  lib.add_text(2*w-5, w+w/2-5, value)

  for i = 1,6 do
      add = math.random(70) + 9;
      if (value < add) then
	      value = value + add
	      sign = "+"
		  if (value > 100) then
             temp = value - 100;              
             add = add - temp;
             value = value - temp;
          end
      else  
          znak = math.random(2)
	      if (znak == 1) then
	          value = value + add
	          sign = "+"
                  if (value > 100) then
                      value = value - 2*add
	              sign = "-"
                  end                   
              else
	          value = value - add
                  sign = "-"		  
	      end  
    end

   x = i*(w +w/2)
  
   lib.add_straight_path (x+w/2+10, y-grad*ow+(1+grad)*(w/2-10), {{w, grad*(y+w)}}, style, false, false) 

   if (grad == 1) then
      lib.add_straight_path (x+w/2+22, ow+3*w/4+15, {{4, 7}, {2, -7}}, style, false, false) 
      lib.add_text(x+w/2+5, ow+3*w/4, sign, text_style)  
      lib.add_text(x+w/2+20, ow+3*w/4, add, text_style)
   else 
      lib.add_straight_path (x+w/2+21, ow+3*w/4+17, {{4, -7}, {2, 7}}, style, false, false)
      lib.add_text(x+w/2+5, 3*(2*ow+w)/4, sign, text_style)  
      lib.add_text(x+w/2+20, 3*(2*ow+w)/4, add, text_style)     
   end

   lib.add_input(x+w+5, y+grad*ow, 50, 50, lib.check_number(value)) 

   grad = -grad
  end  

  lib.end_canvas()
end

      
      