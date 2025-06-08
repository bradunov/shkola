
include("terms")

style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
blue_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "0cf",
        ["line_width"] = "5"};	

red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "3"};			

text_style = {["font_size"] = "16"}

len = {7, 5, 5, 5, 5, 2};    --[[a]]--
wid = {5, 7, 5, 5, 2, 7};    --[[b]]--
m2 = "m\(^2\)" 

len_a = {}
wid_b = {}
area = {}

mes = 5 * math.random(6)          
prop = 5*math.floor(160/mes)
fact = prop * mes/1000
	
for i = 1,6 do
    len_a[i] = lib.math.round_dec(len[i] * fact,3)
    wid_b[i] = lib.math.round_dec(wid[i] * fact,3)	
    area[i] = lib.math.round_dec(len_a[i] * wid_b[i],3)
end	


mycanvas = function()

  lib.start_canvas(350, 360, "center")

  dim_l = 13
  dim_w = 13
  
  w = 25
  ow = 10
  
  for i = 2,dim_w-1  do
     lib.add_line(ow+(i-1)*w, ow, 0, (dim_l-1)*w, style, false, false)
  end
  lib.add_line(ow, ow, 0, (dim_l-1)*w, red_style, false, false)
  lib.add_line(ow+(dim_w-1)*w, ow, 0, (dim_l-1)*w, red_style, false, false)
	 
  for j = 2,dim_l-1 do
    lib.add_line(ow, ow+(j-1)*w, (dim_w-1)*w, 0, style, false, false)
  end
  lib.add_line(ow, ow, (dim_w-1)*w, 0, red_style, false, false)
  lib.add_line(ow, ow+(dim_l-1)*w, (dim_w-1)*w, 0, red_style, false, false)
 
  lib.add_line(ow, ow+5*w, 7*w, 0, red_style, false, false)
  lib.add_line(ow+7*w, ow+7*w, 5*w, 0, red_style, false, false)
  lib.add_line(ow, ow+10*w, 5*w, 0, red_style, false, false)
  lib.add_line(ow+5.5*w, ow+5*w, w, 0, blue_style, false, false)
  lib.add_line(ow+5.5*w, ow+(dim_l-1)*w-5, w, 0, blue_style, false, false)
  lib.add_line(ow+5.5*w, ow+(dim_l-1)*w+5, w, 0, blue_style, false, false)

  lib.add_line(ow+7*w, ow, 0, 12*w,  red_style, false, false)    
  lib.add_line(ow+5*w, ow+5*w, 0, 7*w,  red_style, false, false) 
  lib.add_line(ow+5*w, ow+7*w, 0, w, blue_style, false, false)  
  lib.add_line(ow+5*w, ow+10*w, 0, w, blue_style, false, false)  
  lib.add_line(ow+7*w, ow+5.5*w, 0, w, blue_style, false, false)  
  lib.add_line(ow+7*w, ow+10*w, 0, w, blue_style, false, false)  

  lib.add_input(w, 2*ow, 120, 30, name[1])
  lib.add_text(2*w, 2*w, "a = ", text_style, false, false)
  lib.add_input(2*w+ow, 2*w-ow, 60, 30, lib.check_number(len_a[1], 40))
  lib.add_text(2*w, 3*w, "b = ", text_style, false, false)
  lib.add_input(2*w+ow, 3*w-ow, 60, 30, lib.check_number(wid_b[1], 40))  
  lib.add_text(2*w, 4*w, "P = ", text_style, false, false)
  lib.add_input(2*w+ow, 4*w-ow, 60, 30, lib.check_number(area[1], 40))  


  lib.add_input(7*w+ow, 2*ow, 120, 30, name[2])
  lib.add_text(9*w, 2*w, "a = ", text_style, false, false)
  lib.add_input(9*w+ow, 2*w-ow, 60, 30, lib.check_number(len_a[2], 40))  
  lib.add_text(9*w, 3*w, "b = ", text_style, false, false)
  lib.add_input(9*w+ow, 3*w-ow, 60, 30, lib.check_number(wid_b[2], 40))   
  lib.add_text(9*w, 4*w, "P = ", text_style, false, false)
  lib.add_input(9*w+ow, 4*w-ow, 60, 30, lib.check_number(area[2], 40))   

  lib.add_input(7*w+ow, 8*w, 120, 30, name[3])
  lib.add_text(9*w, 9*w, "a = ", text_style, false, false)
  lib.add_input(9*w+ow, 9*w-ow, 60, 30, lib.check_number(len_a[3], 40))   
  lib.add_text(9*w, 10*w, "b = ", text_style, false, false)
  lib.add_input(9*w+ow, 10*w-ow, 60, 30, lib.check_number(wid_b[3], 40))  
  lib.add_text(9*w, 11*w, "P = ", text_style, false, false)
  lib.add_input(9*w+ow, 11*w-ow, 60, 30, lib.check_number(area[3], 40))  

  lib.add_input(w, 14*ow, 80, 30, name[4])
  lib.add_text(2*w, 7*w, "a = ", text_style, false, false)
  lib.add_input(2*w+ow, 7*w-ow, 60, 30, lib.check_number(len_a[4], 40))  
  lib.add_text(2*w, 8*w, "b = ", text_style, false, false)
  lib.add_input(2*w+ow, 8*w-ow, 60, 30, lib.check_number(wid_b[4], 40))   
  lib.add_text(2*w, 9*w, "P = ", text_style, false, false)
  lib.add_input(2*w+ow, 9*w-ow, 60, 30, lib.check_number(area[4], 40))    

  lib.add_input(w, 27*ow, 100, 30, name[5])
  lib.add_text(2*w, 12*w, "a = ", text_style, false, false)
  lib.add_input(2*w+ow, 12*w-ow, 60, 30, lib.check_number(len_a[5], 40))   
  lib.add_text(2*w, 13*w, "b = ", text_style, false, false)
  lib.add_input(2*w+ow, 13*w-ow, 60, 30, lib.check_number(wid_b[5], 40))     
  lib.add_text(2*w, 14*w, "P = ", text_style, false, false)
  lib.add_input(2*w+ow, 14*w-ow, 60, 30, lib.check_number(area[5], 40))  

  lib.add_input(4*w, 14*ow, 120, 30, name[6])
  lib.add_text(6*w-ow, 7*w, "a = ", text_style, false, false)
  lib.add_input(6*w, 7*w-ow, 60, 30, lib.check_number(len_a[6], 40))   
  lib.add_text(6*w-ow, 8*w, "b = ", text_style, false, false)
  lib.add_input(6*w, 8*w-ow, 60, 30, lib.check_number(wid_b[6], 40))   
  lib.add_text(6*w-ow, 9*w, "P = ", text_style, false, false)
  lib.add_input(6*w, 9*w-ow, 60, 30, lib.check_number(area[6], 40))  
   
  lib.end_canvas()
end                
     