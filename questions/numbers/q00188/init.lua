
style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["opacity"] = "0.5",
        ["line_width"] = "1"};
		
diff_style = 
       {["off_color"] = "f9c",
        ["on_color"] = "f9c",
        ["line_color"] = "000",
        ["opacity"] = "0.3",
        ["line_width"] = "1"};		

text_style = {["font_size"] = "14"}

term = {}
result = {}
index = {}
out = {}
sign = {"+", "-"}

value = math.random(8888) + 1111;
term[1] = 999 + math.random(value - 1000)
term[2] = 699 + math.random(value - 700)
term[3] = 399 + math.random(value - 400)

for i = 1,3 do
    index[i] = math.random(2)
    if ( index[i] == 1) then
        result[i] = value + term[i]
	else	
	    result[i] = value - term[i]
	end
end	

test = {1,2,3}
out = lib.math.random_shuffle(test)

mycanvas = function(no)
  lib.start_canvas(350, 250, "center")
  
  w = 20
  ow = 60
  
  lib.add_rectangle (2*ow, w, ow, w, diff_style, true, false)
  lib.add_text(5*ow/2, 3*w/2, value, text_style)
 
  for i = 1,3 do
      grad = i - 2 
      x = i*ow + (i-1)*w 
      y = w + (i-1)*(ow + 2*w)  
      lib.add_straight_path (x-ow*grad+w/2, 5*w/2, {{ow*grad, ow}}, style, false, false) 
      lib.add_straight_path (x+7-5*grad, ow+2*w+5, {{3+7*grad, 7}, {3-7*grad, -7}}, style, false, false) 

      lib.add_straight_path (x+w/2, 15*w/2, {{-ow*grad, ow}}, style, false, false) 
      lib.add_straight_path (x+7-(ow-4)*grad, 3*ow+w+5, {{3-7*grad, 7}, {3+7*grad, -7}}, style, false, false) 

	  if (out[i] == 1) then
          answ1 = sign[index[i]] .. tostring(term[i])
          lib.add_text(x-grad*w/2, 7*w/2, answ1, text_style)
          answ2 = sign[3-index[i]] .. tostring(term[i])	  
 	      lib.add_input(x-w-grad*w/2, 8*w, ow, 2*w, lib.check_string(answ2,40))         
          lib.add_input(y, 2*ow-5, ow, 2*w, lib.check_number(result[i],40))	
      end

	  if (out[i] == 2) then
          answ1 = sign[index[i]] .. tostring(term[i])
	      lib.add_input(x-w-grad*w/2, 3*w, ow, 2*w, lib.check_string(answ1,40))
          answ2 = sign[3-index[i]] .. tostring(term[i])	  
          lib.add_text(x-grad*w/2, 17*w/2, answ2, text_style)	  	  
          lib.add_input(y, 2*ow-5, ow, 2*w, lib.check_number(result[i],40))	
      end	

	  if (out[i] == 3) then
          answ1 = sign[index[i]] .. tostring(term[i])
	      lib.add_input(x-w-grad*w/2, 3*w, ow, 2*w, lib.check_string(answ1,40))
          answ2 = sign[3-index[i]] .. tostring(term[i])	  
          lib.add_input(x-w-grad*w/2, 8*w, ow, 2*w, lib.check_string(answ2,40))	 
          lib.add_rectangle (y, 2*ow, ow, w, style, false, false)		  
          lib.add_text(y+ow/2, 13*w/2, tostring(result[i]), text_style)	
      end		  	  
   end

  lib.add_rectangle (2*ow, 4*ow-w, ow, w, diff_style, true, false)
  lib.add_text(5*ow/2, 4*ow-w/2, value, text_style)   
   
  lib.end_canvas()
end      
    
            
        
     