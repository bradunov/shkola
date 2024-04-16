
style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

text_style = {["font_size"] = "14"}

a = 21 + math.random(38)
b = 31 + math.random(48)
c = 41 + math.random(58)

summ_ab = a + b
summ_ac = a + c
summ_bc = b + c

ind = math.random(3)

w = 25

mycanvas = function(no)
  lib.start_canvas(250, 180, "center")

  lib.add_triangle (4*w, 4*w, 5*w, 5*w, style, false, false )
                    
  if (ind == 1) then
     temp1 = tostring(math.floor(summ_ab))
	 lib.add_rectangle(2*w, 7*w/2, w, w, style, false, false)
     lib.add_text(5*w/2, 4*w, temp1, text_style)
     temp2 = tostring(math.floor(summ_ac))
	 lib.add_rectangle(5*w, 7*w/2, w, w, style, false, false)	 
     lib.add_text(11*w/2, 4*w, temp2, text_style)
     temp3 = tostring(math.floor(summ_bc))
	 lib.add_rectangle(7*w/2, 6*w, w, w, style, false, false)	 
     lib.add_text(4*w, 13*w/2, temp3, text_style)
     lib.add_input(3*w+w/6, w, 50, 50, lib.check_number(a,30)) 
     lib.add_input(w-w/6, 6*w, 50, 50, lib.check_number(b,30)) 
     lib.add_input(6*w-w/3, 6*w, 50, 50, lib.check_number(c,30)) 
  end	

  if (ind == 2) then
     temp1 = tostring(math.floor(summ_ab))
	 lib.add_rectangle(2*w, 7*w/2, w, w, style, false, false)
     lib.add_text(5*w/2, 4*w, temp1, text_style)
     temp2 = tostring(math.floor(summ_ac))
	 lib.add_rectangle(5*w, 7*w/2, w, w, style, false, false)	 
     lib.add_text(11*w/2, 4*w, temp2, text_style)
     temp3 = tostring(math.floor(c))
	 lib.add_rectangle(6*w, 6*w, w, w, style, false, false)	 
     lib.add_text(13*w/2, 13*w/2, temp3, text_style)
     lib.add_input(3*w+w/6, w, 50, 50, lib.check_number(a,30)) 
     lib.add_input(w-w/6, 6*w, 50, 50, lib.check_number(b,30)) 
     lib.add_input(3*w+w/6, 6*w, 50, 50, 
	 lib.check_number(summ_bc,30)) 
  end
  
    if (ind == 3) then
     temp1 = tostring(math.floor(summ_ab))
	 lib.add_rectangle(2*w, 7*w/2, w, w, style, false, false)
     lib.add_text(5*w/2, 4*w, temp1, text_style)
     temp2 = tostring(math.floor(b))
	 lib.add_rectangle(w, 6*w, w, w, style, false, false)	 
     lib.add_text(3*w/2, 13*w/2, temp2, text_style)
     temp3 = tostring(math.floor(c))
	 lib.add_rectangle(6*w, 6*w, w, w, style, false, false)	 
     lib.add_text(13*w/2, 13*w/2, temp3, text_style)
     lib.add_input(3*w+w/6, w, 50, 50, lib.check_number(a,30)) 
     lib.add_input(5*w-w/3, 7*w/2, 50, 50, lib.check_number(summ_ac,30)) 	 
     lib.add_input(3*w+w/6, 6*w, 50, 50, 
	 lib.check_number(summ_bc,30))  
  end
  
  lib.end_canvas()
end
           
     