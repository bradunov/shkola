
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
	
text_style = {["font_size"] = "16"}


res_b = 5 + math.random(7);    --[[K]]--
res_v = 2 + math.random(7)      --[[O]]--
res_f = 8 + math.random(7)      --[[F]]--

res_bv = 6 + math.random(5);    --[[(K+O)\F]]--
res_fb = 5 + math.random(10);    --[[(F+K)\O]]--
res_fv = 4 + math.random(7);     --[[(F+O)\K]]--
res_3 = 2 + math.random(5);   --[[F+K+O]]--

vel_bv = res_bv + res_3   --[[K+O]]--
vel_fv = res_fv + res_3   --[[F+O]]--
vel_fb = res_fb + res_3   --[[F+K]]--

volley =  res_bv + res_fv + res_3 + res_v
basket = res_bv + res_fb + res_3 + res_b
foot = res_fv + res_fb + res_3 + res_f

res_2 = res_bv + res_fb + res_fv

number = res_b + res_v + res_f + res_bv + res_fv + res_fb + res_3   
vel = res_f + res_v + res_fv                 
 
 
mycanvas = function(no)
  lib.start_canvas(350, 180, "center")

  ov = 40
  ow = 10
  w = 5
  
  lib.add_ellipse(5*ov, 2*ov-ow, 2*ov-ow, ov+ow,  line_blue, false, false) 
  lib.add_text(6*ov, ow, "košarka", text_style)

  lib.add_ellipse(3*ov+ow, 2*ov-ow, 2*ov-ow, ov+ow, line_green, false, false)	  
  lib.add_text(2*ov, ow, "fudbal", text_style)

  lib.add_ellipse(4*ov, 3*ov, 2*ov-ow, ov+ow, line_red, false, false)	  
  lib.add_text(6*ov, 4*ov, "odbojka", text_style)	  

  lib.add_input(2*ov, ov, 30, 30, lib.check_number(res_f,15))	  
  lib.add_input(4*ov-ow, ov, 30, 30, lib.check_number(res_fb,15))
  lib.add_input(5*ov+2*ow, ov, 30, 30, lib.check_number(res_b,15))	
  lib.add_input(3*ov-ow-w, 2*ov+ow, 30, 30, lib.check_number(res_fv,15))
  lib.add_input(4*ov-ow, 2*ov, 30, 30, lib.check_number(res_3,15))
  lib.add_input(5*ov-ow-w, 2*ov+ow, 40, 30, lib.check_number(res_bv,15))
  lib.add_input(4*ov-ow, 3*ov+ow, 30, 30, lib.check_number(res_v,15))  
        
  lib.end_canvas()
end                        
              
          
