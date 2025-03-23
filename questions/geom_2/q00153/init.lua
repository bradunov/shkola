
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
blue_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "0cf",
        ["line_width"] = "2"};	

red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "2"};			
	
text_style = {["font_size"] = "14"}
symb_style = {["font_size"] = "20"}

ang = {"∡", "⦝"}
space = "\( \ \ \ \) "

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

ydim = total + 4

mycanvas = function()

  lib.start_canvas(320, 250, "center")

  w = math.floor(300/ydim) 
  ow = 10

  lib.add_line(ow+w, ow+2*w, 0, max*w, red_style, false, false)
  lib.add_line(ow+w, ow+2*w, min*w, max*w, red_style, false, false)  
  lib.add_line(ow+w, ow+(max+2)*w, min*w, 0, red_style, false, false)
  ind = math.random(2)
  cor = 5 - math.random(11) 
  if (cor == 0) then
      ind = 1
  end
  xx = total - min + cor  
  if ((min + xx) * w > 280) then
      xx = total - min - cor
  end	   
  yy = -min/max * xx

  lib.add_line(ow+(min +1)*w, ow+(max+2)*w, (xx)*w, 0, blue_style, false, false)  
  if (ind == 1) then
	  lib.add_line(ow+(min +1+xx)*w, ow+(max+2)*w, 0, yy*w, blue_style, false, false)
	  lib.add_line(ow+(min+1)*w, ow+(max+2)*w, xx*w, yy*w, blue_style, false, false)  
	  pt = yy
  else
	  lib.add_line(ow+(min +1+xx)*w, ow+(max+2)*w, 0, -min*w, blue_style, false, false)
	  lib.add_line(ow+(min+1)*w, ow+(max+2)*w, xx*w, -min*w, blue_style, false, false) 
	  pt = -min
  end
  
  reply = ""
  note = ""
  if (ind == 1) then
	  lib.add_input((min -1)*w+ow+5,(max+2)*w-ow-5, 50, 50, ang[2]) 
	  note = text
	  reply = ang[1] .. "BAO".. lib.check_one_option_dropdown(ans, ans[ind]) .. ang[1] .. lib.check_string_case("COD", 30) .. ", " .. space .. ang[1] .. "AOB" .. lib.check_one_option_dropdown(ans, ans[ind]) .. ang[1] .. lib.check_string_case("ODC", 30) 
  end  
  
  lib.add_text(ow+w, ow+w+3, "A", text_style)    
  lib.add_text(ow+w, 2*ow+(max+2)*w, "B", text_style)   
  lib.add_text(ow+(min +1)*w, 2*ow+(max+2)*w, "O", text_style)  
  lib.add_text(ow+(min+1)*w+(xx)*w, 2*ow+(max+2)*w, "C", text_style)    
  lib.add_text(ow+(min+1)*w+(xx)*w, ow+(max+pt+1)*w+3, "D", text_style) 
  lib.add_circle (ow+w, 2*ow+w+5, 3, style,false, false ) 
  lib.add_circle (ow+w, ow+(max+2)*w, 3, style,false, false )  
  lib.add_circle (ow+(min+1)*w, ow+(max+2)*w, 3, style,false, false ) 
  lib.add_circle (ow+(min+1)*w+(xx)*w, ow+(max+2)*w, 3, style,false, false )  
  lib.add_circle (ow+(min+1)*w+(xx)*w, 2*ow+(max+pt+1)*w+5, 3, style,false, false )   
 
  lib.end_canvas()
end        