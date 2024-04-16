
include("terms") 

style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
red_style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "f30",
        ["line_width"] = "2"};	
		
dif_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};		
				
dot_style = {["font_size"] = "16"}
text_style = {["font_size"] = "14"}	

out = {""}
ans = {""}	
space = "\( \ \ \) "
 
numb = 2 + math.random(10)
pt = math.random(numb-1)

out[1] = "AB : CB" .. space .. "="  .. space .. lib.check_number(numb, 20) .. " : " .. lib.check_number(numb - pt, 20)
out[2] = "AC : AB" .. space .. "="  .. space .. lib.check_number(pt, 20) .. " : " .. lib.check_number(numb, 20)
out[3] = "CB : AC" .. space .. "="  .. space .. lib.check_number(numb - pt, 20) .. " : " .. lib.check_number(pt, 20)
ans = lib.math.random_shuffle(out)

if (numb > 4) then
    text = msg[2]
else
    text = msg[1]
end	
	

mycanvas = function(no)
 
  lib.start_canvas(250, 140, "center")
  
  ow = 8
  w = 200
  ov = 104
  v = 32
  
  step1 = math.floor(w/numb)
  last = w - v + math.random(2*v)
  step2 = math.floor(last/numb)
  
  lib.add_straight_path(ow, 3*ow, {{numb*step1, 0}}, style, true, false) 
  lib.add_straight_path(ow, 3*ow, {{numb*step2, ov}}, red_style, true, false) 
  
  for i = 1, numb do 
    lib.add_straight_path(ow+i*step1, 3*ow, {{i*(step2-step1), i*ov/numb}}, dif_style, false, true)
    lib.add_text(ow+i*step1, 2*ow, tostring(i), text_style, false, false) 
  end
  
  lib.add_text(ow, 2*ow, "A", dot_style, false, false) 
  lib.add_circle (ow, 3*ow, 3, dif_style, false, false)
  lib.add_text(2*ow+last, 3*ow+ov, "B", dot_style, false, false)
  lib.add_circle (ow+numb*step2, 3*ow+ov, 3, dif_style, false, false)	
  lib.add_text(ow+pt*step2, 4*ow + pt*ov/numb, "C", dot_style, false, false) 
  lib.add_circle (ow+pt*step2, 3*ow + pt*ov/numb, 3, dif_style, false, false)	  

  lib.end_canvas()
end           
                  
       